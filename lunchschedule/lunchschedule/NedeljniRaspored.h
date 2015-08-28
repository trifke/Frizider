//
//  NedeljniRaspored.h
//  lunchschedule
//
//  Created by Filip Rajicic on 6/14/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Raspored;

@interface NedeljniRaspored : NSManagedObject

@property (nonatomic, retain) NSOrderedSet *rasporediPoDanima;

- (void)addRasporedObject:(Raspored *)value;

@end

@interface NedeljniRaspored (CoreDataGeneratedAccessors)

- (void)insertObject:(Raspored *)value inRasporediPoDanimaAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRasporediPoDanimaAtIndex:(NSUInteger)idx;
- (void)insertRasporediPoDanima:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRasporediPoDanimaAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRasporediPoDanimaAtIndex:(NSUInteger)idx withObject:(Raspored *)value;
- (void)replaceRasporediPoDanimaAtIndexes:(NSIndexSet *)indexes withRasporediPoDanima:(NSArray *)values;
- (void)addRasporediPoDanimaObject:(Raspored *)value;
- (void)removeRasporediPoDanimaObject:(Raspored *)value;
- (void)addRasporediPoDanima:(NSOrderedSet *)values;
- (void)removeRasporediPoDanima:(NSOrderedSet *)values;
@end
