//
//  KZPianoSlider.h
//  KimZhyk
//
//  Created by Ihor Koblan on 3/19/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KZPianoSliderDelegate <NSObject>
- (void)KZPianoSlider:(id)sender valueChanged:(CGFloat)value;
@end

@interface KZPianoSlider : UIImageView {
    UIImageView *_thumb;
    CGFloat _deltaX;
}
@property (nonatomic, assign) CGFloat thumbWidth;
@property (nonatomic, assign) CGFloat position;
@property (nonatomic, unsafe_unretained) id<KZPianoSliderDelegate> delegate;
@end


