//
//  UICustomSwitch.h
//  VK iOS UI SDK
//
//  Created by Oleg Sehelyn && Volodymyr Shevchyk on 04.07.11.
//  Copyright 2011 Vakoms. All rights reserved.
//  www.vakoms.com
//

#import <Foundation/Foundation.h>

typedef enum {
	VKSwitchStyleBlack,
	VKSwitchStyleWhite	
} VKSwitchStyle;

@interface VKSwitch : UISlider {
	UIColor *mTintColor;
	UIView *mClippingView;
	UILabel *mRightLabel;
	UILabel *mLeftLabel;
	
    BOOL mIsOn;
	BOOL mIsSelfTouched;
	BOOL mStyle;
}

@property (nonatomic,getter=isOn) BOOL on;
@property (nonatomic,retain) UIColor *tintColor;
@property (nonatomic,retain) UIView  *clippingView;
@property (nonatomic,retain) UILabel *rightLabel;
@property (nonatomic,retain) UILabel *leftLabel;

+ (VKSwitch *) switchWithLeftText: (NSString *) pTag1 andRight: (NSString *) pTag2;
- (id)initWithFrame:(CGRect)pFrame andStyle:(VKSwitchStyle)pStyle;

- (void)setOn:(BOOL)pOn animated:(BOOL)pAnimated;
- (void)scaleSwitch:(CGSize) pNewSize;

@end