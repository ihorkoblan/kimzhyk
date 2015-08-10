//
//  DBNote.h
//  KimZhyk
//
//  Created by Ihor on 6/7/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DBSong;

@interface DBNote : NSManagedObject

@property (nonatomic) int64_t counter;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) int32_t note_value;
@property (nonatomic) float note_frequency;
@property (nonatomic) NSTimeInterval start_playing;
@property (nonatomic, retain) DBSong *song;

@end
