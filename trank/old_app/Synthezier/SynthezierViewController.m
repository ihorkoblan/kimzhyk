//
//  SynthezierViewController.m
//  Synthezier
//
//  Created by Vakoms on 7/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SynthezierViewController.h"
#import "Global.h"

@implementation SynthezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];   
    
    [self.view setUserInteractionEnabled:YES];
    mNoteNamesArray = [[NSArray alloc] initWithObjects:
                       @"C1", @"C1#", @"D1",@"D1#",@"E1",@"F1",@"F1#",@"G1",@"G1#",@"A1",@"A1#",@"B1",
                       @"C2", @"C2#", @"D2",@"D2#",@"E2",@"F2",@"F2#",@"G2",@"G2#",@"A2",@"A2#",@"B2",
                       @"C3", @"C3#", @"D3",@"D3#",@"E3",@"F3",@"F3#",@"G3",@"G3#",@"A3",@"A3#",@"B3",
                       @"C4", @"C4#", @"D4",@"D4#",@"E4",@"F4",@"F4#",@"G4",@"G4#",@"A4",@"A4#",@"B4",
                       @"C5", @"C5#", @"D5",@"D5#",@"E5",@"F5",@"F5#",@"G5",@"G5#",@"A5",@"A5#",@"B5", 
                       nil];
    // DLog(@"///1/VolumeValue = %i",[[NSUserDefaults standardUserDefaults] integerForKey:@"VolumeValue"]);

//init AudioSession
    mPlaySound = [SoundGeneration new];
    [mPlaySound prepareToUse];
    
    mKeybord = [[PianoKeyboard alloc] initWithFrame:CGRectMake(0, 0, WHITE_KEY_HEIGHT, 480)];
    [self.view addSubview:mKeybord];
    mKeybord.delegate = self;   
    mKeybord.scrollingArea.scrollEnabled = NO;
    
    mSettingsViewPanel = [[SettingsView alloc] initWithFrame:CGRectMake(WHITE_KEY_HEIGHT, 0, 320, 480)];
    mSettingsViewPanel.SettingsViewdelegate=self;
    [self.view addSubview:mSettingsViewPanel.self];
    mTempYValue=0;
    mInfoAboutPiano = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"strip_piano_active1.png"]];
    [mInfoAboutPiano setClipsToBounds:YES];
    mInfoAboutActivepiano = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"strip_at_pianoinfo1.png"]];
    [self.view addSubview:mInfoAboutPiano];
    [mInfoAboutPiano addSubview:mInfoAboutActivepiano];
    mInfoAboutPiano.alpha=0.0f;
    mInfoAboutPiano.center=CGPointMake(-19, 240);
    
    [mPlaySound loadPresetInstrument:@(0)];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    if (mHideKeyboardInfoTimer != nil) {
        if ([mHideKeyboardInfoTimer isValid]) {
            [mHideKeyboardInfoTimer invalidate];
        }
        mHideKeyboardInfoTimer = nil;
    }
}

- (void) hideKeyboardinfo {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:1.5f];
    [UIView setAnimationDelegate:self];
    mInfoAboutPiano.alpha=0.0f;
    mInfoAboutPiano.center=CGPointMake(-19, 240);
    [UIView commitAnimations];
    mHideKeyboardInfoTimer = nil;
}
- (void)beginTouch:(UIPanGestureRecognizer *)recognizer {

    //NSSet *allTouches = [event allTouches];
    //UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [recognizer locationInView:mSettingsViewPanel.mInfoDisplayDelegate];
    mYValueForScrolling = touchLocation.y;
    if (touchLocation.x < 240) {                          
        if (mHideKeyboardInfoTimer != nil) {
            if ([mHideKeyboardInfoTimer isValid]) {
                [mHideKeyboardInfoTimer invalidate];
            }
            mHideKeyboardInfoTimer = nil;
        }
    }
}

- (void)changeTouch:(UIPanGestureRecognizer *)recognizer {
//    NSSet *allTouches = [event allTouches];
//    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [recognizer locationInView:mSettingsViewPanel.mInfoDisplayDelegate];
    mDeltaY = touchLocation.y - mYValueForScrolling;
    mScrolMemoryY=mTempYValue+mDeltaY;
    if (touchLocation.x < 240){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationDelegate:mSettingsViewPanel.mInfoDisplayDelegate];
        mInfoAboutPiano.center=CGPointMake(32, 240);
        mInfoAboutPiano.alpha=0.8f;
        [UIView commitAnimations];
    }
    
    mLeftBorder = -mScrolMemoryY*(WHITE_KEYS_SUM*WHITE_KEY_WIDTH)/480;
    mRightBorder= -mScrolMemoryY*(WHITE_KEYS_SUM*WHITE_KEY_WIDTH)/480;
    if((touchLocation.x<240)&&(mLeftBorder>-50)&&(mRightBorder<WHITE_KEYS_SUM*WHITE_KEY_WIDTH-480+50)) {
        [mKeybord.scrollingArea setContentOffset:CGPointMake(0,-mScrolMemoryY*(WHITE_KEYS_SUM*WHITE_KEY_WIDTH)/480)];
        mInfoAboutActivepiano.center=CGPointMake(19, -(mScrolMemoryY*(WHITE_KEYS_SUM*WHITE_KEY_WIDTH)/480)*440/(WHITE_KEYS_SUM*WHITE_KEY_WIDTH)+58); 
    }   
}

-(void)endTouch:(UIPanGestureRecognizer *)recognizer {

    mTempYValue = mScrolMemoryY;
    if (mKeybord.scrollingArea.contentOffset.y<0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [mKeybord.scrollingArea setContentOffset:CGPointMake(0,0)];
        mTempYValue=0;
        [UIView commitAnimations];
    }
    
    if (mKeybord.scrollingArea.contentOffset.y>(WHITE_KEYS_SUM*WHITE_KEY_WIDTH-480)) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [mKeybord.scrollingArea setContentOffset:CGPointMake(0,WHITE_KEYS_SUM*WHITE_KEY_WIDTH-480)];
        mTempYValue =-350;
        [UIView commitAnimations];
    }

    if (mHideKeyboardInfoTimer != nil) {
        if ([mHideKeyboardInfoTimer isValid]) {
            [mHideKeyboardInfoTimer invalidate];
        }
        mHideKeyboardInfoTimer = nil;
    }
    mHideKeyboardInfoTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(hideKeyboardinfo) userInfo:nil repeats:NO];
    
    
}

- (void) startPlayNote:(NSNumber*)pNote {
    [mPlaySound startPlayNote:[pNote integerValue]];

    NSString *str =[[NSString alloc] initWithFormat:@"%@",[mNoteNamesArray objectAtIndex:[pNote integerValue]-1]]; 
    [mSettingsViewPanel.mNoteValueAtInfoDisplay setText:str];
    [str release];
}

- (void)stopPlayNote:(NSNumber*)pNote {
    [mPlaySound stopPlayNote:[pNote integerValue]];
    [mSettingsViewPanel.mNoteValueAtInfoDisplay setText:@""];
}

- (void)ChussedInstrument:(NSNumber *) instrumNumber {
    [mPlaySound loadPresetInstrument:instrumNumber];
}

- (void)dealloc {
    
    [mPlaySound release];
    [mKeybord release];
    [mInfoAboutPiano release];
    [mInfoAboutActivepiano release];
    [mNoteNamesArray release];
    [mSettingsViewPanel release];
    [mPlaySound release];
    [mInfoAboutPiano release];
    [mInfoAboutActivepiano release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
//     (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
