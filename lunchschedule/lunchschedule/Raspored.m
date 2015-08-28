//
//  Raspored.m
//  lunchschedule
//
//  Created by Filip Rajicic on 6/14/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import "Raspored.h"
#import "NedeljniRaspored.h"
#import "Recept.h"


@implementation Raspored

@dynamic dan;
@dynamic recepti;
@dynamic uNedeljnomRasporedu;

- (void)dodajReceptiObject:(Recept *)value {
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.recepti];
    [tempSet addObject:value];
    self.recepti = tempSet;
}

- (void)obrisiReceptiObject:(Recept *)value{
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.recepti];
    [tempSet removeObject:value];
    self.recepti = tempSet;
}

@end
