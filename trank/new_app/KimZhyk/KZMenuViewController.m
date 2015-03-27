//
//  KZMenuViewController.m
//  KimZhyk
//
//  Created by Ihor Koblan on 3/27/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZMenuViewController.h"
#import "KZViewController.h"
#import "KZRecordViewController.h"

@interface KZMenuViewController ()

@end

@implementation KZMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPressed:(id)sender {
    
    UIViewController *lVC = nil;
    switch (((UIButton *)sender).tag) {
        case 1:{
            lVC = [[KZViewController alloc] initWithNibName:@"KZViewController" bundle:nil];
            break;
        }
        case 2:{
            lVC = [[KZRecordViewController alloc] initWithNibName:@"KZRecordViewController" bundle:nil];
            
            break;
        }
        case 3:{
            
            break;
        }
        default:
            break;
    }
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationTransition:
     UIViewAnimationTransitionNone
                           forView:self.navigationController.view cache:NO];
    [self.navigationController pushViewController:lVC animated:YES];
    [UIView commitAnimations];
}

@end
