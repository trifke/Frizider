//
//  BiranjeReceptaViewController.h
//  lunchschedule
//
//  Created by Filip Rajicic on 6/6/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BiranjeReceptaDelegate

- (void)dodaoRecept:(NSDictionary*)recept;
- (void)skinuoRecept:(NSString*)receptName;

@optional

@end

@interface BiranjeReceptaViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray* arrDodatiRecepti;

@property (weak, nonatomic) id<BiranjeReceptaDelegate> delegate;

@end
