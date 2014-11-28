//
//  PianoKeyboard.h
//  Synthezier
//
//  Created by Lion User on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "SoundGeneration.h"
#import "PianoKey.h"



@class SoundGeneration;

@interface PianoKeyboard : UIView <UIScrollViewDelegate,UIGestureRecognizerDelegate,PianoKeyDelegate>{
    NSInteger mWhiteButtonTag;
    NSInteger mBlackButtonTag;
    NSMutableArray *mTagsForBlackButtons;
    id mDelegate;
    UIScrollView *mScrollerViewForKeyboard;
    UIButton *mKey;
    //UIImageView *mKey;
    NSMutableArray *mArrayWithRects;
};
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) UIScrollView *scrollingArea;

-(void)createKey:(UIView *)pView withRect:(CGRect)pRect:(UIColor*)pColor:(NSInteger)pNoteNumber:(Boolean)pCreateWhiteKey;
@end
