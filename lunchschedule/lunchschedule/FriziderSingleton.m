//
//  FriziderSingleton.m
//  lunchschedule
//
//  Created by Filip Rajicic on 5/27/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import "FriziderSingleton.h"
#import "Frizider.h"
#import "DataAccessLayer.h"
#import "Sastojak.h"

@interface FriziderSingleton()

@property (strong, nonatomic) Frizider* frizider;

@end

@implementation FriziderSingleton

+ (FriziderSingleton *)sharedInstance {
    __strong static FriziderSingleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FriziderSingleton alloc] init];
        
        sharedInstance.frizider = [[DataAccessLayer sharedInstance] getFrizider];
        
    });
    return sharedInstance;
}

#pragma mark - Methods

- (NSArray*)uzmiSastojkeIzFrizidera{
    NSMutableArray* arr = [NSMutableArray new];
    
    for (Sastojak* sas in self.frizider.sastojci) {
        [arr addObject:sas.naziv];
    }
    
    return arr;
    
}

- (Sastojak*)uzmiSastojakIzFrizidera:(NSString*)naziv{
    for (Sastojak* sas in self.frizider.sastojci) {
        if ([sas.naziv isEqualToString:naziv]){
            return sas;
        }
    }
    return nil;
}

- (void)dodajUFrizider:(NSString*)sastojak{
    [[DataAccessLayer sharedInstance] dodajUFrizider:self.frizider sastojak:sastojak];
}

- (void)obrisiIzFrizidera:(NSString*)sastojak{
    //NSArray* arr = [[DataAccessLayer sharedInstance]uzmiSastojak:sastojak];
    Sastojak* sas = [self uzmiSastojakIzFrizidera:sastojak];
    if (sas != nil){
        [self.frizider removeSastojciObject:sas];
        [[DataAccessLayer sharedInstance]saveContext];
    }
}

- (NSArray*)dohvatiSveSastojke{
    NSArray* sastojci = [[DataAccessLayer sharedInstance]uzmiSveSastojke];
    
    NSMutableArray* arr = [NSMutableArray new];
    
    for (Sastojak* sas in sastojci) {
        [arr addObject:sas.naziv];
    }

    return arr;
}

@end
