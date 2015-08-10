//
//  DBManager.h
//  iCount
//
//  Created by Ihor on 5/29/15.
//  Copyright (c) 2015 Ihor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define URL_DOCUMENTS [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]

@interface DBManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)save;
+ (DBManager *)instance;

+ (NSArray *)fetchWithEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;
+ (id)newObjectForEntity:(NSString *)entity;
+ (void)deleteObject:(NSManagedObject *)object;
@end
