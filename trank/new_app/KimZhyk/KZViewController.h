//
//  KZViewController.h
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZSettingsView.h"

@interface KZViewController : UIViewController<KZSettingsViewDelegate> {
    NSMutableArray *_keysArray;
    KZSettingsView *_settingsView;
    UILabel *_infoLabel;
}

@end