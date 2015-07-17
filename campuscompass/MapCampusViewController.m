//
//  MapCampusViewController.m
//  campuscompass
//
//  Created by Local Administrator on 24/03/15.
//  Copyright (c) 2015 Local Administrator. All rights reserved.
//

#import "MapCampusViewController.h"

@interface MapCampusViewController ()

@end

@implementation MapCampusViewController

@synthesize campusNameDisplay;
@synthesize xCoordonates;
@synthesize yCoordonates;

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    	
}
@end
