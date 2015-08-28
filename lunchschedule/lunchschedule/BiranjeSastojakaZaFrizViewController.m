//
//  testKlasaViewController.m
//  lunchschedule
//
//  Created by Filip Rajicic on 5/27/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import "BiranjeSastojakaZaFrizViewController.h"
#import "FriziderSingleton.h"

@interface BiranjeSastojakaZaFrizViewController ()

@property UISearchController *searchController;

@end

NSArray* arr;
NSArray* arrForFilter;
UITableViewController* tvcontrol;

@implementation BiranjeSastojakaZaFrizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arr = [[FriziderSingleton sharedInstance]dohvatiSveSastojke];
    
    UITableViewController *searchResultsController = [[UITableViewController alloc] init];
    searchResultsController.tableView = self.tableView;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.navigationItem.titleView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    searchResultsController.tableView.dataSource = self;
    searchResultsController.tableView.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    arrForFilter = nil;
}

#pragma mark - Table view

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (arrForFilter && arrForFilter.count != 0){
        return arrForFilter.count;
    }else{
        return arr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (arrForFilter && arrForFilter.count != 0){
        cell.textLabel.text = arrForFilter[indexPath.row];
    }else{
        cell.textLabel.text = arr[indexPath.row];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    for (NSString* sastojak in self.odabraniSastojci) {
        if ([sastojak isEqualToString:cell.textLabel.text]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark){
        cell.accessoryType = UITableViewCellAccessoryNone;
        for (int i=0; i<self.odabraniSastojci.count; i++) {
            if ([self.odabraniSastojci[i] isEqualToString:cell.textLabel.text]){
                [self.odabraniSastojci removeObjectAtIndex:i];
                break;
            }
        }
        [self.delegate obrisaoSastojak:cell.textLabel.text];
    }else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.odabraniSastojci addObject:cell.textLabel.text];
        [self.delegate dodaoSastojak:cell.textLabel.text];
    }
    [self.tableView reloadData];
}

#pragma mark - Search

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString* str = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", str];
    arrForFilter = [arr filteredArrayUsingPredicate:predicate];
    
    [self.tableView reloadData];
}


@end
