//
//  KZSongsListViewController.m
//  KimZhyk
//
//  Created by Ihor Koblan on 3/26/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZSongsListViewController.h"
#import "KZRecordNavigationViewController.h"

@interface KZSongsListViewController () {
    NSMutableArray *_songs;
}
@end

@implementation KZSongsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _songs = [[NSMutableArray alloc] initWithArray:@[@"song 1",@"song 2",@"song 3",@"song 4",@"song 5"]];
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return _songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *lCellIdentifier = @"song_cell_identifier";
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:lCellIdentifier];

    if (!lCell) {
        lCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lCellIdentifier];
    }
    lCell.textLabel.text = _songs[indexPath.row];
    return lCell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_songs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KZRecordNavigationViewController *lRecNavVC = [[KZRecordNavigationViewController alloc] initWithNibName:@"KZRecordNavigationViewController" bundle:nil];
    [self.navigationController pushViewController:lRecNavVC animated:YES];
}

@end
