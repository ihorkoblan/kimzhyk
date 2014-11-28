//
//  SynthezierViewController.h
//  Synthezier
//
//  Created by Vakoms on 7/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundGeneration.h"
#import "PianoKeyboard.h"
#import "SettingsView.h"

@protocol ControlPlayingDelegate <NSObject>
- (void) startPlayNote:(NSNumber*)Note;
- (void) stopPlayNote:(NSNumber*)Note;
@end

@interface SynthezierViewController : UIViewController<UIScrollViewDelegate,UIApplicationDelegate,SettingsViewProtocol,ControlPlayingDelegate>{
    SoundGeneration *mPlaySound;
    PianoKeyboard *mKeybord;
    SettingsView *mSettingsViewPanel;
    NSInteger mYValueForScrolling;
    NSInteger mDeltaY;
    NSInteger mTempYValue;
    NSInteger mScrolMemoryY;
    UIImageView *mInfoAboutPiano;
    UIImageView *mInfoAboutActivepiano;
    NSTimer *mHideKeyboardInfoTimer;
    NSArray *mNoteNamesArray;
    Float32 mLeftBorder;
    Float32 mRightBorder;
}
@end
