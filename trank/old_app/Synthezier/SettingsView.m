//
//  SettingsView.m
//  Synthezier
//
//  Created by Lion User on 27/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsView.h"
#import "SynthezierViewController.h"
#import "Global.h"

@implementation SettingsView
@synthesize mNoteValueAtInfoDisplay;
@synthesize SettingsViewdelegate;
@synthesize mInfoDisplayDelegate=mInfoDisplay;
- (id)initWithFrame:(CGRect)frame
{   
       self = [super initWithFrame:frame];
    if (self) {

        UIImageView *lBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_open1@2x.png"]];
        [lBackground setFrame:CGRectMake(0, 0, 340, 480)];
        [self addSubview:lBackground];

        _display = [[KZDisplay alloc] initWithFrame:CGRectMake(20.0f, 50.0f, 60.0f, 290.0f)];
        _display.volume = [KZSettings settings].volume;
        _display.transpose = [KZSettings settings].transpose;
        [self addSubview:_display];
        [_display release];
        

        UISlider *lTransposeSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 420, 100, 10)];
        [lTransposeSlider setMaximumTrackImage:[UIImage imageNamed:@"slider_bg_2@2x.png"] forState:UIControlStateNormal];
        [lTransposeSlider setMinimumTrackImage:[UIImage imageNamed:@"slider_bg@2x.png"] forState:UIControlStateNormal];
        [lTransposeSlider setThumbImage:[UIImage imageNamed:@"slider_button@2x.png"] forState:UIControlStateNormal];
        lTransposeSlider.maximumValue = 12;
        lTransposeSlider.minimumValue = -12;
        lTransposeSlider.value = 0;
        [lTransposeSlider addTarget:self action:@selector(transposeSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:lTransposeSlider];
        [lTransposeSlider release];

        KZVolumerView *lVolumerView = [[KZVolumerView alloc] initWithFrame:CGRectMake(15.0, 10.0, 80.0, 80.0)];
        [self addSubview:lVolumerView];
        
//
////add InstrumentsView
//        
//        //add InstrumentImageView
//        UIImageView *lInstrumentImageView =[[UIImageView alloc] initWithFrame:CGRectMake(140, 15, 180, 455)];
//        [lInstrumentImageView setImage:[UIImage imageNamed:@"instruments_bg_shadow@2x.png"]];
//        [self addSubview:lInstrumentImageView];
//        //add InstrumentScrollView
//        mInstrumentScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(150, 23, 180, 435)];
//        [self addSubview:mInstrumentScrollView];
//        //add instrument1
//   
//        mInstrumentScrollView.contentSize=CGSizeMake(180, 11*150);
//        
//        //create array of Buttons
//        
//        UIButton *lInstrumentBtn1=[UIButton new];
//        UIButton *lInstrumentBtn2=[UIButton new];
//        UIButton *lInstrumentBtn3=[UIButton new];
//        UIButton *lInstrumentBtn4=[UIButton new];
//        UIButton *lInstrumentBtn5=[UIButton new];
//        UIButton *lInstrumentBtn6=[UIButton new];
//        UIButton *lInstrumentBtn7=[UIButton new];
//        UIButton *lInstrumentBtn8=[UIButton new];
//        UIButton *lInstrumentBtn9=[UIButton new];
//        UIButton *lInstrumentBtn10=[UIButton new];
//        UIButton *lInstrumentBtn11=[UIButton new];
//
//        [lInstrumentBtn1 setImage:[UIImage imageNamed:@"PIANO@2x.png"] forState:UIControlStateNormal];
//        [lInstrumentBtn2 setImage:[UIImage imageNamed:@"ACCORDEON@2x.png"] forState:UIControlStateNormal];
//        [lInstrumentBtn3 setImage:[UIImage imageNamed:@"CHURCH_ORGAN@2x.png"] forState:UIControlStateNormal];
//        [lInstrumentBtn4 setImage:[UIImage imageNamed:@"ACOUSTIC_GUITAR@2x.png"] forState:UIControlStateNormal];
//        [lInstrumentBtn5 setImage:[UIImage imageNamed:@"ELECTRIC_GUITAR@2x.png"] forState:UIControlStateNormal];        
//        [lInstrumentBtn6 setImage:[UIImage imageNamed:@"FLUTE@2x.png"] forState:UIControlStateNormal];        
//        [lInstrumentBtn7 setImage:[UIImage imageNamed:@"TENOR_SAX@2x.png"] forState:UIControlStateNormal];
//        [lInstrumentBtn8 setImage:[UIImage imageNamed:@"CELLO@2x.png.png"] forState:UIControlStateNormal];        
//        [lInstrumentBtn9 setImage:[UIImage imageNamed:@"VIOLIN@2x.png"] forState:UIControlStateNormal];
//        [lInstrumentBtn10 setImage:[UIImage imageNamed:@"TRUMPET_1@2x.png"] forState:UIControlStateNormal];
//        [lInstrumentBtn11 setImage:[UIImage imageNamed:@"STRING1@2x.png"] forState:UIControlStateNormal];
//
//
//        mInstrumentBtnArray =[[NSArray alloc] initWithObjects:lInstrumentBtn1,lInstrumentBtn2,lInstrumentBtn3,lInstrumentBtn4,lInstrumentBtn5,lInstrumentBtn6,lInstrumentBtn7,lInstrumentBtn8,lInstrumentBtn9,lInstrumentBtn10,lInstrumentBtn11,nil];
//        mBtnTag=0;        
//        mMakeInstrumentActive=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imgInstrumActive@2x.png"]];
//        [mMakeInstrumentActive setFrame:CGRectMake(-5, 5, 160, 160)];
//        
//        for (NSInteger i=0; i<11; i++) {
//            [mInstrumentScrollView addSubview:[mInstrumentBtnArray objectAtIndex:i]];
//            [[mInstrumentBtnArray objectAtIndex:i] setFrame:CGRectMake(0,-13+i*150, 170,170)];
//            [[mInstrumentBtnArray objectAtIndex:i] setTag:i];
//            [[mInstrumentBtnArray objectAtIndex:i] addTarget:self action:@selector(chooseInstrument:) forControlEvents:UIControlEventTouchDown]; 
//        }   
//        [[mInstrumentBtnArray objectAtIndex:0] addSubview:mMakeInstrumentActive]; 
//    }
//
//    ////////GR
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] 
//                                   initWithTarget:self 
//                                  action:@selector(handlePan:)];
//    [mInfoDisplay addGestureRecognizer:pan];
//    [mInfoDisplay setUserInteractionEnabled:YES];
    }
    return self;
}

