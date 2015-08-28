//
//  testKlasaViewController.h
//  lunchschedule
//
//  Created by Filip Rajicic on 5/27/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BiranjeSastojakaZaFrizDelegate

- (void)dodaoSastojak:(NSString*)naziv;
- (void)obrisaoSastojak:(NSString*)naziv;

@end

@interface BiranjeSastojakaZaFrizViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* odabraniSastojci;

@property (nonatomic, weak) id <BiranjeSastojakaZaFrizDelegate> delegate;

@end
