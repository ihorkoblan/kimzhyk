//
//  KZSynthesizer.h
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface KZSynthesizer : NSObject<AVAudioSessionDelegate,UIApplicationDelegate>{
    NSInteger mTranspose;
}
- (void) registerForUIApplicationNotifications ;
- (void) startPlayNote:(NSInteger)pNote;
- (void) stopPlayNote:(NSInteger)pNote;
-(void)loadPresetInstrument:(NSNumber*)pInstrumentNumber;
-(NSNumber*)returnInstrumentNumber:(NSNumber*)pInstrumentNumber;
-(void)prepareToUse;
@end