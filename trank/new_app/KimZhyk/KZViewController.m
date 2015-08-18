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

#define SCROLLER_TAG 1
#define SAVE_ALERT_TAG 3

@interface KZViewController () <PianoViewDelegate, UIScrollViewDelegate, UIAlertViewDelegate, KZTextAlertDelegate>{
    KZNoteRecorder *_noteRecorder;
    PianoView *pianoView;
    UIScrollView *scroller;
}

@property (nonatomic, strong) UIScrollView *pianoScrollView;
@property(nonatomic, strong) KZSettingsView *settingsView;
@property (nonatomic, strong) KZKeyboardManager *keyboardManager;
@property (nonatomic, strong) KZSongRecorder *recorder;

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
    CGFloat pianoWidth = 1800.0f;
    scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0,
                                                                            self.view.bounds.size.height - lOffset,
                                                                            self.view.bounds.size.width,
                                                                            20.0)];
    scroller.backgroundColor = [UIColor yellowColor];
    scroller.delegate = self;
    scroller.contentSize = CGSizeMake(pianoWidth, 20.0);
    scroller.tag = SCROLLER_TAG;
    [self.view addSubview:scroller];
    
    self.pianoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0,
                                                                        self.view.bounds.size.height - lOffset+20,
                                                                        self.view.bounds.size.width,
                                                                        lOffset - 20.0)];
    self.pianoScrollView.contentSize = CGSizeMake(pianoWidth, self.pianoScrollView.bounds.size.height);
    [self.view addSubview:self.pianoScrollView];
    self.pianoScrollView.gestureRecognizers =  nil;
    self.pianoScrollView.delegate = self;
    
    pianoView = [[PianoView alloc] initWithFrame:CGRectMake(0.0,
                                                                       0.0,
                                                                       self.pianoScrollView.contentSize.width,
                                                                       lOffset)];
    pianoView.multipleTouchEnabled = YES;
    [self.pianoScrollView addSubview:pianoView];
    
    self.keyboardManager = [[KZKeyboardManager alloc] initWithPiano:pianoView];
    
//    settingsView
    self.settingsView = [KZSettingsView settingsView];
    self.settingsView.delegate = self;
    self.settingsView.center = CGPointMake(self.view.bounds.size.width / 2.0f, -40.0f);
    [self.view addSubview:self.settingsView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == SCROLLER_TAG) {
        self.pianoScrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, self.pianoScrollView.contentOffset.y);
    }
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
            
            self.settingsView.center = CGPointMake(self.view.bounds.size.width / 2.0f, sIsOpen ? -40.0f : self.view.bounds.size.height / 2.0f);
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
    scroller.contentSize = CGSizeMake(TOTAL_WHITE_KEYS * pianoView.whiteKeyWidth, 20.0);
    
    
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