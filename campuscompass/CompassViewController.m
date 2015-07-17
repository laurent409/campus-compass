//
//  CompassViewController.m
//  campuscompass
//
//  Created by Local Administrator on 25/03/15.
//  Copyright (c) 2015 Local Administrator. All rights reserved.
//

#import "CompassViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface CompassViewController ()

@end

@implementation CompassViewController {

    CLLocationManager *locationManager;
    
    NSMutableArray *infoCampus;
    NSMutableArray *listCampus;
    

}

GeoPointCompass *geoPointCompass;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Check if the location is enable
    if ([CLLocationManager locationServicesEnabled]) {
        
        //For starting the localisation
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
        
        //Stop the localisation
        
//      /!\ FOR TESTING WITH A SIMULATOR COMMENT THIS LINE /!\
        
        [locationManager stopUpdatingLocation];
        
        
    } else {
        NSLog(@"Enable location service..");
    }
}

//GET ALL CAMPUS NAME AND LOCALISATION
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    //For the localisation of iPhone
    CLLocation *location = newLocation;
  
    //Initialization of the image view (the compass)
    UIImageView *compassView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    
    //Set the image of compass to the image view
    compassView.image = [UIImage imageNamed:@"11063069_10205431013388500_1099263665_n-2.png"];
    
    //Display the image view (compass)
    [self.view addSubview:compassView];
    
    //Initialize the object GeoPointCompass from the library
    geoPointCompass = [[GeoPointCompass alloc] init];
    
    [geoPointCompass setArrowImageView:compassView];
    
    //The campus will appear in label
    NSString *campusNearest = [[NSString alloc] init];
    
    //Get all campus from the API
    listCampus = [self getCampus:@"http://31.220.4.186:8080/?campus=all"];
    
    //Array with all campus
    NSMutableArray *allCampus = [[NSMutableArray alloc] init];
    
    //The distance will appear in label
    NSString *distanceWillAppear = [[NSString alloc] init];
    
    //The begin of the campus will appear (for doing a sentence)
    NSMutableString *nearestCampus = [[NSMutableString alloc] initWithString:@"Nearest Campus : "];
    
    //The double for comparing the distance (I set the Earth circumference)
    NSNumber *finalDistance = [[NSNumber alloc] initWithDouble:40075];
    
    //Localisation of the device
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    
    //For turning the compass image
    double targetLatitude;
    double targetLongitude;
    
    //Loop which get all campus by the key "campus"
    for (NSMutableString *campus in [listCampus valueForKey:@"campus"])
    {
        //Initialize the url string for passing each campus name into the string and getting campus details for each campus
        NSMutableString *urlForGetInfosCampus = [[NSMutableString alloc] initWithString:@"http://31.220.4.186:8080/?campus="];

        //Add each campus object in mutable array
        [allCampus addObject:campus];
        
        //Pass each campus into the url string
        [urlForGetInfosCampus appendString:campus];
        
        //Get all details for each campus from the API
        infoCampus = [self getCampus:urlForGetInfosCampus];
   
    //BEGIN -- Get details for each campus by the localisation key

        NSObject *campusLocalisation = [infoCampus valueForKey:@"localisation"];
        
        //From the precedent line, get the longitude
        NSString *xLocalisationCampus = [campusLocalisation valueForKey:@"lng"];
        
        //From the precedent line, get the latitude
        NSString *yLocalisationCampus = [campusLocalisation valueForKey:@"lat"];
    
    //END --
    
    //BEGIN -- Calcul the distance
        
        //Initialize the campus location
        CLLocation *campusLocation = [[CLLocation alloc] initWithLatitude:[yLocalisationCampus doubleValue] longitude:[xLocalisationCampus doubleValue]];
        
        //Calcul the distance beetween the campus and the device
        CLLocationDistance distanceMeCampus = [myLocation distanceFromLocation:campusLocation]/ 1000;
        
        //Transforme type : double => NSNumber
        [NSNumber numberWithDouble:distanceMeCampus];
        
        //Round the distance
        distanceMeCampus = round(distanceMeCampus);
        
        //For testing the distance
        NSNumber *testDistance = [[NSNumber alloc] initWithDouble:distanceMeCampus];
        
    //BEGIN -- Test the distance beetween the precedent distance
        
        if ( [testDistance doubleValue] <= [finalDistance doubleValue]) {
            
            //Changed by the smallest distance
            finalDistance =  testDistance;
            //Campus which is the nearest (because the distance is the smallest
            campusNearest = campus;
            //For limiting decimal digits
            distanceWillAppear = [NSString stringWithFormat:@"%@",finalDistance];
            
        //BEGIN -- Put the latitude and longitude to the Geo Point Compass
        
            targetLatitude = [yLocalisationCampus doubleValue];
            targetLongitude = [xLocalisationCampus doubleValue];
        
        //END --
            
        }
        
    //END --
        
    }
    
    //Add "km" at the end of the sentence
    NSString *finalDistanceWillAppear = [distanceWillAppear stringByAppendingString:@" km"];
    //Add the campus name at the end of the sentence
    [nearestCampus appendString:campusNearest];
    
//BEGIN -- Set text on the two labels (campus and distance)
    
    [self.UIOutletNearestCampus setText:nearestCampus];
    [self.UIOutletDistanceNearestCampus setText:finalDistanceWillAppear];

//END --
    
//BEGIN -- Target location for Geo Point Campus
    
    geoPointCompass.latitudeOfTargetedPoint = targetLatitude;
    geoPointCompass.longitudeOfTargetedPoint = targetLongitude;

//END

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Erreur : %@", error);
}

#pragma mark - Getting objects
//RETURN ARRAY OF OBJECTS FROM THE API
- (NSMutableArray *)getCampus: (NSString *)urlCon {
    NSURL * url = [[NSURL alloc] initWithString:urlCon];
    
    //Set the request
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];

//BEGIN -- Send the request

    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];

//END --
    
    //Set all objects from JSON into an array
    NSArray* object = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:&error];

    //Return this array
    return object;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
