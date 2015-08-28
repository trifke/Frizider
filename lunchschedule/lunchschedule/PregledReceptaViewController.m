//
//  PregledReceptaViewController.m
//  lunchschedule
//
//  Created by Filip Rajicic on 6/6/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import "PregledReceptaViewController.h"
#import "FriziderSingleton.h"

@interface PregledReceptaViewController ()

@property (strong, nonatomic) NSArray* arrSastojciUFrizideru;

@end

@implementation PregledReceptaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.arrSastojciUFrizideru = [[FriziderSingleton sharedInstance]uzmiSastojkeIzFrizidera];
    
    self.txtOpis.text = [self.dictRecept valueForKey:@"Opis"];
    self.txtPriprema.text = [self.dictRecept valueForKey:@"Priprema"];
    self.title = [self.dictRecept valueForKey:@"Naziv"];
    
    [self.btnIzmeniGui setHidden:self.btnIzmeniIsHidden];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dictRecept valueForKey:@"Sastojci"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    NSSet* sastojci = [self.dictRecept valueForKey:@"Sastojci"];
    cell.textLabel.text = [sastojci allObjects][indexPath.row];
    
    cell.backgroundColor = [UIColor redColor];
    for (NSString* sastojak in self.arrSastojciUFrizideru) {
        if ([sastojak isEqualToString:cell.textLabel.text]){
            cell.backgroundColor = [UIColor greenColor];
        }
    }
    
    return cell;
}


- (IBAction)btnIzmeni:(UIButton *)sender {
}

#pragma mark - Delegates

-(void)zamenioStariRecept:(NSDictionary *)stariRecept saNovim:(NSDictionary *)noviRecept{
    self.txtOpis.text = [noviRecept valueForKey:@"Opis"];
    self.txtPriprema.text = [noviRecept valueForKey:@"Priprema"];
    self.title = [noviRecept valueForKey:@"Naziv"];
    self.dictRecept = [noviRecept mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"izmeniRecept"]){
        NoviReceptViewController* view = segue.destinationViewController;
        view.dictIzmeni = self.dictRecept;
        view.delegate = self;
    }
}

@end
