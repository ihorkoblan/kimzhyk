//
//  DBSong.h
//  KimZhyk
//
//  Created by Ihor on 6/6/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DBNote.h"

@class NSManagedObject;

@interface DBSong : NSManagedObject

@property (nonatomic) int16_t udid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSMutableSet *notes;

@end

@interface DBSong (CoreDataGeneratedAccessors)

- (void)addNotesObject:(DBNote *)value;
- (void)removeNotesObject:(DBNote *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

@end
