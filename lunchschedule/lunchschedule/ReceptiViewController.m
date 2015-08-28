//
//  ReceptiViewController.m
//  lunchschedule
//
//  Created by Filip Rajicic on 5/28/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import "ReceptiViewController.h"
#import "ReceptiSingleton.h"
#import "PregledReceptaViewController.h"

@interface ReceptiViewController ()

@property (strong, nonatomic) NSMutableArray* recepti;

@end

@implementation ReceptiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.recepti = [[[ReceptiSingleton sharedInstance]dohvatiRecepte] mutableCopy];
}

#pragma mark - Table view

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.recepti==nil){
        return 0;
    }else{
        return self.recepti.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [self.recepti[indexPath.row] valueForKey:@"Naziv"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"pregled" sender:self.recepti[indexPath.row]];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        [[ReceptiSingleton sharedInstance]removeRecept:[self.recepti[indexPath.row]valueForKey:@"Naziv"]];
        [self.recepti removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
    }
}


#pragma mark - Delegate

-(void)dodaoRecept:(NSMutableDictionary *)receptDict{
    [self.recepti addObject:receptDict];
    [self.tableView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue destinationViewController] isKindOfClass:[NoviReceptViewController class]]){
        NoviReceptViewController* view = segue.destinationViewController;
        view.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"pregled"]){
        PregledReceptaViewController* view = segue.destinationViewController;
        view.dictRecept = sender;
    }
}

@end
