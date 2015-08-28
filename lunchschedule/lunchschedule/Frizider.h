//
//  Frizider.h
//  lunchschedule
//
//  Created by Filip Rajicic on 5/27/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Sastojak;

@interface Frizider : NSManagedObject

@property (nonatomic, retain) NSSet *sastojci;
@end

@interface Frizider (CoreDataGeneratedAccessors)

- (void)addSastojciObject:(Sastojak *)value;
- (void)removeSastojciObject:(Sastojak *)value;
- (void)addSastojci:(NSSet *)values;
- (void)removeSastojci:(NSSet *)values;

@end
