//
//  WeekScheduleViewController.m
//  lunchschedule
//
//  Created by Filip Rajicic on 5/19/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import "WeekScheduleViewController.h"
#import "PregledReceptaViewController.h"
#import "NedeljniRasporedSingleton.h"
#import "FriziderSingleton.h"

@interface WeekScheduleViewController ()

@property (strong, nonatomic) NSMutableArray* arrView;
@property (assign, nonatomic) NSInteger mainViewNum;

@property (strong, nonatomic) NSMutableArray* arrRecepti;
@property (strong, nonatomic) NSMutableArray* nedeljniRaspored;

@property (strong, nonatomic) NSArray* arrSastojciUfrizideru;

-(void)dodajReceptNaLayout:(NSDictionary*)recept;

@end

@implementation WeekScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrView = [NSMutableArray new];
    self.arrRecepti = [NSMutableArray new];
    self.nedeljniRaspored = [[NedeljniRasporedSingleton sharedInstance]getNedeljniRaspored];
    self.arrSastojciUfrizideru = [[FriziderSingleton sharedInstance]uzmiSastojkeIzFrizidera];
    [self setUpViews];
    [self updateViews];
    
}

#pragma mark - Init views

-(void)updateViews{
    for (int i=0; i<7; i++) {
        NSArray* receptiZaDan = self.nedeljniRaspored[i];
        self.mainViewNum = i;
        for (NSDictionary* receptDict in receptiZaDan) {
            [self dodajReceptNaLayout:receptDict];
        }
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSInteger day = [components weekday];
    if (day == 1){
        day = 6;
    }else{
        day -= 2;
    }
    self.mainViewNum = 0;
    
    for (int i=0; i<day; i++) {
        [self slideLeft:nil];
    }
}

-(void)setUpViews{
    
    self.mainViewNum = 0;
    
    for (int i=0; i<7; i++){
        NSMutableDictionary* viewDict = [NSMutableDictionary new];
        
        //VIEW
        UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
        view.tag = i;
        //view.backgroundColor = [UIColor lightGrayColor];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [viewDict setValue:view forKey:@"View"];
        [view setClipsToBounds:YES];
        view.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.3] CGColor];
        view.layer.borderWidth = 0.5;
        
        [self.view addSubview:view];
        
        NSLayoutConstraint* cons1 = [NSLayoutConstraint constraintWithItem:view
                                                                attribute:NSLayoutAttributeCenterX
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeCenterX
                                                               multiplier:1.0
                                                                 constant:0];
        [self.view addConstraint:cons1];
        if (i!=0){
            [cons1 setActive:NO];
        }
        
        NSLayoutConstraint* cons2 = [NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0];
        [self.view addConstraint:cons2];
        
        NSLayoutConstraint* cons3;
        NSLayoutConstraint* cons4;
        if (i==0){
            cons3 = [NSLayoutConstraint constraintWithItem:view
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1.0
                                                                      constant:300];
            
            
            cons4 = [NSLayoutConstraint constraintWithItem:view
                                                                    attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0
                                                                     constant:150];
            
        }else if (i==1 || i==6){
            cons3 = [NSLayoutConstraint constraintWithItem:view
                                                attribute:NSLayoutAttributeHeight
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:nil
                                                attribute:NSLayoutAttributeNotAnAttribute
                                               multiplier:1.0
                                                 constant:75];
            
            
            cons4 = [NSLayoutConstraint constraintWithItem:view
                                                 attribute:NSLayoutAttributeWidth
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:nil
                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                multiplier:1.0
                                                  constant:75];
        }else{
            cons3 = [NSLayoutConstraint constraintWithItem:view
                                                attribute:NSLayoutAttributeHeight
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:nil
                                                attribute:NSLayoutAttributeNotAnAttribute
                                               multiplier:1.0
                                                 constant:0];
            
            
            cons4 = [NSLayoutConstraint constraintWithItem:view
                                                 attribute:NSLayoutAttributeWidth
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:nil
                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                multiplier:1.0
                                                  constant:0];
        }
        [view addConstraint:cons3];
        [view addConstraint:cons4];
        
        if (i==1){
            NSLayoutConstraint* cons5;
            cons5 = [NSLayoutConstraint constraintWithItem:view
                                                 attribute:NSLayoutAttributeLeft
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:[self.arrView[0] valueForKey:@"View"]
                                                 attribute:NSLayoutAttributeRight
                                                multiplier:1.0
                                                  constant:20];
            [self.view addConstraint:cons5];
            [viewDict setValue:cons5 forKey:@"ViewLeft"];
        }
        if (i==6){
            NSLayoutConstraint* cons5;
            cons5 = [NSLayoutConstraint constraintWithItem:view
                                                 attribute:NSLayoutAttributeRight
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:[self.arrView[0] valueForKey:@"View"]
                                                 attribute:NSLayoutAttributeLeft
                                                multiplier:1.0
                                                  constant:-20];
            [self.view addConstraint:cons5];
            [viewDict setValue:cons5 forKey:@"ViewRight"];
        }
        
        
        
        [viewDict setValue:cons1 forKey:@"ViewCenterX"];
        [viewDict setValue:cons2 forKey:@"ViewCenterY"];
        [viewDict setValue:cons3 forKey:@"ViewHeight"];
        [viewDict setValue:cons4 forKey:@"ViewWidth"];
        
        if (i!=0 && i!=1 && i!=6){
            view.hidden = YES;
        }
        
        //LABEL
        UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectZero];
        lbl.translatesAutoresizingMaskIntoConstraints = NO;
        
        switch (i) {
            case 0:
                lbl.text = @"Ponedeljak";
                break;
            case 1:
                lbl.text = @"Utorak";
                break;
            case 2:
                lbl.text = @"Sreda";
                break;
            case 3:
                lbl.text = @"Cetvrtak";
                break;
            case 4:
                lbl.text = @"Petak";
                break;
            case 5:
                lbl.text = @"Subota";
                break;
            case 6:
                lbl.text = @"Nedelja";
                break;
            default:
                break;
        }
        lbl.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lbl];
        [lbl addConstraint:[NSLayoutConstraint constraintWithItem:lbl
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0
                                                         constant:21]];
        
        [view addConstraint:[NSLayoutConstraint constraintWithItem:lbl
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view
                                                         attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                         constant:0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:lbl
                                                              attribute:NSLayoutAttributeTrailing
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:view
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0]];
        
        [view addConstraint:[NSLayoutConstraint constraintWithItem:lbl
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:0]];
        
        //BTN
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        btn.tag = i;
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [btn addTarget:self action:@selector(addRecept:) forControlEvents:UIControlEventTouchDown];
        [view addSubview:btn];
        [btn addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0
                                                         constant:22]];
        [btn addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0
                                                         constant:22]];
        
        [view addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                        constant:0]];
        NSLayoutConstraint* cons = [NSLayoutConstraint constraintWithItem:btn
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:view
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:29];
        [view addConstraint:cons];
        [viewDict setValue:cons forKey:@"ButtonCons"];
        [self.arrView addObject:viewDict];
        [self.view layoutIfNeeded];

    }
    
}