- (void)transposeSliderValueChanged:(id)sender {
    if (_display) {
        UISlider *lSlider = sender;
        _display.transpose = (NSInteger)lSlider.value;
    }
}


- (void)handlePan:(UIPanGestureRecognizer*)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            [SettingsViewdelegate beginTouch:recognizer];
            break;
        case UIGestureRecognizerStateChanged:
            DLog(@"changed");
            if(fabs([recognizer velocityInView:mInfoDisplay].x)>=fabs([recognizer velocityInView:mInfoDisplay].y)){
                CGPoint location = [recognizer locationInView:self.superview];
                //if([recognizer translationInView:self.superview].x<=0){
                  //  DLog(@"left");
                   [UIView beginAnimations:nil context:nil];
                [UIView setAnimationBeginsFromCurrentState:NO];
                [UIView setAnimationDuration:0.5f];
                [UIView setAnimationDelegate:self];                 
                
                [self setCenter:CGPointMake(location.x+80, 240)];
                    [recognizer locationInView:self.superview];

                if (self.center.x < 140) {
                    [self setCenter:CGPointMake(140, 240)];
                }
                if(self.center.x > 360){
                    [self setCenter:CGPointMake(360, 240)];
                }
                [UIView commitAnimations];
             
            }else {
               // if(isHorizontalScroll==YES){
                [SettingsViewdelegate changeTouch:recognizer];
              // }
               }
            
            [recognizer setTranslation:CGPointZero inView:mInfoDisplay];
            break;
            
            //////////////
            
            
        case UIGestureRecognizerStateEnded:
            DLog(@"ended");
            
            if(fabs([recognizer velocityInView:mInfoDisplay].x)<fabs([recognizer velocityInView:mInfoDisplay].y)){
                [SettingsViewdelegate endTouch:recognizer];
            
            }
            
            CGPoint location = [recognizer locationInView:self.superview];
            if (location.x<130) {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationDuration:0.3f];
                [UIView setAnimationDelegate:self];
                [self setCenter:CGPointMake(160, 240)];
                //[mButtonOpenCloseSettingsView setImage:[UIImage imageNamed:@"arrow@2x.png"] forState:UIControlStateNormal];
            }else {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationDuration:0.3f];
                [UIView setAnimationDelegate:self];
                [self setCenter:CGPointMake(360, 240)];
                //[mButtonOpenCloseSettingsView setImage:[UIImage imageNamed:@"arrow_2@2x.png"] forState:UIControlStateNormal];
            }
            [UIView commitAnimations];
            break;
       
        default:
            break;
    }
    NSLog(@"handlePan:%i", recognizer.state);
}
-(void)chooseInstrument:(id)sender{
    [[mInstrumentBtnArray objectAtIndex:((UIButton*)sender).tag] addSubview:mMakeInstrumentActive];
    if ([SettingsViewdelegate respondsToSelector:@selector(ChussedInstrument:)]) {
        [SettingsViewdelegate performSelector:@selector(ChussedInstrument:)withObject:[NSNumber numberWithInteger:((UIButton*)sender).tag]];
    }
}

