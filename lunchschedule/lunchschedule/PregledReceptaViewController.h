//
//  PregledReceptaViewController.h
//  lunchschedule
//
//  Created by Filip Rajicic on 6/6/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoviReceptViewController.h"
#import "BiranjeReceptaViewController.h"

@interface PregledReceptaViewController : UIViewController<UITableViewDataSource, NoviReceptDelegate>

@property (strong, nonatomic) NSMutableDictionary* dictRecept;
@property (strong, nonatomic) IBOutlet UITextView *txtOpis;
@property (strong, nonatomic) IBOutlet UITextView *txtPriprema;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *btnIzmeniGui;

@property (assign, nonatomic) BOOL btnIzmeniIsHidden;

- (IBAction)btnIzmeni:(UIButton *)sender;

@end
