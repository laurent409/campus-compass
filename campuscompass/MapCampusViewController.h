//
//  MapCampusViewController.h
//  campuscompass
//
//  Created by Local Administrator on 24/03/15.
//  Copyright (c) 2015 Local Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapCampusViewController : UIViewController {
    
    NSString *campusNameDisplay;
    double xCoordonates;
    double yCoordonates;
    MKMapView *mapView;
}

@property (nonatomic, strong)NSString *campusNameDisplay;
@property (nonatomic, assign)double xCoordonates;
@property (nonatomic, assign)double yCoordonates;

@end
