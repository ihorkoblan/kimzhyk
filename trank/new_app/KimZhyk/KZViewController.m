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
    __strong _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 70, 250, 40)];
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

    dispatch_async(dispatch_get_main_queue(), ^{
        
        float maxMag = newFrequency;
        int counter = 0;
        while (maxMag > 55.000f) {
            counter++;
            maxMag/=2.0f;
        }
        
        NSString *note = nil;
        if ((maxMag >= 27.500f) && (maxMag < 29.135f)) {
            note = @"A";
        } else if ((maxMag >= 29.135f) && (maxMag < 30.868f)) {
            note = @"A#";
        } else if ((maxMag >= 30.868f) && (maxMag < 32.703f)) {
            note = @"H";
        } else if ((maxMag >= 32.703f) && (maxMag < 34.648f)) {
            note = @"C";
        } else if ((maxMag >= 34.648f) && (maxMag < 36.708f)) {
            note = @"C#";
        } else if ((maxMag >= 36.708f) && (maxMag < 38.891f)) {
            note = @"D";
        } else if ((maxMag >= 38.891f) && (maxMag < 41.203f)) {
            note = @"D#";
        } else if ((maxMag >= 41.203f) && (maxMag < 43.654f)) {
            note = @"E";
        } else if ((maxMag >= 43.654f) && (maxMag < 46.249f)) {
            note = @"F";
        } else if ((maxMag >= 46.249f) && (maxMag < 48.999f)) {
            note = @"F#";
        } else if ((maxMag >= 48.999f) && (maxMag < 51.913f)) {
            note = @"G";
        } else if ((maxMag >= 51.913f) && (maxMag < 55.000f)) {
            note = @"G#";
        }
        
        [_infoLabel setText:[NSString stringWithFormat:@"freq: %f note: %@%i",newFrequency, note,counter]];
        [_infoLabel setNeedsDisplay];
    });
    


}

- (void)KZSettingView:(id)settingsView startListeningBtnPressed:(UIButton *)sender {
    [self startListener];
}

- (void)KZSettingView:(id)settingsView stopListeningBtnPressed:(UIButton *)sender {
    [self stopListener];
}

@end