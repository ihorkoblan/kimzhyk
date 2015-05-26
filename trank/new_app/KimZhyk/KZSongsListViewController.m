//
//  KZSongsListViewController.m
//  KimZhyk
//
//  Created by Пользователь on 28.03.15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZSongsListViewController.h"
#import "KZRecordNavigationViewController.h"
#import "KZFileManager.h"



@interface KZSongsListViewController () {

}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation KZSongsListViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

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
    return 45.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [KZFileManager itemsAtDefaultFolder].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *lCellIdentifier = @"song_cell_identifier";
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:lCellIdentifier];
    
    if (!lCell) {
        lCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lCellIdentifier];
    }
    lCell.textLabel.text = [KZFileManager itemsAtDefaultFolder][indexPath.row];
    return lCell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        [KZFileManager removeFileAtPath:[NSString stringWithFormat:@"%@/%@",[KZFileManager defaultFolderPath],[KZFileManager itemsAtDefaultFolder][indexPath.row]]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {

    }
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KZRecordNavigationViewController *lRecNavVC = [[KZRecordNavigationViewController alloc] initWithNibName:@"KZRecordNavigationViewController" bundle:nil];
    NSURL *lURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[KZFileManager defaultFolderPath],(NSString *)[KZFileManager itemsAtDefaultFolder][indexPath.row]]];
    lRecNavVC.songUrl = lURL;
    [self.navigationController pushViewController:lRecNavVC animated:YES];
}

- (IBAction)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)homeBtnPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
