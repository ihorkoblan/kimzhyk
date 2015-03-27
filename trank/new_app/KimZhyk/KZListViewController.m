//
//  KZListViewController.m
//  KimZhyk
//
//  Created by Ihor Koblan on 3/27/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZListViewController.h"

@interface KZListViewController ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation KZListViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil listData:(NSArray *)listArray {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _listOfData = listArray;
        self.view.hidden = YES;
        self.view.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2.0f, - [[UIScreen mainScreen] bounds].size.height / 2.0f);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *lCellIdentifier = @"data_list_cell_identifier";
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:lCellIdentifier];
    
    if (!lCell) {
        lCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lCellIdentifier];
    }
    lCell.textLabel.text = self.listOfData[indexPath.row];
    return lCell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneBtnPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(KZListViewControllerDelegate:doneBtnPressed:chosenValue:)]) {
        [self.delegate KZListViewControllerDelegate:self doneBtnPressed:sender chosenValue:nil];
    }
}

- (IBAction)cancelBtnPressed:(id)sender {
    __weak KZListViewController *lSelf_ = self;
    [UIView animateWithDuration:0.2 animations:^{
        lSelf_.view.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2.0f, -[[UIScreen mainScreen] bounds].size.height / 2.0f);
    } completion:^(BOOL finished) {
        [lSelf_.view removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view {
    __weak KZListViewController *lSelf_ = self;
    self.view.hidden = NO;
    [view addSubview:self.view];
    
    [UIView animateWithDuration:1.0f delay:0.0 usingSpringWithDamping:0.35 initialSpringVelocity:6.0 options:0 animations:^{
        lSelf_.view.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2.0f, [[UIScreen mainScreen] bounds].size.height / 2.0f);
    } completion:nil];
}

@end
