//
//  EPSSampler.h
//
//  Created by Peter Stuart on 02/10/13.
//  Copyright (c) 2013 Electric Peel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssertMacros.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
static NSString *kNoteStartedPlayNotification = @"note_started_play";
static NSString *kNoteStopedPlayNotification = @"note_stoped_play";

@interface EPSSampler : NSObject <AVAudioSessionDelegate>

@property (nonatomic, assign) BOOL isRecording;
@property (nonatomic, strong) NSURL *presetURL;

- (id)initWithPresetURL:(NSURL *)url;

- (void)startPlayingNote:(UInt32)note withVelocity:(double)velocity;
- (void)stopPlayingNote:(UInt32)note;

- (AUGraph *)processingGraph;

@end