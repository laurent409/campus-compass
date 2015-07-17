//
//  Campus.h
//  campuscompass
//
//  Created by Local Administrator on 23/03/15.
//  Copyright (c) 2015 Local Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Campus : NSObject

@property (nonatomic, strong) NSNumber *campusId;
@property (nonatomic, strong) NSString *campusName;
@property (nonatomic, strong) NSString *campusAddress;
@property (nonatomic, strong) NSString *campusPostalCode;
@property (nonatomic, strong) NSString *campusCity;
@property (nonatomic, strong) NSString *campusXLocation;
@property (nonatomic, strong) NSString *campusYLocation;



@end
