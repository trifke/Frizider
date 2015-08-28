//
//  NedeljniRasporedSingleton.m
//  lunchschedule
//
//  Created by Filip Rajicic on 6/14/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import "NedeljniRasporedSingleton.h"
#import "DataAccessLayer.h"
#import "ReceptiSingleton.h"
#import "Raspored.h"
#import "Sastojak.h"

@interface NedeljniRasporedSingleton ()

- (NSInteger)vratiIndexZaDan:(NSString*)dan;

@end

@implementation NedeljniRasporedSingleton

+ (NedeljniRasporedSingleton *)sharedInstance {
    __strong static NedeljniRasporedSingleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NedeljniRasporedSingleton alloc] init];
        
        sharedInstance.raspored = [[DataAccessLayer sharedInstance] getNedeljniRaspored];
        
    });
    return sharedInstance;
}

- (NSMutableArray*)getNedeljniRaspored{
    NSMutableArray* arr = [NSMutableArray new];
    for (int i=0; i<7; i++){
        NSMutableArray* arrDan = [NSMutableArray new];
        Raspored* raspored = self.raspored.rasporediPoDanima[i];
        for (Recept* recept in raspored.recepti) {
            NSMutableDictionary* receptDict = [NSMutableDictionary new];
            [receptDict setValue:recept.naziv forKey:@"Naziv"];
            [receptDict setValue:recept.opis forKey:@"Opis"];
            [receptDict setValue:recept.priprema forKey:@"Priprema"];
            NSMutableSet* sastojci = [NSMutableSet new];
            for (Sastojak* sas in recept.sastojci) {
                [sastojci addObject:sas.naziv];
            }
            [receptDict setObject:sastojci forKey:@"Sastojci"];
            [arrDan addObject:receptDict];
        }
        [arr addObject:arrDan];
    }
    return arr;
}


- (void)dodajRecept:(NSString*)naziv zaDan:(NSString*)dan{
    NSInteger index = [self vratiIndexZaDan:dan];
    Recept* recept = [[ReceptiSingleton sharedInstance]dohvatiRecept:naziv];
    Raspored* raspored = self.raspored.rasporediPoDanima[index];
    [raspored dodajReceptiObject:recept];
    [[DataAccessLayer sharedInstance]saveContext];
}

- (void)obrisiRecept:(NSString*)naziv zaDan:(NSString*)dan{
    NSInteger index = [self vratiIndexZaDan:dan];
    Recept* recept = [[ReceptiSingleton sharedInstance]dohvatiRecept:naziv];
    Raspored* raspored = self.raspored.rasporediPoDanima[index];
    [raspored obrisiReceptiObject:recept];
    [[DataAccessLayer sharedInstance]saveContext];
}



- (NSInteger)vratiIndexZaDan:(NSString*)dan{
    if ([dan isEqualToString:@"Ponedeljak"]){
        return 0;
    }else if ([dan isEqualToString:@"Utorak"]){
        return 1;
    }else if ([dan isEqualToString:@"Sreda"]){
        return 2;
    }else if ([dan isEqualToString:@"Cetvrtak"]){
        return 3;
    }else if ([dan isEqualToString:@"Petak"]){
        return 4;
    }else if ([dan isEqualToString:@"Subota"]){
        return 5;
    }else{
        return 6;
    }
}

@end