#pragma mark - Utility

-(NSString*)indexToDay:(NSInteger)index{
    switch (index) {
        case 0:
            return @"Ponedeljak";
            break;
        case 1:
            return @"Utorak";
            break;
        case 2:
            return @"Sreda";
            break;
        case 3:
            return @"Cetvrtak";
            break;
        case 4:
            return @"Petak";
            break;
        case 5:
            return @"Subota";
            break;
        case 6:
            return @"Nedelja";
            break;
        default:
            return @"Greska";
            break;
    }
}

#pragma mark - Buttons

-(void)addRecept:(UIButton*)clickedBtn{
    //da ne sme da se klikne neki view koji nije main od ona tri sto se okrecu
    if (clickedBtn.tag != self.mainViewNum){
        return;
    }
    [self performSegueWithIdentifier:@"biranjeRecepata" sender:nil];
}

-(void)receptPreview:(UIButton*)sender{
    [self performSegueWithIdentifier:@"pregledDrugi" sender:[self.arrView[self.mainViewNum] valueForKey:@"Recepti"][sender.tag]];
}

#pragma slide methods

- (IBAction)slideLeft:(id)sender {
    //OLD LEFT
    NSInteger oldLeftInd = self.mainViewNum-1;
    if (oldLeftInd<0){
        oldLeftInd = 6;
    }
    NSMutableDictionary* oldLeftDict = self.arrView[oldLeftInd];
    UIView* oldLeftView = [oldLeftDict valueForKey:@"View"];
    oldLeftView.hidden = YES;
    
    //NEW CENTER
    NSInteger centerInd = self.mainViewNum+1;
    if (centerInd>6){
        centerInd = 0;
    }
    NSMutableDictionary* centerDict = self.arrView[centerInd];
    UIView* centerView = [centerDict valueForKey:@"View"];
    NSLayoutConstraint* newCenterViewHeight = [centerDict valueForKey:@"ViewHeight"];
    NSLayoutConstraint* newCenterViewWidth = [centerDict valueForKey:@"ViewWidth"];
    NSLayoutConstraint* newCenterViewCenterX = [centerDict valueForKey:@"ViewCenterX"];
    NSLayoutConstraint* newCenterViewLeft= [centerDict valueForKey:@"ViewLeft"];
    NSLayoutConstraint* newCenterViewRight= [centerDict valueForKey:@"ViewRight"];
    
    [newCenterViewLeft setActive:NO];
    [newCenterViewRight setActive:NO];
    
    
    //NEW LEFT
    NSMutableDictionary* newLeftDict = self.arrView[self.mainViewNum];
    UIView* newLeftView = [newLeftDict valueForKey:@"View"];
    NSLayoutConstraint* newLeftViewHeight = [newLeftDict valueForKey:@"ViewHeight"];
    NSLayoutConstraint* newLeftViewWidth = [newLeftDict valueForKey:@"ViewWidth"];
    NSLayoutConstraint* newLeftViewCenterX = [newLeftDict valueForKey:@"ViewCenterX"];
    NSLayoutConstraint* newLeftViewRight= [newLeftDict valueForKey:@"ViewRight"];
    
    [newLeftViewCenterX setActive:NO];
    if (newLeftViewRight!=nil){
        [newLeftViewRight setActive:YES];
    }else{
        newLeftViewRight = [NSLayoutConstraint constraintWithItem:newLeftView
                                             attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:centerView
                                             attribute:NSLayoutAttributeLeft
                                            multiplier:1.0
                                              constant:-20];
        [self.view addConstraint:newLeftViewRight];
        [newLeftDict setValue:newLeftViewRight forKey:@"ViewRight"];
        self.arrView[self.mainViewNum] = newLeftDict;
    }
    
    //NEW RIGHT
    NSInteger newRightInd = (self.mainViewNum+2)%7;

    NSMutableDictionary* newRightDict = self.arrView[newRightInd];
    UIView* newRightView = [newRightDict valueForKey:@"View"];
    NSLayoutConstraint* newRightViewHeight = [newRightDict valueForKey:@"ViewHeight"];
    NSLayoutConstraint* newRightViewWidth = [newRightDict valueForKey:@"ViewWidth"];
    NSLayoutConstraint* newRightViewLeft= [newRightDict valueForKey:@"ViewLeft"];
    NSLayoutConstraint* newRightViewRight= [newRightDict valueForKey:@"ViewRight"];
    
    [newRightViewRight setActive:NO];
    newRightView.hidden = NO;
    self.mainViewNum = centerInd;

    if (newRightViewLeft!=nil){
        [newRightViewLeft setActive:YES];
    }else{
        newRightViewLeft = [NSLayoutConstraint constraintWithItem:newRightView
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:centerView
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1.0
                                                         constant:20];
        [self.view addConstraint:newRightViewLeft];
        [newRightDict setValue:newRightViewLeft forKey:@"ViewLeft"];
        self.arrView[newRightInd] = newRightDict;
        
    }
    
    //animation
    newRightViewHeight.constant = 0;
    newRightViewWidth.constant = 0;
    newRightViewLeft.constant = 300;
    newLeftViewRight.constant = 50;
    newCenterViewHeight.constant = 0;
    newCenterViewWidth.constant = 0;
    [newCenterViewCenterX setActive:YES];


    
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        newCenterViewHeight.constant = 300;
        newCenterViewWidth.constant = 150;
        
        newLeftViewHeight.constant = 75;
        newLeftViewWidth.constant = 75;
        newLeftViewRight.constant = -20;
        
        newRightViewHeight.constant = 75;
        newRightViewWidth.constant = 75;
        newRightViewLeft.constant = 20;
        [self.view layoutIfNeeded];
        
    }];
}

