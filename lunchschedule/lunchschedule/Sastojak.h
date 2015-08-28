//
//  Sastojak.h
//  
//
//  Created by Filip Rajicic on 5/30/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Frizider, Recept;

@interface Sastojak : NSManagedObject

@property (nonatomic, retain) NSString * naziv;
@property (nonatomic, retain) Frizider *frizider;
@property (nonatomic, retain) NSSet *recept;
@end

@interface Sastojak (CoreDataGeneratedAccessors)

- (void)addReceptObject:(Recept *)value;
- (void)removeReceptObject:(Recept *)value;
- (void)addRecept:(NSSet *)values;
- (void)removeRecept:(NSSet *)values;

@end
