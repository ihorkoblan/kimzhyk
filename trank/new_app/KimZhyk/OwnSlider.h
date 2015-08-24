//
//  OwnSlider.h
//  KimZhyk
//
//  Created by Admin on 20.08.15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OwnSliderDelegate;

@interface OwnSlider : UIControl
@property (nonatomic, unsafe_unretained) id <OwnSliderDelegate> delegate;
@property (nonatomic, strong)  UIView *lSliderIndicator;
@property (nonatomic, assign) CGFloat pianowidth;
@property (nonatomic, assign) CGPoint touchLocation;

@end



@protocol OwnSliderDelegate
@optional

- (void)OwnSlider:(id)ownslider changedvalue:(CGFloat)value whithscrollersize:(CGFloat) sizeOfScroler;

@end
