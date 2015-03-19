//
//  KZViewController.h
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZPianoKeyboard.h"
#import "KZPianoKey.h"
#import "RIOInterface.h"
#import "KeyHelper.h"
#import "KZSettingsView.h"

@interface KZViewController : UIViewController<KZSettingsViewDelegate, RIOInterfaceDelegate> {
    NSMutableArray *_keysArray;
    KZSettingsView *_settingsView;
    UILabel *_infoLabel;
}

@property(nonatomic, assign) RIOInterface *rioRef;

@end