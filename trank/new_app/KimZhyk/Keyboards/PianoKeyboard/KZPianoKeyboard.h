//
//  KZPianoKeyboard.h
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZKeyboard.h"
#import "KZPianoKey.h"
#import "KZSoundStruct.h"


// - - - - - - - - KZPianoKeyboard - - - - - - -
@class KZPianoSlider;
@class KZPianoView;
@protocol KZPianoSliderDelegate;

@interface KZPianoKeyboard : KZKeyboard<KZPianoSliderDelegate> {
    KZPianoView *_pianoView;
}

@end


// - - - - - - - - KZPianoView - - - - - - -
@interface KZPianoView : UIScrollView
@end


// - - - - - - - - KZPianoSlider - - - - - - -
@interface KZPianoSlider : UIImageView {
    UIImageView *_thumb;
    CGFloat _positionXDelta;
}
@property (nonatomic, assign) CGFloat thumbWidth;
@property (nonatomic, assign) CGFloat position;
@property (nonatomic, unsafe_unretained) id<KZPianoSliderDelegate> delegate;
@end

@protocol KZPianoSliderDelegate <NSObject>
- (void)KZPianoSlider:(id)sender valueChanged:(CGFloat)value;
@end