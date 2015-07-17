//
//  CompassViewController.h
//  campuscompass
//
//  Created by Local Administrator on 25/03/15.
//  Copyright (c) 2015 Local Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeoPointCompass.h"

@interface CompassViewController : UIViewController <CLLocationManagerDelegate> {
    
}

@property (weak, nonatomic) IBOutlet UILabel *UIOutletDistanceNearestCampus;
@property (weak, nonatomic) IBOutlet UILabel *UIOutletNearestCampus;


@property (nonatomic, strong)NSString *campusNameDisplay;
@property (nonatomic, strong)NSString *distanceNearestCampusDisplay;

@end
