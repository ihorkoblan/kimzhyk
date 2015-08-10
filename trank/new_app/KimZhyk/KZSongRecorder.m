//
//  KZSongRecorder.m
//  KimZhyk
//
//  Created by Ihor on 6/6/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZSongRecorder.h"
#import "DBManager.h"
#import "DBSong.h"
#import "EPSSampler.h"

@interface KZSongRecorder () {
    NSTimeInterval _startRecordingTime;
}
@property (nonatomic, strong) DBSong *song;
@property (nonatomic, strong) NSMutableArray *songNotes;

@end

@implementation KZSongRecorder

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isSongLoaded = NO;
        self.songNotes = [NSMutableArray new];
    }
    return self;
}

- (BOOL)createNewSongWithName:(NSString *)name {

    BOOL lIsNewSong = ([DBManager fetchWithEntity:@"DBSong" predicate:[NSPredicate predicateWithFormat:@"name == %@",name] sortDescriptors:nil].count == 0);
    if (lIsNewSong) {
        
        self.song = (DBSong *)[DBManager newObjectForEntity:@"DBSong"];
        self.song.name = name;
        [[DBManager instance] save];
    } else {
        UIAlertView *lalert = [[UIAlertView alloc] initWithTitle:nil message:@"Song with such name has already existed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [lalert show];
    }
    return lIsNewSong;
}

- (void)startRecord {
    
    _startRecordingTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"r_t: %f",_startRecordingTime - 1.0f);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noteStartedPlaying:) name:kNoteStartedPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noteStopedPlaying:) name:kNoteStopedPlayNotification object:nil];
}

- (void)stopRecord {
    if (self.songNotes.count > 0) {
        self.isSongLoaded = YES;
    }
    NSLog(@"notes: %@",self.songNotes);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNoteStartedPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNoteStopedPlayNotification object:nil];
}

- (void)noteStartedPlaying:(NSNotification *)notification {
    NSInteger lNoteNumber = [((NSNumber *)notification.object) integerValue];
    
    NSTimeInterval lStartingTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"starting_1    : %@",@(lStartingTime));
    NSMutableDictionary *lDict = [NSMutableDictionary dictionaryWithDictionary:@{@"note":@(lNoteNumber),@"start_time":@(lStartingTime), @"counter":@(self.songNotes.count)}];
    
    [self.songNotes addObject: lDict];
    
}

- (void)noteStopedPlaying:(NSNotification *)notification {
    NSInteger lNoteNumber = [((NSNumber *)notification.object) integerValue];
    NSArray *lPlayingNotes = [self.songNotes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"note == %@",@(lNoteNumber)]];
    
    if (lPlayingNotes > 0) {
        NSMutableDictionary *lNoteDict = [lPlayingNotes lastObject];
        NSInteger lCounter = [lNoteDict[@"counter"] integerValue];
        
        NSTimeInterval lStartingTime = [lNoteDict[@"start_time"] doubleValue];
        NSLog(@"starting_2    : %@",@(lStartingTime));
        
        NSTimeInterval lNow = [[NSDate date] timeIntervalSince1970];
        NSLog(@"now         : %@",@(lNow));
        
        NSTimeInterval lDuration = lNow - lStartingTime;
        NSLog(@"interval: %@",@(lDuration));
        [lNoteDict setValue:@(lDuration) forKey:@"duration"];
        
        [self.songNotes replaceObjectAtIndex:lCounter withObject:lNoteDict];
    }
}

- (BOOL)saveSongWithName:(NSString *) name {
    BOOL lIsNewSong = ([DBManager fetchWithEntity:@"DBSong" predicate:[NSPredicate predicateWithFormat:@"name == %@",name] sortDescriptors:nil].count == 0);
    if (lIsNewSong) {
        self.song = (DBSong *)[DBManager newObjectForEntity:@"DBSong"];
        self.song.name = name;
        [[DBManager instance] save];
        
        for (NSDictionary *dict in self.songNotes) {
            DBNote *lNote = (DBNote *)[DBManager newObjectForEntity:@"DBNote"];
            lNote.note_value = (int32_t)[dict[@"note"] integerValue];
            lNote.duration = [dict[@"duration"] doubleValue];
            lNote.start_playing = [dict[@"start_time"] doubleValue] - _startRecordingTime;
            NSLog(@"start_time: %f - %f = %f",[dict[@"start_time"] doubleValue],_startRecordingTime,lNote.start_playing);
            lNote.counter = (int32_t)[dict[@"counter"] integerValue];
            [self.song addNotesObject:lNote];
            [[DBManager instance] save];
        }
        
        
        [self.songNotes removeAllObjects];
    }
    return lIsNewSong;
}

@end
