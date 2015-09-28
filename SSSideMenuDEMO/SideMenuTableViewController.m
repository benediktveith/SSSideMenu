//
//  SideMenuTableViewController.m
//  SSSideMenu
//
//  Created by Benedikt Veith on 25/09/15.
//  Copyright © 2015 Benedikt Veith. All rights reserved.
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
    return @"ABC";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = @"AAAAAAA";
    
    return cell;
}

@end
