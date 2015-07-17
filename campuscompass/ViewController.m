//
//  ViewController.m
//  campuscompass
//
//  Created by Local Administrator on 21/03/15.
//  Copyright (c) 2015 Local Administrator. All rights reserved.
//

#import "ViewController.h"
#import "MapCampusViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize campus;
@synthesize campusNameDisplay;
@synthesize campusAddressDisplay;
@synthesize campusPostaleCodeDisplay;
@synthesize campusCityDisplay;
@synthesize mapView;
@synthesize xCoordonates;
@synthesize yCoordonates;

- (void)viewDidLoad
{

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//DATAS AND ELEMENTS WILL APPEAR
- (void)viewWillAppear:(BOOL)animated
{
    //The name the campus will be written here
    NSMutableString *nameOfCampus = [[NSMutableString alloc] initWithString:@"SUPINFO "];
    //For write "SUPINFO + campus name"
    [nameOfCampus appendString:self.campusNameDisplay];
    
    [super viewWillAppear:animated];
    
//BEGIN -- Set the label with campus details
    
    [self.UIOutLetName setText: nameOfCampus];
    [self.UIOutLetAddress setText:self.campusAddressDisplay];
    [self.UIOutLetPostaleCode setText:self.campusPostaleCodeDisplay];
    [self.UIOutLetCity setText:self.campusCityDisplay];

//END --
    
//BEGIN -- Map view

    //Type the map, standard here
    mapView.mapType = MKMapTypeStandard;
    
    //For localizing the campus
    CLLocationCoordinate2D locationCoordinate = {.latitude=self.yCoordonates,.longitude=self.xCoordonates};
    MKCoordinateSpan coodinateSpan = {.latitudeDelta=0.01,.longitudeDelta=0.01};
    
    //Localisation of the campus on the map view
    MKCoordinateRegion coordinateRegion = {locationCoordinate,coodinateSpan};
    
    //Display the region by the precedent line
    [mapView setRegion:coordinateRegion];
    
    //Display the map view
    [self.view addSubview:mapView];

//END --
    
//BEGIN -- Annotation point on the map view
    
    //Initialize the annotation point
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    //Set the coordinates to the annotation point
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.yCoordonates, self.xCoordonates);
    //Initialize the annotation string the the annotation point
    NSMutableString *annotationString = [[NSMutableString alloc] initWithString:@"Campus de "];
    //Add the campus name to the annotation string
    [annotationString appendString:self.campusNameDisplay];
    
    //Set the annotation string to the annotation point title
    pointAnnotation.title = annotationString;
    
    //Display the annotation point
    [mapView addAnnotation:pointAnnotation];

//END --
}

@end
