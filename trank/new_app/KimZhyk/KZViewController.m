//
//  KZViewController.m
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZViewController.h"
#import "KZGlobal.h"

//#import "KZStaveView.h"
#import "KZRecordViewController.h"
#import "KZSongsListViewController.h"
#import "KZKeyboardManager.h"
#import "PianoView.h"
#import "KZNoteRecorder.h"
#import "KZSongRecorder.h"
#import "KZTextAlert.h"
#import "OwnSlider.h"


#define SCROLLER_TAG 1
#define SAVE_ALERT_TAG 3


@interface KZViewController () <PianoViewDelegate, UIScrollViewDelegate, UIAlertViewDelegate, KZTextAlertDelegate, OwnSliderDelegate>{
    KZNoteRecorder *_noteRecorder;
    PianoView *pianoView;
    OwnSlider *ownslider;
    
    
}

@property (nonatomic, strong) UIScrollView *pianoScrollView;
@property (nonatomic, strong) UIScrollView *scroller;
@property (nonatomic, strong) UIView *lOwnScroller;
@property (nonatomic, strong) KZSettingsView *settingsView;
@property (nonatomic, strong) KZKeyboardManager *keyboardManager;
@property (nonatomic, strong) KZSongRecorder *recorder;
@property (nonatomic) CGFloat width;

@end


@implementation KZViewController

#pragma mark - autorotate
//iOS 6+
- (BOOL)shouldAutorotate {
    return YES;
}
//iOS 6+
- (NSUInteger)supportedInterfaceOrientations {
    return (UIInterfaceOrientationMaskLandscape);
}

#pragma mark - life cicle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.multipleTouchEnabled = YES;
    self.view.userInteractionEnabled = YES;
    
    [self mainInit];
}

- (void)pianoView:(PianoView *)piano keyDown:(short)key {

}

- (void)pianoView:(PianoView *)piano keyUp:(short)key {

}

- (void)mainInit {
    
    _isRecording = NO;
    self.recorder = [KZSongRecorder new];
    CGFloat lOffset = 200.0;
    
    NSUserDefaults *valueOfKeyWidth = [ NSUserDefaults standardUserDefaults];
    CGFloat lPianoWidth = ([valueOfKeyWidth floatForKey:@"ValueOfSlider"] * TOTAL_WHITE_KEYS) ;
    
    self.pianoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0,
                                                                        self.view.bounds.size.height - lOffset+20,
                                                                        self.view.bounds.size.width,
                                                                        lOffset - 20.0)];
    self.pianoScrollView.contentSize = CGSizeMake( lPianoWidth, self.pianoScrollView.bounds.size.height);
    [self.view addSubview:self.pianoScrollView];
    self.pianoScrollView.gestureRecognizers =  nil;
    self.pianoScrollView.delegate = self;

// PianoView
    pianoView = [[PianoView alloc] initWithFrame:CGRectMake(0.0,
                                                                       0.0,
                                                                       lPianoWidth,
                                                                       lOffset)];
    pianoView.multipleTouchEnabled = YES;
    [self.pianoScrollView addSubview:pianoView];
    
    self.keyboardManager = [[KZKeyboardManager alloc] initWithPiano:pianoView];
    
    
    // Own_Slider
    
    ownslider = [[OwnSlider alloc] initWithFrame:CGRectMake(0.0,
                                                            self.view.bounds.size.height - 205.0f,
                                                            self.view.bounds.size.width,
                                                            40.0f)];
    [self.view addSubview:ownslider];
    ownslider.delegate = self;

    
//    settingsView
    self.settingsView = [KZSettingsView settingsView];
    self.settingsView.delegate = self;
    self.settingsView.center = CGPointMake(self.view.bounds.size.width / 2.0f, -50.0f);
    [self.view addSubview:self.settingsView];

}


-(void) OwnSlider:(id)ownslider changedvalue:(CGFloat)value whithscrollersize:(CGFloat)sizeOfScroler {

    CGFloat k = self.pianoScrollView.contentSize.width / (self.view.bounds.size.width);
    [UIView animateWithDuration:0.3 animations:^{
    
    self.pianoScrollView.contentOffset = CGPointMake(k * value, self.pianoScrollView.contentOffset.y);
           }];
}

