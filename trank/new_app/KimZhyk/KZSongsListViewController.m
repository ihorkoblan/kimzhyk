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
#import "DBManager.h"
#import "DBSong.h"
#import "KZPlaySongViewController.h"

@interface KZSongsListViewController () {

}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *songs;
@end

@implementation KZSongsListViewController

- (NSArray *)songs {
    _songs = [DBManager fetchWithEntity:@"DBSong" predicate:nil sortDescriptors:nil];
    return _songs ? _songs : [NSArray array];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.songs = [DBManager fetchWithEntity:@"DBSong" predicate:nil sortDescriptors:nil];
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
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *lCellIdentifier = @"song_cell_identifier";
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:lCellIdentifier];
    
    if (!lCell) {
        lCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lCellIdentifier];
    }
    lCell.textLabel.text = ((DBSong *)self.songs[indexPath.row]).name;
    return lCell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        [DBManager deleteObject:self.songs[indexPath.row]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {

    }
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DBSong *song = self.songs[indexPath.row];
    KZPlaySongViewController *lPlaySongVC = [[KZPlaySongViewController alloc] initWithSong:song];
    [self.navigationController pushViewController:lPlaySongVC animated:YES];
}

- (IBAction)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)homeBtnPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
