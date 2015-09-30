//
//  ViewController.m
//  SSSideMenu
//
//  Created by Scherer Software on 25/09/15.
//  Copyright © 2015 Scherer Software. All rights reserved.
//

#import "ViewController.h"
#import "SideMenuTableViewController.h"
#import "SSSideMenu.h"

@interface ViewController ()

// Both NEEDED to use the side menu
@property UITableViewController *sideMenu;
@property SSSideMenu *sideMenus;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Connect _sideMenu with the TableViewController from Storyboard with the Storyboard ID; NEEDED
    _sideMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"SideMenuTableViewController"];
    
    if (! _sideMenus) {
        // Init _sideMenus with Size; NEEDED
        _sideMenus = [[SSSideMenu alloc] setupSSSideMenuWithSize:CGSizeMake(150, self.view.frame.size.height)];
        
        /**
         Call if you want to have swipe gesture recognizer; OPTIONAL
         
         possible sides: Both / Left / Right
         */
        [_sideMenus initSSSideMenuWithSwipeOnSide:@"Both" onView:self forMenu:_sideMenu];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openSideMenuPressed:(UIButton *)sender {
    // Side menu LEFT
    [_sideMenus openSideMenuViaButtonFor:self andSideMenu:_sideMenu fromSide:@"Left"];
}

- (IBAction)openSideMenuRight:(UIButton *)sender {
    // Side menu RIGHT
    [_sideMenus openSideMenuViaButtonFor:self andSideMenu:_sideMenu fromSide:@"Right"];
}

- (IBAction)closeSideMenuPressed:(UIButton *)sender {
    // Remove side Menu
    [_sideMenus resetViewsFor:self and:_sideMenu];
}

@end
