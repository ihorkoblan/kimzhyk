//
//  KZViewController.m
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZViewController.h"
#import "KZGlobal.h"

#import "KZStaveView.h"
#import "KZRecordViewController.h"
#import "KZSongsListViewController.h"
#import "KZKeyboardManager.h"
#import "PianoView.h"

#define SCROLLER_TAG 1

@interface KZViewController () <PianoViewDelegate, UIScrollViewDelegate>{

}

@property (nonatomic, strong) UIScrollView *pianoScrollView;
@property(nonatomic, strong) KZSettingsView *settingsView;
@property (nonatomic, strong) KZKeyboardManager *keyboardManager;
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
    DLog(@"key down: %i",key);
}

- (void)pianoView:(PianoView *)piano keyUp:(short)key {
    DLog(@"key up: %i",key);
}

- (void)mainInit {
    CGFloat lOffset = 200.0;
    
    CGFloat pianoWidth = 1800.0f;
    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0,
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
    PianoView *pianoView = [[PianoView alloc] initWithFrame:CGRectMake(0.0,
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
    KZRecordViewController *recordVC = [[KZRecordViewController alloc] initWithNibName:@"KZRecordViewController" bundle:nil];
    [self presentViewController:recordVC animated:YES completion:nil];
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
    }
}

@end