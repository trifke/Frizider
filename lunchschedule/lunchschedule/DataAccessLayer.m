//
//  DataAccessLayer.m
//  lunchschedule
//
//  Created by Filip Rajicic on 5/27/15.
//  Copyright (c) 2015 Filip Rajicic. All rights reserved.
//


#import "DataAccessLayer.h"
#import "Sastojak.h"
#import "Frizider.h"

@interface DataAccessLayer ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *storeCoordinator;
- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;
@end

@implementation DataAccessLayer

@synthesize storeCoordinator;
@synthesize managedObjectModel;
@synthesize managedObjectContext;

+ (DataAccessLayer *)sharedInstance {
    __strong static DataAccessLayer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataAccessLayer alloc] init];
        sharedInstance.storeCoordinator = [sharedInstance persistentStoreCoordinator];
        sharedInstance.managedObjectContext = [sharedInstance managedObjectContext];
    });
    return sharedInstance;
}

#pragma mark - Core Data

- (void)saveContext {
    NSError *error = nil;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            NSLog(@"error: %@", error.userInfo);
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    if (managedObjectContext != nil)
    {
        return managedObjectContext;
    }
    
    if (storeCoordinator != nil)
    {
        self.managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:storeCoordinator];
    }
    return managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil)
    {
        return managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"database" withExtension:@"momd"];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (storeCoordinator != nil)
    {
        return storeCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"model.sqlite"];
    
    NSError *error = nil;
    self.storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return storeCoordinator;
}

#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Methods

-(void)initSastojke:(NSArray*)sastojci{
    
    NSArray* sviSastojci = [self uzmiSveSastojke];
    if (sviSastojci.count!=0){
        return;
    }
    
    for (NSString* sastojak in sastojci) {
        Sastojak *newSastojak = [NSEntityDescription insertNewObjectForEntityForName:@"Sastojak"
                                                              inManagedObjectContext:self.managedObjectContext];
        
        newSastojak.naziv = sastojak;
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Failed to save - error: %@", [error localizedDescription]);
        }
        else{
            NSLog(@"Save ok to DB:");
        }
    };
}

-(void)dodajSastojak:(NSString*)naziv{
    NSArray* arr = [self uzmiSastojak:naziv];
    if (arr.count != 0){
        NSLog(@"ne ubacuj u bazu, vec postoji taj sastojak");
        return;
    }
    Sastojak *newSastojak = [NSEntityDescription insertNewObjectForEntityForName:@"Sastojak"
        inManagedObjectContext:self.managedObjectContext];
    
    newSastojak.naziv = naziv;
    newSastojak.frizider = nil;
    newSastojak.recept = nil;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
    else{
        NSLog(@"Save ok to DB:");
    }
}

- (NSArray*)uzmiSveSastojke{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Sastojak"];
    NSError *error = nil;
    return [self.managedObjectContext executeFetchRequest:request error:&error];
}

- (NSArray*)uzmiSastojak:(NSString*)sastojak{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Sastojak"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"naziv == %@", sastojak];
    [request setPredicate:predicate];
    NSError *error = nil;
    return [self.managedObjectContext executeFetchRequest:request error:&error];
}

#pragma mark - Frizider

-(Frizider*)getFrizider{
    Frizider *frizider;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Frizider"];
    NSError *error = nil;
    NSMutableArray* arr = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (arr.count == 0){
        arr[0] = [NSEntityDescription insertNewObjectForEntityForName:@"Frizider"
                                               inManagedObjectContext:self.managedObjectContext];
    }
    frizider = arr[0];
    return frizider;
}

-(void)dodajUFrizider:(Frizider*)frizider sastojak:(NSString*)sastojak{
    NSArray* arrSastojci = [self uzmiSastojak:sastojak];
    
    if (arrSastojci.count == 0){//ne postoji sastojak dodaj novi
        [self dodajSastojak:sastojak];
        arrSastojci = [self uzmiSastojak:sastojak];
    }
    
    [frizider addSastojciObject:arrSastojci[0]];
    
    NSError* error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
    else{
        NSLog(@"Save ok to DB:");
    }
}

#pragma mark - Recepti

- (NSArray*)dohvatiRecepte{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Recept"];
    NSError *error;
    NSArray* arr = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    return arr;
}

- (Recept*)dodajRecept:(NSDictionary*)recDict{
    Recept *newRecept = [NSEntityDescription insertNewObjectForEntityForName:@"Recept"
                                                          inManagedObjectContext:self.managedObjectContext];
    newRecept.naziv = [recDict valueForKey:@"Naziv"];
    newRecept.opis = [recDict valueForKey:@"Opis"];
    newRecept.priprema = [recDict valueForKey:@"Priprema"];
    
    for (NSString* sastojak in [recDict valueForKey:@"Sastojci"]) {
        Sastojak* sas = [self uzmiSastojak:sastojak][0];
        [newRecept addSastojciObject:sas];
    }
        
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
        return nil;
    }else{
        NSLog(@"Save ok to DB:");
        return newRecept;
    }
}

- (void)obrisiRecept:(Recept*)recept{
    [self.managedObjectContext deleteObject:recept];
    [self.managedObjectContext processPendingChanges];
}

#pragma mark - raspored

- (NedeljniRaspored*) getNedeljniRaspored{
    NedeljniRaspored *nedRaspored;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"NedeljniRaspored"];
    NSError *error = nil;
    NSMutableArray* arr = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (arr.count == 0){
        Raspored* raspored;
        arr[0] = [NSEntityDescription insertNewObjectForEntityForName:@"NedeljniRaspored"
                                               inManagedObjectContext:self.managedObjectContext];
        nedRaspored = arr[0];
        for (int i=0; i<7; i++) {
            raspored = [NSEntityDescription insertNewObjectForEntityForName:@"Raspored"
                                                     inManagedObjectContext:self.managedObjectContext];
            switch (i){
                case 0:
                    raspored.dan = @"Ponedeljak";
                    break;
                case 1:
                    raspored.dan = @"Utorak";
                    break;
                case 2:
                    raspored.dan = @"Sreda";
                    break;
                case 3:
                    raspored.dan = @"Cetvrtak";
                    break;
                case 4:
                    raspored.dan = @"Petak";
                    break;
                case 5:
                    raspored.dan = @"Subota";
                    break;
                case 6:
                    raspored.dan = @"Nedelja";
                    break;
            }
            [nedRaspored addRasporedObject:raspored];
        }
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Failed to save - error: %@", [error localizedDescription]);
        }
        else{
            NSLog(@"Save ok to DB:");
        }
    }
    nedRaspored = arr[0];
    
    return nedRaspored;
}


@end
