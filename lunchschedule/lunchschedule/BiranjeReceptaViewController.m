//
//  BiranjeReceptaViewController.m
//  lunchschedule
//
//  Created by Filip Rajicic on 6/6/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import "BiranjeReceptaViewController.h"
#import "ReceptiSingleton.h"

@interface BiranjeReceptaViewController ()

@property (strong, nonatomic) NSMutableArray* recepti;
@property (strong, nonatomic) NSMutableArray* receptiFiltered;
@property (strong, nonatomic) UISearchController* searchController;

@end

@implementation BiranjeReceptaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSArray* receptiSvi = [[ReceptiSingleton sharedInstance]dohvatiRecepte];
    self.recepti = [NSMutableArray new];
    for (int i=0; i<receptiSvi.count; i++) {
        NSMutableDictionary* receptCheckedDict = [NSMutableDictionary new];
        [receptCheckedDict setValue:receptiSvi[i] forKey:@"Recept"];
        NSString* receptName = [receptiSvi[i] valueForKey:@"Naziv"];
        NSNumber* numberToSet = @0;
        for (NSDictionary* receptDict in self.arrDodatiRecepti) {
            if ([receptName isEqualToString:[receptDict valueForKey:@"Naziv"]]){
                numberToSet = @1;
                break;
            }
        }
        [receptCheckedDict setValue:numberToSet forKey:@"Checked"];
        [self.recepti addObject:receptCheckedDict];
    }
    
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
    self.receptiFiltered = nil;
}

#pragma mark - Table view

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.receptiFiltered!=NULL){
        return self.receptiFiltered.count;
    }else if (self.recepti!=NULL){
        return self.recepti.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (self.receptiFiltered !=nil){
        cell.textLabel.text = [[self.receptiFiltered[indexPath.row] valueForKey:@"Recept"]valueForKey:@"Naziv"];
        if ([[self.receptiFiltered[indexPath.row]valueForKey:@"Checked"] isEqual: @0]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }else{
        cell.textLabel.text = [[self.recepti[indexPath.row] valueForKey:@"Recept"]valueForKey:@"Naziv"];
        if ([[self.recepti[indexPath.row]valueForKey:@"Checked"] isEqual: @0]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.receptiFiltered!=nil){
        NSNumber* changedNum;
        if ([[self.receptiFiltered[indexPath.row]valueForKey:@"Checked"] isEqual:@0]){
            [self.receptiFiltered[indexPath.row]setValue:@1 forKey:@"Checked"];
            [self.delegate dodaoRecept:[self.receptiFiltered[indexPath.row]valueForKey:@"Recept"]];
            changedNum = @1;
        }else{
            [self.receptiFiltered[indexPath.row]setValue:@0 forKey:@"Checked"];
            [self.delegate skinuoRecept:[[self.receptiFiltered[indexPath.row]valueForKey:@"Recept"]valueForKey:@"Naziv"]];
            changedNum = @0;
        }
        NSString* changedReceptName = [[self.receptiFiltered[indexPath.row] valueForKey:@"Recept"]valueForKey:@"Naziv"];
        for (int i=0; i<self.recepti.count; i++) {
            NSDictionary* receptCheckedDict = self.recepti[i];
            if ([[[receptCheckedDict valueForKey:@"Recept"]valueForKey:@"Naziv"] isEqualToString:changedReceptName]){
                [self.recepti[i] setValue:changedNum forKey:@"Checked"];
            }
        }
    }else{
        if ([[self.recepti[indexPath.row]valueForKey:@"Checked"] isEqual:@0]){
            [self.recepti[indexPath.row]setValue:@1 forKey:@"Checked"];
            [self.delegate dodaoRecept:[self.recepti[indexPath.row]valueForKey:@"Recept"]];
        }else{
            [self.recepti[indexPath.row]setValue:@0 forKey:@"Checked"];
            [self.delegate skinuoRecept:[[self.recepti[indexPath.row]valueForKey:@"Recept"]valueForKey:@"Naziv"]];
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - search delegate

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString* str = searchController.searchBar.text;
    if (![str isEqualToString:@""]){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF['Recept']['Naziv'] contains[c] %@", str];
        self.receptiFiltered = [[self.recepti filteredArrayUsingPredicate:predicate] mutableCopy];
        [self.tableView reloadData];
    }else{
        self.receptiFiltered = nil;
    }
    [self.tableView reloadData];
}

@end
