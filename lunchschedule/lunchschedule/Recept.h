//
//  Recept.h
//  lunchschedule
//
//  Created by Filip Rajicic on 5/28/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Sastojak;

@interface Recept : NSManagedObject

@property (nonatomic, retain) NSString * naziv;
@property (nonatomic, retain) NSString * opis;
@property (nonatomic, retain) NSString * priprema;
@property (nonatomic, retain) NSSet *sastojci;
@end

@interface Recept (CoreDataGeneratedAccessors)

- (void)addSastojciObject:(Sastojak *)value;
- (void)removeSastojciObject:(Sastojak *)value;
- (void)addSastojci:(NSSet *)values;
- (void)removeSastojci:(NSSet *)values;

@end
