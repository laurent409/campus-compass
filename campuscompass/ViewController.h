//
//  ViewController.h
//  campuscompass
//
//  Created by Local Administrator on 21/03/15.
//  Copyright (c) 2015 Local Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Campus.h"
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController {
    
    NSString *campusNameDisplay;
    NSString *campusAddressDisplay;
    NSString *campusPostaleCodeDisplay;
    NSString *campusCityDisplay;
    
    double xCoordonates;
    double yCoordonates;
}

@property (weak, nonatomic) IBOutlet UILabel *UIOutLetName;
@property (weak, nonatomic) IBOutlet UILabel *UIOutLetAddress;
@property (weak, nonatomic) IBOutlet UILabel *UIOutLetPostaleCode;
@property (weak, nonatomic) IBOutlet UILabel *UIOutLetCity;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property( nonatomic, strong ) Campus *campus;

@property (nonatomic, strong)NSString *campusNameDisplay;
@property (nonatomic, strong)NSString *campusAddressDisplay;
@property (nonatomic, strong)NSString *campusPostaleCodeDisplay;
@property (nonatomic, strong)NSString *campusCityDisplay;
@property (nonatomic, assign)double xCoordonates;
@property (nonatomic, assign)double yCoordonates;


@end