- (IBAction)slideRight:(id)sender {
    //OLD Right
    NSInteger oldRightInd = self.mainViewNum+1;
    if (oldRightInd>6){
        oldRightInd = 0;
    }
    NSMutableDictionary* oldRightDict = self.arrView[oldRightInd];
    UIView* oldRightView = [oldRightDict valueForKey:@"View"];
    oldRightView.hidden = YES;
    
    //NEW CENTER
    NSInteger centerInd = self.mainViewNum-1;
    if (centerInd<0){
        centerInd = 6;
    }
    NSMutableDictionary* centerDict = self.arrView[centerInd];
    UIView* centerView = [centerDict valueForKey:@"View"];
    NSLayoutConstraint* newCenterViewHeight = [centerDict valueForKey:@"ViewHeight"];
    NSLayoutConstraint* newCenterViewWidth = [centerDict valueForKey:@"ViewWidth"];
    NSLayoutConstraint* newCenterViewCenterX = [centerDict valueForKey:@"ViewCenterX"];
    NSLayoutConstraint* newCenterViewLeft= [centerDict valueForKey:@"ViewLeft"];
    NSLayoutConstraint* newCenterViewRight= [centerDict valueForKey:@"ViewRight"];
    
    [newCenterViewRight setActive:NO];
    [newCenterViewLeft setActive:NO];
    
    [newCenterViewCenterX setActive:YES];
    //newCenterViewHeight.constant = 150;
    //newCenterViewWidth.constant = 150;
    
    //NEW Right
    NSMutableDictionary* newRightDict = self.arrView[self.mainViewNum];
    UIView* newRightView = [newRightDict valueForKey:@"View"];
    NSLayoutConstraint* newRightViewHeight = [newRightDict valueForKey:@"ViewHeight"];
    NSLayoutConstraint* newRightViewWidth = [newRightDict valueForKey:@"ViewWidth"];
    NSLayoutConstraint* newRightViewCenterX = [newRightDict valueForKey:@"ViewCenterX"];
    NSLayoutConstraint* newRightViewLeft= [newRightDict valueForKey:@"ViewLeft"];
    
    [newRightViewCenterX setActive:NO];
    if (newRightViewLeft!=nil){
        [newRightViewLeft setActive:YES];
    }else{
        newRightViewLeft = [NSLayoutConstraint constraintWithItem:newRightView
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:centerView
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1.0
                                                         constant:20];
        [self.view addConstraint:newRightViewLeft];
        [newRightDict setValue:newRightViewLeft forKey:@"ViewLeft"];
        self.arrView[self.mainViewNum] = newRightDict;
    }
    
    //newRightViewHeight.constant = 75;
    //newRightViewWidth.constant = 75;
    newRightViewLeft.constant = 20;
    
    //NEW LEft
    NSInteger newLeftInd = self.mainViewNum-2;
    if (newLeftInd==-1){
        newLeftInd = 6;
    }else if (newLeftInd==-2){
        newLeftInd = 5;
    }
    
    NSMutableDictionary* newLeftDict = self.arrView[newLeftInd];
    UIView* newLeftView = [newLeftDict valueForKey:@"View"];
    NSLayoutConstraint* newLeftViewHeight = [newLeftDict valueForKey:@"ViewHeight"];
    NSLayoutConstraint* newLeftViewWidth = [newLeftDict valueForKey:@"ViewWidth"];
    NSLayoutConstraint* newLeftViewLeft= [newLeftDict valueForKey:@"ViewLeft"];
    NSLayoutConstraint* newLeftViewRight= [newLeftDict valueForKey:@"ViewRight"];
    
    [newLeftViewLeft setActive:NO];
    newLeftView.hidden = NO;
    
    if (newLeftViewRight!=nil){
        [newLeftViewRight setActive:YES];
    }else{
        newLeftViewRight = [NSLayoutConstraint constraintWithItem:newLeftView
                                                        attribute:NSLayoutAttributeRight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:centerView
                                                        attribute:NSLayoutAttributeLeft
                                                       multiplier:1.0
                                                         constant:20];
        [self.view addConstraint:newLeftViewRight];
        [newLeftDict setValue:newLeftViewRight forKey:@"ViewRight"];
        self.arrView[newLeftInd] = newLeftDict;
        
    }
    
    newLeftViewHeight.constant = 75;
    newLeftViewWidth.constant = 75;
    newLeftViewRight.constant = -20;
    
    self.mainViewNum = centerInd;
    
    
    //animation
    newLeftViewHeight.constant = 0;
    newLeftViewWidth.constant = 0;
    newLeftViewRight.constant = -300;
    newRightViewLeft.constant = -50;
    newCenterViewHeight.constant = 0;
    newCenterViewWidth.constant = 0;
    
    
    
    
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        newCenterViewHeight.constant = 300;
        newCenterViewWidth.constant = 150;
        
        newRightViewHeight.constant = 75;
        newRightViewWidth.constant = 75;
        newRightViewLeft.constant = 20;
        
        newLeftViewHeight.constant = 75;
        newLeftViewWidth.constant = 75;
        newLeftViewRight.constant = -20;
        [self.view layoutIfNeeded];
        
    }];
    //[self.view layoutIfNeeded];
}

