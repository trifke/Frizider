//
//  ReceptiViewController.h
//  lunchschedule
//
//  Created by Filip Rajicic on 5/28/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoviReceptViewController.h"

@interface ReceptiViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NoviReceptDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
