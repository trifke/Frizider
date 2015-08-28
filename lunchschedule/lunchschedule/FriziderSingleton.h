//
//  FriziderSingleton.h
//  lunchschedule
//
//  Created by Filip Rajicic on 5/27/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriziderSingleton : NSObject

+ (FriziderSingleton *)sharedInstance;

- (NSArray*)dohvatiSveSastojke;
- (NSArray*)uzmiSastojkeIzFrizidera;
- (void)dodajUFrizider:(NSString*)sastojak;
- (void)obrisiIzFrizidera:(NSString*)sastojak;
- (id)uzmiSastojakIzFrizidera:(NSString*)naziv;

@end
