//
//  NoviReceptViewController.m
//  lunchschedule
//
//  Created by Filip Rajicic on 5/28/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import "NoviReceptViewController.h"
#import "BiranjeSastojakaZaFrizViewController.h"
#import "ReceptiSingleton.h"

@interface NoviReceptViewController ()

@property (strong, nonatomic) NSMutableArray* odabraniSastojci;

@end

@implementation NoviReceptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.txtOpis.layer.cornerRadius = 5;
    [self.txtOpis.layer setBorderColor:[[[UIColor lightGrayColor] colorWithAlphaComponent:0.3] CGColor]];
    [self.txtOpis.layer setBorderWidth:1];
    self.txtOpis.clipsToBounds = YES;
    
    self.txtPriprema.layer.cornerRadius = 5;
    [self.txtPriprema.layer setBorderColor:[[[UIColor lightGrayColor] colorWithAlphaComponent:0.3] CGColor]];
    [self.txtPriprema.layer setBorderWidth:1];
    self.txtPriprema.clipsToBounds = YES;
    
    self.odabraniSastojci = [NSMutableArray new];
    
    if (self.dictIzmeni != nil){ //IS UPDATE RECEPT, NOT NEW ONE
        self.title = @"Izmeni Recept";
        self.txtNaziv.text = [self.dictIzmeni valueForKey:@"Naziv"];
        self.txtOpis.text = [self.dictIzmeni valueForKey:@"Opis"];
        self.txtPriprema.text = [self.dictIzmeni valueForKey:@"Priprema"];
        for (NSString* sastojak in [self.dictIzmeni valueForKey:@"Sastojci"]) {
            [self.odabraniSastojci addObject:sastojak];
        }
        [self updateTextDugmeta];
    }
    
}

#pragma mark - Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if ([textField isEqual:self.txtNaziv]){
        [self.txtOpis becomeFirstResponder];
    }else if ([textField isEqual:self.txtOpis]){
        [self.txtPriprema becomeFirstResponder];
    }
    return NO;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        if ([self.txtOpis isEqual:textView]){
            [self.txtPriprema becomeFirstResponder];
        }
        return NO;
    }
    return YES;
}

-(void)dodaoSastojak:(NSString *)naziv{
    [self.odabraniSastojci addObject:naziv];
    [self updateTextDugmeta];
}

-(void)obrisaoSastojak:(NSString *)naziv{
    for (int i=0;i<self.odabraniSastojci.count; i++){
        if ([self.odabraniSastojci[i] isEqualToString:naziv]){
            [self.odabraniSastojci removeObjectAtIndex:i];
            break;
        }
    }
    [self updateTextDugmeta];
}

#pragma mark - Buttons


- (IBAction)Zavrsi:(UIButton *)sender {
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:self.txtNaziv.text forKey:@"Naziv"];
    [dict setObject:self.txtOpis.text forKey:@"Opis"];
    [dict setObject:self.txtPriprema.text forKey:@"Priprema"];
    [dict setObject:self.odabraniSastojci forKey:@"Sastojci"];
    
    if (self.dictIzmeni == NULL){
        [[ReceptiSingleton sharedInstance]dodajRecept:dict];
        [self.delegate dodaoRecept:dict];
    }else{
        [[ReceptiSingleton sharedInstance]updateStariRecept:self.dictIzmeni saNovim:dict];
        [self.delegate zamenioStariRecept:self.dictIzmeni saNovim:dict];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Methods

- (void)updateTextDugmeta{
    if (self.odabraniSastojci.count == 0){
        [self.btnSastojci setTitle:@"Ubaci sastojke" forState:UIControlStateNormal];
    }else{
        [self.btnSastojci setTitle:[NSString stringWithFormat:@"Odabranih sastojaka: %lu", (unsigned long)self.odabraniSastojci.count] forState:UIControlStateNormal];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[BiranjeSastojakaZaFrizViewController class]]){
        BiranjeSastojakaZaFrizViewController* view = segue.destinationViewController;
        view.delegate = self;
        view.odabraniSastojci = [self.odabraniSastojci mutableCopy];
    }
}

@end
