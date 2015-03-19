//
//  KZViewController.m
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZViewController.h"
#import "KZPianoKeyboard.h"
#import "KZBajanKeyboard.h"
#import "KZSynthesizer.h"
#import "KZGlobal.h"

#import "RIOInterface.h"
#import "KeyHelper.h"

@interface KZViewController ()

@property(nonatomic, strong) KZPianoKeyboard *pianoKeyboard;

@end


@implementation KZViewController

#pragma mark - properties

@synthesize pianoKeyboard = _pianoKeyboard;

- (KZPianoKeyboard *)pianoKeyboard {
    if (_pianoKeyboard == nil) {
        _pianoKeyboard = [KZPianoKeyboard new];
    }
    return _pianoKeyboard;
}

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
    [self mainInit];
    self.rioRef = [RIOInterface sharedInstance];
    self.rioRef.delegate = self;
    

//    test label
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 70, 180, 40)];
    _infoLabel.text = @"sdf";
    _infoLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_infoLabel];
}

- (void)mainInit {
//    keyboardView
    
    CGFloat lOffset = 200.0;
    _pianoKeyboard = [[KZPianoKeyboard alloc] initWithFrame:CGRectMake(0.0,
                                                                       self.view.bounds.size.height - lOffset,
                                                                       self.view.bounds.size.width,
                                                                       lOffset)];
    _pianoKeyboard.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_pianoKeyboard];
    
//    settingsView
    _settingsView = [KZSettingsView settingsView];
    _settingsView.delegate = self;
    _settingsView.center = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0 - 100.0);
    [self.view addSubview:_settingsView];
}

- (void)startListener {
    [self.rioRef startListening];
}

- (void)stopListener {
    [self.rioRef stopListening];
}

- (void)frequencyChangedWithValue:(CGFloat)newFrequency {
    NSLog(@"freq: %f",newFrequency);
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    [_infoLabel setText:[NSString stringWithFormat:@"freq: %f",newFrequency]];
    [_infoLabel setNeedsDisplay];

    [pool drain];
    pool = nil;
//    [_pianoKeyboard startPlayingSound:nil];
}

- (void)KZSettingView:(id)settingsView startListeningBtnPressed:(UIButton *)sender {
    [self startListener];
}

- (void)KZSettingView:(id)settingsView stopListeningBtnPressed:(UIButton *)sender {
    [self stopListener];
}

@end