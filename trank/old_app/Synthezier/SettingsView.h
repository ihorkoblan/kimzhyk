
//
//  SettingsView.h
//  Synthezier
//
//  Created by Lion User on 27/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKDial.h"
#import "VKSwitch.h"
#import "VKDialDelegate.h"
#import "OpenCloseButtonOnSettingsView.h"
#import "KZSettings.h"
#import "KZDisplay.h"
#import "KZVolumerView.h"

@protocol SettingsViewProtocol <NSObject>
-(void)ChussedInstrument:(NSNumber*)instrumNumber;
-(void)beginTouch:(UIPanGestureRecognizer*)recognizer;
-(void)changeTouch:(UIPanGestureRecognizer*)recognizer;
-(void)endTouch:(UIPanGestureRecognizer*)recognizer;
@end
@interface SettingsView : UIView<VKDialDelegate,MoveSettingsPanelDelegate>{
    KZDisplay *_display;
    
    BOOL isSettingsPanelClose;
    BOOL isImageChange;
    UIButton *mButtonOpenCloseSettingsView;
    UISlider *mSliderTranspose;
    UIImageView *mInfoDisplay;
    UILabel *mVolumeValueAtInfoDisplay;
    UILabel *mTransposeValueAtInfoDisplay;
    UILabel *mNoteValueAtInfoDisplay;
    VKDial *mVolumer;
    VKSwitch *mSwithVolumer;
    UIScrollView *mInstrumentScrollView;
    NSInteger mVolume;
    NSArray *mInstrumentBtnArray;
    UIImageView *mMakeInstrumentActive;
    NSInteger mBtnTag;
    CGPoint mSaveLocation;
    id <SettingsViewProtocol> SettingsViewdelegate;
    BOOL isHorizontalScroll;
};
@property (nonatomic, retain) UILabel *mNoteValueAtInfoDisplay;
@property (nonatomic, retain) UIImageView *mInfoDisplayDelegate;
@property (nonatomic, assign) id<SettingsViewProtocol> SettingsViewdelegate;
-(void)chooseInstrument:(id)sender;

@end