#pragma mark - Delegates

-(void)dodaoRecept:(NSDictionary *)recept{
    [[NedeljniRasporedSingleton sharedInstance]dodajRecept:[recept valueForKey:@"Naziv"] zaDan:[self indexToDay:self.mainViewNum]];
    [self dodajReceptNaLayout:recept];
    
    /*
    NSMutableArray* arrRecepti = [self.arrView[self.mainViewNum] objectForKey:@"Recepti"];
    if (arrRecepti == NULL){
        arrRecepti = [NSMutableArray new];
        [self.arrView[self.mainViewNum] setObject:arrRecepti forKey:@"Recepti"];
    }
    [arrRecepti addObject:recept];
    
    UIView* view = [self.arrView[self.mainViewNum] valueForKey:@"View"];
    NSMutableArray* arrLblCons = [self.arrView[self.mainViewNum] objectForKey:@"LabelsCons"];
    if (arrLblCons == nil){
        arrLblCons = [NSMutableArray new];
    }
    NSMutableArray* arrLbl = [self.arrView[self.mainViewNum] objectForKey:@"Labels"];
    if (arrLbl == nil){
        arrLbl = [NSMutableArray new];
    }
    
    NSLayoutConstraint* btnCons = [self.arrView[self.mainViewNum] valueForKey:@"ButtonCons"];

    UIButton* lbl = [[UIButton alloc] initWithFrame:CGRectZero];
    [lbl addTarget:self action:@selector(receptPreview:) forControlEvents:UIControlEventTouchDown];
    lbl.translatesAutoresizingMaskIntoConstraints = NO;
    [lbl setTitle:[recept valueForKey:@"Naziv"] forState:UIControlStateNormal];
    lbl.titleLabel.textAlignment = NSTextAlignmentCenter;
    [lbl setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:lbl];
    lbl.tag = [[self.arrView[self.mainViewNum] objectForKey:@"Recepti"] count]-1;
    
    [lbl addConstraint:[NSLayoutConstraint constraintWithItem:lbl
                                             attribute:NSLayoutAttributeHeight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:nil
                                             attribute:NSLayoutAttributeNotAnAttribute
                                             multiplier:1.0
                                             constant:21]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:lbl
                                             attribute:NSLayoutAttributeLeading
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:view
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0
                                             constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:lbl
                                         attribute:NSLayoutAttributeTrailing
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:view
                                         attribute:NSLayoutAttributeRight
                                         multiplier:1.0
                                         constant:0]];
    NSLayoutConstraint* cons = [NSLayoutConstraint constraintWithItem:lbl
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:view
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0
                                         constant:btnCons.constant];
    [view addConstraint:cons];
    [arrLblCons addObject:cons];
    [arrLbl addObject:lbl];
    btnCons.constant+= 29;
    [self.arrView[self.mainViewNum] setValue:btnCons forKey:@"ButtonCons"];
    [self.arrView[self.mainViewNum] setValue:arrLblCons forKey:@"LabelsCons"];
    [self.arrView[self.mainViewNum] setValue:arrLbl forKey:@"Labels"];
    
    
    
    [self.view setNeedsLayout];
     */
}

