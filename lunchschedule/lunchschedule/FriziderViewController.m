//
//  FriziderViewController.m
//  lunchschedule
//
//  Created by Filip Rajicic on 5/27/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import "FriziderViewController.h"
#import "FriziderSingleton.h"

@interface FriziderViewController ()

@property (strong, nonatomic) NSMutableArray* sastojci;

@end

@implementation FriziderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.sastojci = [[[FriziderSingleton sharedInstance] uzmiSastojkeIzFrizidera] mutableCopy];
}

#pragma mark - Table view

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sastojci.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"sastojciCell"];
    
    cell.textLabel.text = self.sastojci[indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[FriziderSingleton sharedInstance] obrisiIzFrizidera:self.sastojci[indexPath.row]];
        [self.sastojci removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - delegate

-(void)dodaoSastojak:(NSString *)naziv{
    [[FriziderSingleton sharedInstance] dodajUFrizider:naziv];
    [self.sastojci addObject:naziv];
    [self.tableView reloadData];
}

-(void)obrisaoSastojak:(NSString *)naziv{
    [[FriziderSingleton sharedInstance] obrisiIzFrizidera:naziv];
    for (int i=0; i<self.sastojci.count; i++) {
        if ([self.sastojci[i] isEqualToString:naziv]){
            [self.sastojci removeObjectAtIndex:i];
            break;
        }
    }
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[BiranjeSastojakaZaFrizViewController class]]){
        BiranjeSastojakaZaFrizViewController* view = segue.destinationViewController;
        view.delegate = self;
        view.odabraniSastojci = [[[FriziderSingleton sharedInstance]uzmiSastojkeIzFrizidera] mutableCopy];
    }
}

@end
