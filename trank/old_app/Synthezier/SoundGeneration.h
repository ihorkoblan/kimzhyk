//
//  SoundGeneration.h
//  Synthezier
//
//  Created by Lion User on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "SettingsView.h"

@interface SoundGeneration : NSObject<AVAudioSessionDelegate,UIApplicationDelegate>

- (void) registerForUIApplicationNotifications ;
- (void) startPlayNote:(NSInteger)pNote;
- (void) stopPlayNote:(NSInteger)pNote;
- (void)loadPresetInstrument:(NSNumber*)pInstrumentNumber;
- (NSNumber*)returnInstrumentNumber:(NSNumber*)pInstrumentNumber;
- (void)prepareToUse;

@end
