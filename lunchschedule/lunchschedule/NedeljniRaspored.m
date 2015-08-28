//
//  NedeljniRaspored.m
//  lunchschedule
//
//  Created by Filip Rajicic on 6/14/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import "NedeljniRaspored.h"
#import "Raspored.h"


@implementation NedeljniRaspored

@dynamic rasporediPoDanima;

- (void)addRasporedObject:(Raspored *)value {
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.rasporediPoDanima];
    [tempSet addObject:value];
    self.rasporediPoDanima = tempSet;
}

@end
