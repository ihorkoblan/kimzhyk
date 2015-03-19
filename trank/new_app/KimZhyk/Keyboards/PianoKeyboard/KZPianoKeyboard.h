//
//  KZPianoKeyboard.h
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZKeyboard.h"
#import "KZPianoKey.h"


// - - - - - - - - KZPianoKeyboard - - - - - - -

@class KZPianoSlider;
@class KZPianoView;

@protocol KZPianoSliderDelegate;
@protocol KZPianoViewDelegate;

@interface KZPianoKeyboard : KZKeyboard<KZPianoSliderDelegate,KZPianoViewDelegate> {
    KZPianoView *_pianoView;
}
- (void)startPlayingSound:(KZSound *)sound;
- (void)stopPlayingSound:(KZSound *)sound;
@end

// - - - - - - - - KZPianoView - - - - - - -

@protocol KZPianoViewDelegate <NSObject>
- (void)KZPianoView:(id)pianoView pressedKey:(KZKey *)key;
@end

@interface KZPianoView : UIScrollView
@property (nonatomic, unsafe_unretained) id<KZPianoViewDelegate> delegate;
- (void)startPlayingSound:(KZSound *)sound;
- (void)stopPlayingSound:(KZSound *)sound;
@end