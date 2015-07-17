//
//  CampusListTableViewController.h
//  campuscompass
//
//  Created by Local Administrator on 21/03/15.
//  Copyright (c) 2015 Local Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampusListTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

//@property NSMutableArray *array;
@property( nonatomic, strong ) NSMutableArray *campus;

@end
