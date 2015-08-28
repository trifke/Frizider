//
//  NoviReceptViewController.h
//  lunchschedule
//
//  Created by Filip Rajicic on 5/28/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiranjeSastojakaZaFrizViewController.h"

@protocol NoviReceptDelegate

@optional
- (void)dodaoRecept:(NSMutableDictionary*)receptDict;
- (void)zamenioStariRecept:(NSDictionary*)stariRecept saNovim:(NSDictionary*)noviRecept;

@end

@interface NoviReceptViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate, BiranjeSastojakaZaFrizDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtNaziv;
@property (strong, nonatomic) IBOutlet UITextView *txtOpis;
@property (strong, nonatomic) IBOutlet UITextView *txtPriprema;
@property (strong, nonatomic) IBOutlet UIButton *btnSastojci;

@property (strong, nonatomic) NSMutableDictionary* dictIzmeni;

- (IBAction)Zavrsi:(UIButton *)sender;

@property (nonatomic, weak) id <NoviReceptDelegate> delegate;

@end
