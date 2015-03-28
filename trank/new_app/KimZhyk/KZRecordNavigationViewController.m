//
//  KZRecordNavigationViewController.m
//  KimZhyk
//
//  Created by Пользователь on 28.03.15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZRecordNavigationViewController.h"

@interface KZRecordNavigationViewController ()

@end

@implementation KZRecordNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeBtnPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)backBtnPressed:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)playMelodyBtnPressed:(id)sender {
    
}

- (IBAction)editMelodyBtnPressed:(id)sender {
    
}

@end
