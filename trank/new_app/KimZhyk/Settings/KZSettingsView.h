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

@interface KZSettingsView : UIView<KZInstrumentSelectionViewDelegate> 

@property (nonatomic, retain) IBOutlet UISlider *keyWidthSlider;
@property (nonatomic, unsafe_unretained) IBOutlet UILabel *infoLabel;
@property (nonatomic, unsafe_unretained) id<KZSettingsViewDelegate> delegate;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSString *instrument;

+ (KZSettingsView *)settingsView;
- (IBAction)ChangeKeyWidth;
@end

@protocol KZSettingsViewDelegate <NSObject>


- (void)KZSettingView:(id)settingsView recordBtnPressed:(UIButton *)sender;
- (void)KZSettingView:(id)settingsView openBtnPressed:(UIButton *)sender;
- (void)KZSettingView:(id)settingsView backBtnPressed:(UIButton *)sender;
- (void)KZSettingView:(id)settingsView openInstrumentsBtnPressed:(UIButton *)sender;
- (void)KZSettingView:(id)settingsView instrumentChosen:(Instrument)instrument;
- (void)KZSettingView:(id)settingsView sliderValueChanged:(CGFloat) value;

@end