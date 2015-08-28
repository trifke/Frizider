//
//  DataAccessLayer.h
//  lunchschedule
//
//  Created by Filip Rajicic on 5/27/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Frizider.h"
#import "Recept.h"
#import "NedeljniRaspored.h"
#import "Raspored.h"

@interface DataAccessLayer : NSObject

+ (DataAccessLayer *)sharedInstance;
- (void)saveContext;

- (void)initSastojke:(NSArray*)sastojci;
- (NSArray*)uzmiSveSastojke;
- (NSArray*)uzmiSastojak:(NSString*)sastojak;

- (Frizider*)getFrizider;
- (void)dodajUFrizider:(Frizider*)frizider sastojak:(NSString*)sastojak;

- (NSArray*)dohvatiRecepte;
- (Recept*)dodajRecept:(NSDictionary*)recDict;
- (void)obrisiRecept:(Recept*)recept;

- (NedeljniRaspored*) getNedeljniRaspored;

@end
