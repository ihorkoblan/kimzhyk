//
//  KZListViewController.h
//  KimZhyk
//
//  Created by Ihor Koblan on 3/27/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KZListViewControllerDelegate <NSObject>

- (void)KZListViewControllerDelegate:(id)vc doneBtnPressed:(id)sender chosenValue:(id)value;

@end

@interface KZListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *listOfData;
@property (nonatomic, weak) id<KZListViewControllerDelegate> delegate;

- (void)showInView:(UIView *)view;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil listData:(NSArray *)listArray;

@end