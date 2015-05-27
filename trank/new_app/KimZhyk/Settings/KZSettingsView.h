//
//  KZSettins.h
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZInstrumentsHelper.h"
#import "KZInstrumentSelectionView.h"

@protocol KZSettingsViewDelegate;

@interface KZSettingsView : UIView<KZInstrumentSelectionViewDelegate> {
    IBOutlet UIScrollView *_instrumentsScrollView;
}

@property (nonatomic, unsafe_unretained) IBOutlet UILabel *infoLabel;
@property (nonatomic, unsafe_unretained) id<KZSettingsViewDelegate> delegate;

+ (KZSettingsView *)settingsView;

@end

@protocol KZSettingsViewDelegate <NSObject>

- (void)KZSettingView:(id)settingsView startListeningBtnPressed:(UIButton *)sender;
- (void)KZSettingView:(id)settingsView stopListeningBtnPressed:(UIButton *)sender;
- (void)KZSettingView:(id)settingsView recordBtnPressed:(UIButton *)sender;
- (void)KZSettingView:(id)settingsView openBtnPressed:(UIButton *)sender;
- (void)KZSettingView:(id)settingsView backBtnPressed:(UIButton *)sender;
- (void)KZSettingView:(id)settingsView openInstrumentsBtnPressed:(UIButton *)sender;
- (void)KZSettingView:(id)settingsView instrumentChosen:(Instrument)instrument;

@end