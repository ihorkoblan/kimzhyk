//
//  DBSong.m
//  KimZhyk
//
//  Created by Ihor on 6/6/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "DBSong.h"


@implementation DBSong

@dynamic udid;
@dynamic name;
@dynamic notes;



- (void)addNotesObject:(DBNote *)value {
    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    
    [self willChangeValueForKey:@"notes"
                withSetMutation:NSKeyValueUnionSetMutation
                   usingObjects:changedObjects];

    [self.notes addObject:value];
    [self didChangeValueForKey:@"notes"
               withSetMutation:NSKeyValueUnionSetMutation
                  usingObjects:changedObjects];
}

- (void)removeNotesObject:(DBNote *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    
    [self willChangeValueForKey:@"notes"
                withSetMutation:NSKeyValueMinusSetMutation
                   usingObjects:changedObjects];
    [self.notes removeObject:value];
    [self didChangeValueForKey:@"notes"
               withSetMutation:NSKeyValueMinusSetMutation
                  usingObjects:changedObjects];
}

- (void)addNotes:(NSSet *)values {
    [self willChangeValueForKey:@"notes"
                withSetMutation:NSKeyValueUnionSetMutation
                   usingObjects:values];
    [self.notes unionSet:values];
    [self didChangeValueForKey:@"notes"
               withSetMutation:NSKeyValueUnionSetMutation
                  usingObjects:values];
}

- (void)removeNotes:(NSSet *)values {
    [self willChangeValueForKey:@"notes"
                withSetMutation:NSKeyValueMinusSetMutation
                   usingObjects:values];
    [self.notes minusSet:values];
    [self didChangeValueForKey:@"notes"
               withSetMutation:NSKeyValueMinusSetMutation
                  usingObjects:values];
}

@end