- (void)KZSettingView:(id)settingsView instrumentChosen:(Instrument)instrument {
    self.keyboardManager.instrument = instrument;
}

- (void)KZSettingView:(id)settingsView recordBtnPressed:(UIButton *)sender {
    _isRecording = !_isRecording;
    UIButton *recBtn = sender;
    recBtn.backgroundColor = _isRecording ? [UIColor redColor] : [UIColor blueColor];
    if (_isRecording) {
        [self.recorder startRecord];
    } else {
        UIAlertView *lAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Do you want to save?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Save", nil];
        lAlertView.tag = SAVE_ALERT_TAG;
        [lAlertView show];
        [self.recorder stopRecord];
    }
}

- (void)KZSettingView:(id)settingsView openBtnPressed:(UIButton *)sender {
    
    KZSongsListViewController *recordVC = [[KZSongsListViewController alloc] initWithNibName:@"KZSongsListViewController" bundle:nil];
    [self presentViewController:recordVC animated:YES completion:nil];
}

- (void)KZSettingView:(id)settingsView backBtnPressed:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)KZSettingView:(id)settingsView openInstrumentsBtnPressed:(UIButton *)sender {
    if (self.settingsView) {
        static BOOL sIsOpen = NO;
        [UIView animateWithDuration:0.3 animations:^{
            
            self.settingsView.center = CGPointMake(self.view.bounds.size.width / 2.0f, sIsOpen ? -50.0f : self.view.bounds.size.height / 2.0f);
        }];
        sIsOpen = !sIsOpen;
        if (!sIsOpen) {
            [ sender setBackgroundImage:[UIImage imageNamed:@"KeyDown.png"] forState:UIControlStateNormal];
        }
        else [ sender setBackgroundImage:[UIImage imageNamed:@"KeyUp.png"] forState:UIControlStateNormal];
    }
}


- (void)KZSettingView:(id)settingsView sliderValueChanged:(CGFloat)value {

    pianoView.whiteKeyWidth = value;
    self.pianoScrollView.contentSize = CGSizeMake(TOTAL_WHITE_KEYS * pianoView.whiteKeyWidth, 20.0);
    pianoView.frame = CGRectMake(0.0f,0.0f,TOTAL_WHITE_KEYS * pianoView.whiteKeyWidth, 200.f);
    ownslider.pianowidth = TOTAL_WHITE_KEYS * pianoView.whiteKeyWidth;
    
    NSUserDefaults *ownSliderValue = [ NSUserDefaults standardUserDefaults];
    
    CGFloat k = self.pianoScrollView.contentSize.width / self.view.bounds.size.width;
    [UIView animateWithDuration:0.3 animations:^{
        
    self.pianoScrollView.contentOffset = CGPointMake(k * [ ownSliderValue floatForKey:@"OwnSliderValue"],
                                                         self.pianoScrollView.contentOffset.y);
    }];
    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == SAVE_ALERT_TAG) {
        if (buttonIndex == 0) {
            
            
            
            
        } else if (buttonIndex == 1) {
            KZTextAlert *lTextAlert = [KZTextAlert textAlert];
            [self.view addSubview:lTextAlert];
            lTextAlert.delegate = self;
            lTextAlert.center = CGPointMake(self.view.bounds.size.width / 2.0, - lTextAlert.bounds.size.height);
            [UIView animateWithDuration:0.3 animations:^{
                lTextAlert.center = CGPointMake(self.view.bounds.size.width /2.0, self.view.bounds.size.height /2.0);
            }];
        }
    }
}

- (void)KZTextAlert:(KZTextAlert *)textAlert gotText:(NSString *)text {
    if ([self.recorder saveSongWithName:text]) {
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        textAlert.center = CGPointMake(self.view.bounds.size.width / 2.0, - textAlert.bounds.size.height);
    } completion:^(BOOL finished) {
        [textAlert removeFromSuperview];
    }];
}

@end