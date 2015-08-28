//
//  Raspored.h
//  lunchschedule
//
//  Created by Filip Rajicic on 6/14/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NedeljniRaspored, Recept;

@interface Raspored : NSManagedObject

@property (nonatomic, retain) NSString * dan;
@property (nonatomic, retain) NSOrderedSet *recepti;
@property (nonatomic, retain) NedeljniRaspored *uNedeljnomRasporedu;

- (void)dodajReceptiObject:(Recept *)value;
- (void)obrisiReceptiObject:(Recept *)value;

@end

@interface Raspored (CoreDataGeneratedAccessors)

- (void)insertObject:(Recept *)value inReceptiAtIndex:(NSUInteger)idx;
- (void)removeObjectFromReceptiAtIndex:(NSUInteger)idx;
- (void)insertRecepti:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeReceptiAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInReceptiAtIndex:(NSUInteger)idx withObject:(Recept *)value;
- (void)replaceReceptiAtIndexes:(NSIndexSet *)indexes withRecepti:(NSArray *)values;
- (void)addReceptiObject:(Recept *)value;
- (void)removeReceptiObject:(Recept *)value;
- (void)addRecepti:(NSOrderedSet *)values;
- (void)removeRecepti:(NSOrderedSet *)values;
@end
