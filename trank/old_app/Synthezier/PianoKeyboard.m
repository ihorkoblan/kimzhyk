//
//  PianoKeyboard.m
//  Synthezier
//
//  Created by Lion User on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PianoKeyboard.h"
#import "Global.h"

@implementation PianoKeyboard
@synthesize delegate = mDelegate;

@synthesize scrollingArea = mScrollerViewForKeyboard;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        UIImageView *lWall=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_open1@2x.png"]];
        [lWall setFrame:self.bounds];
        mArrayWithRects = [NSMutableArray new];
        mTagsForBlackButtons = [NSMutableArray new];
        self.scrollingArea.delegate=self;        
        //background under the pianokeyboard
        UIImageView *lbackgroundOnScroller=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_open1@2x.png"]];
        [lbackgroundOnScroller setFrame:CGRectMake(-40, 0, 240, 480)];
        [self addSubview:lbackgroundOnScroller];
        
        mScrollerViewForKeyboard = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:mScrollerViewForKeyboard];
        CGRect lRect;
        mWhiteButtonTag = 0;
        mBlackButtonTag =0;
        for(NSInteger i=0 ; i < WHITE_KEYS_SUM ; i++) {//CREATE WHITE KEYS
            lRect = CGRectMake(START_X_POSITION_TO_WHITE_KEY+0,0+i*(WHITE_KEY_WIDTH), WHITE_KEY_HEIGHT-0, WHITE_KEY_WIDTH);
            [self createKey:mScrollerViewForKeyboard withRect:lRect :[UIColor redColor]:i:true]; 
            [mArrayWithRects addObject:[NSValue valueWithCGRect:lRect]];
        }
        
        for(NSInteger i=0 ; i < WHITE_KEYS_SUM ; i++){//CREATE BLACK KEYS
            if([self keyIsBlack:i]==true){
                lRect = CGRectMake(START_X_POSITION_TO_BLACK_KEY,35+(i-1)*(WHITE_KEY_WIDTH), BLACK_KEY_HEIGHT, BLACK_KEY_WIDTH);
                [self createKey:mScrollerViewForKeyboard withRect:lRect :[UIColor blueColor]:i:false]; 
                  [mArrayWithRects addObject:[NSValue valueWithCGRect:lRect]];
            }
        }
        mScrollerViewForKeyboard.contentSize = CGSizeMake(WHITE_KEY_HEIGHT,WHITE_KEY_WIDTH*WHITE_KEYS_SUM);
    }
    return self;
}

- (void)createKey:(UIView *)pView withRect:(CGRect)pRect :(UIColor *)pColor :(NSInteger)pNoteNumber :(Boolean)pCreateWhiteKey {
    mKey = [[UIButton alloc] initWithFrame:pRect];
  // mKey.mPianoKeyDelegate=self;
    if(pCreateWhiteKey == true){
            if ([self keyIsBlack:pNoteNumber]==false) {
                mWhiteButtonTag +=1;
            }
            else {
                mWhiteButtonTag +=2;
                [mTagsForBlackButtons addObject:[NSNumber numberWithInt:mWhiteButtonTag-1]];
            }
        mKey.tag = mWhiteButtonTag;
    }    
    if (pCreateWhiteKey == false) {
        mBlackButtonTag = [[mTagsForBlackButtons objectAtIndex:0] intValue];
        mKey.tag = mBlackButtonTag;
        [mTagsForBlackButtons removeObjectAtIndex:0];
    }
    if (pRect.size.width > BLACK_KEY_HEIGHT+10) {
        //[mKey setImage:[UIImage imageNamed:@"white@2x.png"] forState:UIControlStateNormal];
        [mKey setBackgroundImage:[UIImage imageNamed:@"white@2x.png"] forState:UIControlStateNormal];
       // [mKey setBackgroundColor:[UIColor redColor]];
        [mKey setBackgroundImage:[UIImage imageNamed:@"white_active@2x.png"] forState:UIControlStateHighlighted];
    } else {
        //[mKey setImage:[UIImage imageNamed:@"black@2x.png"] forState:UIControlStateNormal];
        //[mKey setBackgroundColor:[UIColor greenColor]];
       [mKey setBackgroundImage:[UIImage imageNamed:@"black@2x.png"] forState:UIControlStateNormal];
    [mKey setBackgroundImage:[UIImage imageNamed:@"black_active2@2x.png"] forState:UIControlStateHighlighted];
    };
    [pView addSubview:mKey];
    [mKey addTarget:self action:@selector(keyPressed:) forControlEvents:UIControlEventTouchDown];
    [mKey addTarget:self action:@selector(keyUP:) forControlEvents:UIControlEventTouchUpInside];
    [mKey addTarget:self action:@selector(keyUP:) forControlEvents:UIControlEventTouchUpOutside];
}
- (IBAction)keyPressed:(id)sender {
    if ([mDelegate respondsToSelector:@selector(startPlayNote:)]) {
        [mDelegate performSelector:@selector(startPlayNote:) withObject:[NSNumber numberWithInteger:((UIButton*)sender).tag]];
    }
}

- (IBAction)keyUP:(id)sender {
    if ([mDelegate respondsToSelector:@selector(stopPlayNote:)]) {
        [mDelegate performSelector:@selector(stopPlayNote:) withObject:[NSNumber numberWithInteger:((UIButton*)sender).tag] afterDelay:0.2];
    }
}

- (BOOL)keyIsBlack:(NSInteger)pNoteNumber  {
    if (((pNoteNumber % WHITE_KEYS_IN_OCTAVA == 0)||((pNoteNumber - 3)%WHITE_KEYS_IN_OCTAVA == 0)))   {
        return NO;
    }
    else {
        return YES;
    }
}

-(void)dealloc{
    [mTagsForBlackButtons release];
    [mScrollerViewForKeyboard release];
    [mTagsForBlackButtons release];
    [mDelegate release];
    [super dealloc];
}

@end
