//
//  ReceptiSingleton.m
//  lunchschedule
//
//  Created by Filip Rajicic on 5/28/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import "ReceptiSingleton.h"
#import "DataAccessLayer.h"
#import "Sastojak.h"

@implementation ReceptiSingleton

+ (ReceptiSingleton *)sharedInstance {
    __strong static ReceptiSingleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ReceptiSingleton alloc] init];
        
        sharedInstance.recepti = [[[DataAccessLayer sharedInstance] dohvatiRecepte] mutableCopy];
        
    });
    return sharedInstance;
}

- (NSArray*)dohvatiRecepte{
    NSMutableArray* ret = [NSMutableArray new];
    for (Recept* recept in self.recepti) {
        NSMutableDictionary* recDict = [NSMutableDictionary new];
        [recDict setObject:recept.naziv forKey:@"Naziv"];
        [recDict setObject:recept.opis forKey:@"Opis"];
        [recDict setObject:recept.priprema forKey:@"Priprema"];
        NSMutableSet* sastojci = [NSMutableSet new];
        for (Sastojak* sas in recept.sastojci) {
            [sastojci addObject:sas.naziv];
        }
        [recDict setObject:sastojci forKey:@"Sastojci"];
        [ret addObject:recDict];
    }
    return ret;
}

- (void)dodajRecept:(NSDictionary*)recDict{
    Recept* rec = [[DataAccessLayer sharedInstance]dodajRecept:recDict];
    [self.recepti addObject:rec];
}

- (void)updateStariRecept:(NSDictionary*)stariRecept saNovim:(NSDictionary*) noviRecept{
    Recept* recept = [self dohvatiRecept:[stariRecept valueForKey:@"Naziv"]];
    recept.naziv = [noviRecept valueForKey:@"Naziv"];
    recept.opis = [noviRecept valueForKey:@"Opis"];
    recept.priprema = [noviRecept valueForKey:@"Priprema"];
    [recept removeSastojci:recept.sastojci];
    for (NSString* sastojak in [noviRecept valueForKey:@"Sastojci"]) {
        Sastojak* sas = [[DataAccessLayer sharedInstance] uzmiSastojak:sastojak][0];
        [recept addSastojciObject:sas];
    }
    [[DataAccessLayer sharedInstance]saveContext];
}


- (void)removeRecept:(NSString*)naziv{
    for (int i=0; i<self.recepti.count; i++) {
        Recept* recept = self.recepti[i];
        if ([recept.naziv isEqualToString:naziv]){
            [self.recepti removeObjectAtIndex:i];
            [[DataAccessLayer sharedInstance]obrisiRecept:recept];
            [[DataAccessLayer sharedInstance]saveContext];
            break;
        }
    }
}

- (Recept*)dohvatiRecept:(NSString*)naziv{
    for (Recept* recept in self.recepti) {
        if ([recept.naziv isEqualToString:naziv]){
            return recept;
        }
    }
    return nil;
}


@end