-(void)dodajReceptNaLayout:(NSDictionary*)recept{
    NSMutableArray* arrRecepti = [self.arrView[self.mainViewNum] objectForKey:@"Recepti"];
    if (arrRecepti == NULL){
        arrRecepti = [NSMutableArray new];
        [self.arrView[self.mainViewNum] setObject:arrRecepti forKey:@"Recepti"];
    }
    [arrRecepti addObject:recept];
    
    UIView* view = [self.arrView[self.mainViewNum] valueForKey:@"View"];
    NSMutableArray* arrLblCons = [self.arrView[self.mainViewNum] objectForKey:@"LabelsCons"];
    if (arrLblCons == nil){
        arrLblCons = [NSMutableArray new];
    }
    NSMutableArray* arrLbl = [self.arrView[self.mainViewNum] objectForKey:@"Labels"];
    if (arrLbl == nil){
        arrLbl = [NSMutableArray new];
    }
    
    NSLayoutConstraint* btnCons = [self.arrView[self.mainViewNum] valueForKey:@"ButtonCons"];
    
    UIButton* lbl = [[UIButton alloc] initWithFrame:CGRectZero];
    [lbl addTarget:self action:@selector(receptPreview:) forControlEvents:UIControlEventTouchDown];
    lbl.translatesAutoresizingMaskIntoConstraints = NO;
    [lbl setTitle:[recept valueForKey:@"Naziv"] forState:UIControlStateNormal];
    lbl.titleLabel.textAlignment = NSTextAlignmentCenter;
    [lbl setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:lbl];
    lbl.tag = [[self.arrView[self.mainViewNum] objectForKey:@"Recepti"] count]-1;
    
    [lbl addConstraint:[NSLayoutConstraint constraintWithItem:lbl
                                                    attribute:NSLayoutAttributeHeight
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:nil
                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                   multiplier:1.0
                                                     constant:21]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:lbl
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:lbl
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0
                                                      constant:0]];
    NSLayoutConstraint* cons = [NSLayoutConstraint constraintWithItem:lbl
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:btnCons.constant];
    [view addConstraint:cons];
    [arrLblCons addObject:cons];
    [arrLbl addObject:lbl];
    btnCons.constant+= 29;
    [self.arrView[self.mainViewNum] setValue:btnCons forKey:@"ButtonCons"];
    [self.arrView[self.mainViewNum] setValue:arrLblCons forKey:@"LabelsCons"];
    [self.arrView[self.mainViewNum] setValue:arrLbl forKey:@"Labels"];
    
    //update COLOR
    for (NSString* trazeniSastojak in [recept valueForKey:@"Sastojci"]) {
        [lbl setBackgroundColor:[UIColor redColor]];
        BOOL found = NO;
        for (NSString* sastojak in self.arrSastojciUfrizideru) {
            if ([sastojak isEqualToString:trazeniSastojak]){
                [lbl setBackgroundColor:[UIColor greenColor]];
                found = YES;
                break;
            }
        }
        if (!found){
            break;
        }
    }
    
    
    [self.view setNeedsLayout];
}

