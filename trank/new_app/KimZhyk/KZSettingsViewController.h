//
//  KZSettingsViewController.h
//  KimZhyk
//
//  Created by Admin on 17.08.15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KZSettingsViewController : UIViewController{
    UISlider *volumeChangeSlider;
}

@property ( nonatomic,retain ) IBOutlet UISlider *volumeChangeSlider;

- (IBAction) ChangeVolume;

@end
