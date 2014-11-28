//
//  CustomDial.h
//  VK iOS UI SDK
//
//  Created by Oleg Sehelyn && Volodymyr Shevchyk on 04.07.11.
//  Copyright 2011 Vakoms. All rights reserved.
//  www.vakoms.com
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum  {
	VKDialTypeChanel,
	VKDialTypeVolume,	
    VKDialTypeNone,
    VKDialTypeDisplayDivisions
} VKDialType;

typedef enum {
    VKDialStyleStandart,
    VKDialStyleCustom
} VKDialStyle;

@interface VKDial : UIView {

	CGPoint mLocationBegan;
    CGFloat mCurrentAngle;
	CGFloat mNewAngle;
	CGFloat mSaveAngle;

                            NSInteger mNumbSegmentsDisp;
                            
                           
	CGFloat mMaxValue;
	UIImageView *mTimeChange;
	UILabel* mResultLabel;
	NSString* mValue;
    //result label background
    UIImageView *mLabelBackgroundImageView;
    UIImage *mLabelBackgroundImage;
    //definning background images
    UIImageView *mBackgroundImageView;
    UIImage *mBackgroundImage;
    //current style
    VKDialStyle mCurrentStyle;
    //current style
    VKDialType mCurrentType;
    NSArray *mImageNamesArray;///
    BOOL mStartLocation;
    BOOL mIsLabelHidden;
    Float32 mProbaAngle;
	id mDelegate;
}
//result label value
@property (nonatomic, retain) NSString* value;
//delegate
@property (nonatomic, assign) id delegate;
//max value of instance. If this instance is not initialized then by default it will become 10.
@property (nonatomic, assign) CGFloat maxValue;
//manages result label appearance
@property (nonatomic, assign) BOOL labelHidden;
//instance's current style
@property (nonatomic, readonly) VKDialStyle style;
//instance's current type
@property (nonatomic, readonly) VKDialType type;

//inits instance with custom style (3 images). if image is nil then it will not be displayed
- (id) initWithFrame:(CGRect)pFrame custonStyleBackgroundImage:(UIImage*)pBackgroundImage arrowImage:(UIImage*) pArrowImage labelImage:(UIImage*) pLabelImage type:(VKDialType) pType;
//inits with defined type
- (id) initWithFrame:(CGRect) pFrame type:(VKDialType)pType;
//inits dial with default type, style and label position
- (id) initWithFrame:(CGRect) pFrame;

//defines current dial value
-(void) setCurrentValue:(CGFloat) pValue;
//text color of result label
-(void) setTextColor:(UIColor*)pColor;
@end
