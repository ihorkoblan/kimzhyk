//
//  KZSettingsViewController.m
//  KimZhyk
//
//  Created by Admin on 17.08.15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZSettingsViewController.h"

@interface KZSettingsViewController ()


@end

@implementation KZSettingsViewController

@synthesize volumeChangeSlider;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ChangeVolume {
    NSLog(@"%f", volumeChangeSlider.value);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
