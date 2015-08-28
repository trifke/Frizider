//
//  ReceptiSingleton.h
//  lunchschedule
//
//  Created by Filip Rajicic on 5/28/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recept.h"

@interface ReceptiSingleton : NSObject

+ (ReceptiSingleton *)sharedInstance;

@property (strong, nonatomic) NSMutableArray* recepti;

- (NSArray*)dohvatiRecepte;
- (void)dodajRecept:(NSDictionary*)recDict;
- (void)updateStariRecept:(NSDictionary*)stariRecept saNovim:(NSDictionary*) noviRecept;
- (void)removeRecept:(NSString*)naziv;
- (Recept*)dohvatiRecept:(NSString*)naziv;

@end
