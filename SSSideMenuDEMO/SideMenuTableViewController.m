//
//  SideMenuTableViewController.m
//  SSSideMenu
//
//  Created by Scherer Software on 25/09/15.
//  Copyright © 2015 Scherer Software. All rights reserved.
//

#import "SideMenuTableViewController.h"

@interface SideMenuTableViewController ()

@end

@implementation SideMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Design your SideMenu etc... 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [NSString stringWithFormat:@"Section Header: %ld", (long)section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, tableView.sectionHeaderHeight);
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(10, 0, self.view.frame.size.width - 10, tableView.sectionHeaderHeight);
    headerLabel.font = [UIFont boldSystemFontOfSize:14];
    headerLabel.text = [self tableView:tableView titleForHeaderInSection:section];

    
    [headerView addSubview:headerLabel];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.frame = CGRectMake(0, 0, self.view.frame.size.width, cell.frame.size.height);
    cell.textLabel.font = [UIFont boldSystemFontOfSize:10];
    
    
    NSString *itemNumber = [NSString stringWithFormat:@"Item : %ld", (long)indexPath.row];
    cell.textLabel.text = [itemNumber stringByAppendingString: [NSString stringWithFormat:@"  with Size: %f", cell.frame.size.width]];
    
    return cell;
}

@end
