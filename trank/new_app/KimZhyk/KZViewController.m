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
#import "KZSoundStruct.h"
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
}

- (void)mainInit {
    _pianoKeyboard = [[KZPianoKeyboard alloc] initWithFrame:CGRectMake(
                                                                       0.0,
                                                                       80.0,
                                                                       self.view.frame.size.height,
                                                                       self.view.frame.size.width)];
    _pianoKeyboard.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_pianoKeyboard];
    

    
    
}

@end