-(void)switchVolumerValueChanged{

}

-(void)beginTouchOnButton:(UIEvent *)event{

}

-(void)moveTouchOnButton:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch previousLocationInView:self.superview];
    [self setCenter:CGPointMake(location.x+130, 240)];
    if (self.center.x<140) {
        [self setCenter:CGPointMake(160, 240)];
    }
    if(self.center.x>360){
        [self setCenter:CGPointMake(360, 240)];
    }
}
-(void)endTouchOnButton:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch previousLocationInView:self.superview];
    if (location.x<130) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationDelegate:self];
        [self setCenter:CGPointMake(140, 240)];
        //[mButtonOpenCloseSettingsView setImage:[UIImage imageNamed:@"arrow@2x.png"] forState:UIControlStateNormal];
    }else {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationDelegate:self];
        [self setCenter:CGPointMake(360, 240)];
        //[mButtonOpenCloseSettingsView setImage:[UIImage imageNamed:@"arrow_2@2x.png"] forState:UIControlStateNormal];
    }
    [UIView commitAnimations];
}
-(void)valueChanged:(NSInteger)pValueChanged{
    [KZSettings settings].volume = pValueChanged;
    NSString *lInfoVolumeValue=[NSString stringWithFormat:@"%i",pValueChanged*100/127];
    [mVolumeValueAtInfoDisplay setText:lInfoVolumeValue];
    [mSwithVolumer setOn:YES animated:YES];
}





-(void)dealloc{
    [mButtonOpenCloseSettingsView release];
    [mSliderTranspose release];
    [mInfoDisplay release];
    [mVolumeValueAtInfoDisplay release];
    [mTransposeValueAtInfoDisplay release];
    [mNoteValueAtInfoDisplay release];
    [mVolumer release];
    [mSwithVolumer release];    
    [mInstrumentScrollView release];
    [mInstrumentBtnArray release];
    [super dealloc];
}

@end