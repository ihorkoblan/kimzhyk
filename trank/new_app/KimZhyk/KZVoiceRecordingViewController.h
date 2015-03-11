//
//  KZVoiceRecordingViewController.h
//  KimZhyk
//
//  Created by Пользователь on 11.03.15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface KZVoiceRecordingViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@end
