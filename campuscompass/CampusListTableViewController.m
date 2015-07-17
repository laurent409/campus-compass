//
//  CampusListTableViewController.m
//  campuscompass
//
//  Created by Local Administrator on 21/03/15.
//  Copyright (c) 2015 Local Administrator. All rights reserved.
//

#import "CampusListTableViewController.h"
#import "ViewController.h"
#import "Campus.h"

@interface CampusListTableViewController () {
    
    NSMutableArray *listCampus;
    NSUInteger *nbOfCampus;
    NSMutableArray *infoCampus;
}

@end

@implementation CampusListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//GET ALL CAMPUS + DETAILS FOR EACH CAMPUS
- (void)viewDidLoad
{
    //Get all campus from the API
    listCampus = [self getCampus:@"http://31.220.4.186:8080/?campus=all"];
    
    //Array with all campus
    NSMutableArray *allCampus = [[NSMutableArray alloc] init];
    
    //Set campus in this array for the loop-for
    self.campus = [[NSMutableArray alloc] init];
    
    //For counting campus ids
    int idCampus = 0;
    
    //Loop which get all campus by the key "campus"
    for (NSMutableString *campus in [listCampus valueForKey:@"campus"])
    {
        
        //Initialize the url string for passing each campus name into the string and getting campus details for each campus
        NSMutableString *urlForGetInfosCampus = [[NSMutableString alloc] initWithString:@"http://31.220.4.186:8080/?campus="];
        
        //Pass each campus into the url string
        [urlForGetInfosCampus appendString:campus];
        
        //Add each campus object in mutable array
        [allCampus addObject:campus];
        
        //Get all details for each campus from the API
        infoCampus = [self getCampus:urlForGetInfosCampus];
        
    //BEGIN -- Get details for each campus by the adress key
        
        NSObject *campusAdresse = [infoCampus valueForKey:@"adresse"];
        
        //From the precedent line, get the street
        NSString *rueCampus = [campusAdresse valueForKey:@"rue"];
        
        //From the precedent line, get the zip code
        NSString *codePostaleCampus = [campusAdresse valueForKey:@"codepostale"];
    
        //From the precedent line, get the zip code
        NSString *villeCampus = [campusAdresse valueForKey:@"ville"];
    
    //END --
        
    //BEGIN -- Get details for each campus by the localisation key
        
        NSObject *campusLocalisation = [infoCampus valueForKey:@"localisation"];
        
        //From the precedent line, get the longitude
        NSString *xLocalisationCampus = [campusLocalisation valueForKey:@"lng"];
        
        //From the precedent line, get the latitude
        NSString *yLocalisationCampus = [campusLocalisation valueForKey:@"lat"];
        
    //END --
        
        //Initialize new object Campus
        Campus *campusObject = [[Campus alloc] init];
        
    //BEGIN -- Set all details into this object
        
        [campusObject setCampusId:[NSNumber numberWithInt:idCampus]];
        
        [campusObject setCampusName:campus];
        [campusObject setCampusAddress:rueCampus];
        [campusObject setCampusPostalCode:codePostaleCampus];
        [campusObject setCampusCity:villeCampus];
        [campusObject setCampusXLocation:xLocalisationCampus];
        
        [campusObject setCampusYLocation:yLocalisationCampus];
    //END --
        
        //Add each campus object into the array
        [self.campus addObject:campusObject];
        
        //Increment this variable for the idCampus
        idCampus++;
        
    }
    
    [super viewDidLoad];

    
}

#pragma mark - Getting objects

//RETURN ARRAY OF OBJECTS FROM THE API
-(NSMutableArray *)getCampus: (NSString *)urlCon {
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return [self.campus count];
}

//DATAS WHICH WILL APPEAR IN EACH CELL VIEW
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Set the cell identifier
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Set the label of the cell (Name + Subname)
    cell.textLabel.text = [[self.campus objectAtIndex:[indexPath row]] campusName];
    cell.detailTextLabel.text = [[self.campus objectAtIndex:[indexPath row]] campusAddress];
    
    //Return each cell with datas
    return cell;
}



/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    ViewController *viewController = (ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"ViewController"];
    
    [viewController setTitle:[[self.campus objectAtIndex:[indexPath row]] campusName]];
    [viewController setCampus:[self.campus objectAtIndex:[indexPath row]]];
    
    [self.navigationController pushViewController:viewController animated:YES];
}
*/

#pragma mark - Navigation
//SEND DATAS INTO THE DETAIL VIEW CONTROLLER FOR EACH CELL (CAMPUS)
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Verification if we are in the right segue
    if ([segue.identifier isEqualToString:@"detailsForSegue"]) {
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        ViewController *controller = segue.destinationViewController;
        controller = [segue destinationViewController];
        
    //BEGIN -- Send datas into the related view
        controller.campusNameDisplay = [[self.campus objectAtIndex:[path row]] campusName];
        controller.campusAddressDisplay = [[self.campus objectAtIndex:[path row]] campusAddress];
        controller.campusPostaleCodeDisplay = [[self.campus objectAtIndex:[path row]] campusPostalCode];
        controller.campusCityDisplay = [[self.campus objectAtIndex:[path row]] campusCity];
        controller.xCoordonates = [[[self.campus objectAtIndex:[path row]] campusXLocation] doubleValue];
        controller.yCoordonates = [[[self.campus objectAtIndex:[path row]] campusYLocation] doubleValue];
    //END --
    
    }
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}


@end