-(void)skinuoRecept:(NSString *)receptName{
    for (int i=0; i<[[self.arrView[self.mainViewNum] valueForKey:@"Recepti"]count]; i++) {
        NSDictionary* receptDict = [self.arrView[self.mainViewNum] valueForKey:@"Recepti"][i];
        if ([[receptDict valueForKey:@"Naziv"] isEqualToString:receptName]){ //skini ovaj
            [[self.arrView[self.mainViewNum] valueForKey:@"Recepti"] removeObjectAtIndex:i];
            
            [([self.arrView[self.mainViewNum] valueForKey:@"Labels"][i]) removeFromSuperview];
            
            
            NSArray* labelsCons = [self.arrView[self.mainViewNum] objectForKey:@"LabelsCons"];
            NSArray* labelsArr = [self.arrView[self.mainViewNum] objectForKey:@"Labels"];
            int count = i+1;
            while (labelsCons.count > count){
                NSLayoutConstraint* consTopNext = labelsCons[count];
                consTopNext.constant-= 29;
                UIButton* btn = labelsArr[count];
                btn.tag--;
                count++;
                
            }
            [[self.arrView[self.mainViewNum] valueForKey:@"LabelsCons"] removeObjectAtIndex:i];
            [[self.arrView[self.mainViewNum] valueForKey:@"Labels"] removeObjectAtIndex:i];
            
            NSLayoutConstraint* btnCons = [self.arrView[self.mainViewNum] valueForKey:@"ButtonCons"];
            btnCons.constant-= 29;
        }
    }
    [[NedeljniRasporedSingleton sharedInstance]obrisiRecept:receptName zaDan:[self indexToDay:self.mainViewNum]];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"pregledDrugi"]){
        PregledReceptaViewController* view = segue.destinationViewController;
        view.dictRecept = sender;
        view.btnIzmeniIsHidden = YES;
    }
    else if ([segue.identifier isEqualToString:@"biranjeRecepata"]){
        BiranjeReceptaViewController* view = segue.destinationViewController;
        view.delegate= self;
        view.arrDodatiRecepti = [self.arrView[self.mainViewNum] valueForKey:@"Recepti"];
    }
}


@end
