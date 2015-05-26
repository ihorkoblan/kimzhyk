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
#import "KZSongsListViewController.h"
#import "KZAboutViewController.h"

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
        case 4:{
            lVC = [[KZSongsListViewController alloc] initWithNibName:@"KZSongsListViewController" bundle:nil];
            break;
        }
        case 5:{
            
            break;
        }
        case 6:{
            lVC = [[KZAboutViewController alloc] initWithNibName:@"KZAboutViewController" bundle:nil];
            [self.navigationController presentViewController:lVC animated:YES completion:nil];
            return;
            break;
        }
        default:
            break;
    }
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.navigationController.view cache:NO];
    [self.navigationController pushViewController:lVC animated:YES];
    [UIView commitAnimations];
}

@end