//
//  NedeljniRasporedSingleton.h
//  lunchschedule
//
//  Created by Filip Rajicic on 6/14/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NedeljniRaspored.h"

@interface NedeljniRasporedSingleton : NSObject

+ (NedeljniRasporedSingleton *)sharedInstance;

@property (strong, nonatomic) NedeljniRaspored* raspored;

- (void)dodajRecept:(NSString*)naziv zaDan:(NSString*)dan;
- (void)obrisiRecept:(NSString*)naziv zaDan:(NSString*)dan;
- (NSMutableArray*)getNedeljniRaspored;

@end
