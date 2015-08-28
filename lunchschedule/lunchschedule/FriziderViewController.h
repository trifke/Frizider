//
//  FriziderViewController.h
//  lunchschedule
//
//  Created by Filip Rajicic on 5/27/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiranjeSastojakaZaFrizViewController.h"

@interface FriziderViewController : UIViewController<UITableViewDataSource, BiranjeSastojakaZaFrizDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
