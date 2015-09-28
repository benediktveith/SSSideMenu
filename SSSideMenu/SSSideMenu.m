//
//  SSSideMenu.m
//  SSSideMenu
//
//  Created by Benedikt Veith on 28/09/15.
//  Copyright © 2015 Benedikt Veith. All rights reserved.
//

#import "SSSideMenu.h"

@interface SSSideMenu ()

@property UITableViewController *sideMenu;
@property UIViewController *mainView;
@property CGSize sideMenuSize;

@end

@implementation SSSideMenu

#pragma mark - Setups

- (void)initSSSideMenuWithSwipeOnSide:(NSString *)side
                               onView:(UIViewController *)mainView
                              forMenu:(UITableViewController*)sideMenu {

    // Needed for Swipe Gesture Recognizer
    _sideMenu = sideMenu;
    _mainView = mainView;
    
    // Set Recognizer
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Add the right Recognizer
    if ([side isEqualToString:@"Both"]) {
        [mainView.view addGestureRecognizer:swipeLeft];
        [mainView.view addGestureRecognizer:swipeRight];
    } else if ([side isEqualToString:@"Left"]) {
        [mainView.view addGestureRecognizer:swipeLeft];
    } else if ([side isEqualToString:@"Right"]) {
        [mainView.view addGestureRecognizer:swipeRight];
    }
}

- (id)setupSSSideMenuWithSize:(CGSize)size {
    _sideMenuSize = size;
    
    return self;
}

/**
 *  Setup side menu to MainView; Makes it visible / interactive
 *
 *  @param sideMenu Side Menu
 *  @param mainView Main ViewController
 */
- (void)setupSideMenu:(UITableViewController*)sideMenu with:(UIViewController*)mainView {
    [mainView.view addSubview:sideMenu.view];
    [mainView addChildViewController:sideMenu];
    [sideMenu didMoveToParentViewController:mainView];
}

#pragma mark - SwipeGesture Handling

/**
 *  Choose the correct Action for the current State(Left / Right)
 *
 *  @param swipe
 */
- (void)handleSwipe:(UISwipeGestureRecognizer*)swipe {
    if ([_showingSideMenu isEqualToString:@"no"] || ! _showingSideMenu) {
        if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
            [self moveViewFromRightToLeftFor:_mainView and:_sideMenu];
        } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
            [self moveViewFromLeftToRightFor:_mainView and:_sideMenu];
        }
    } else if ([_showingSideMenu isEqualToString:@"right"]) {
         if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
            [self resetViewsFor:_mainView and:_sideMenu];
        }
    } else if ([_showingSideMenu isEqualToString:@"left"]) {
        if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
            [self resetViewsFor:_mainView and:_sideMenu];
        }
    }
}

#pragma mark - View movement

- (void)moveViewFromRightToLeftFor:(UIViewController*)mainView and:(UITableViewController*)sideMenu {
    // Return if already open and close it
    if ([_showingSideMenu isEqualToString:@"right"]) {
        [self resetViewsFor:mainView and:sideMenu];
        return;
    }
    
    [self setupSideMenu:sideMenu with:mainView];
    
    // Set sideMenu frame
    sideMenu.view.frame = CGRectMake(mainView.view.frame.size.width, 20, _sideMenuSize.width, _sideMenuSize.height);
    [mainView.view bringSubviewToFront:sideMenu.view];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        // Set mainView bounds; Creates the movement of mainView Content and enable sideMenu interaction
        mainView.view.bounds = CGRectMake(_sideMenuSize.width, 0, mainView.view.frame.size.width, mainView.view.frame.size.height);
    } completion:^(BOOL finished) {
        
        if (finished) {
           _showingSideMenu = @"right";
        }
    }];
}

- (void)moveViewFromLeftToRightFor:(UIViewController*)mainView and:(UITableViewController*)sideMenu {
    // Return if already open and close it
    if ([_showingSideMenu isEqualToString:@"left"]) {
        [self resetViewsFor:mainView and:sideMenu];
        return;
    }
    
    [self setupSideMenu:sideMenu with:mainView];
    
    // Set sideMenu frame
    sideMenu.view.frame = CGRectMake(-_sideMenuSize.width, 20, _sideMenuSize.width, _sideMenuSize.height);
    [mainView.view bringSubviewToFront:sideMenu.view];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        // Set mainView bounds; Creates the movement of mainView Content and enable sideMenu interaction
        mainView.view.bounds = CGRectMake(-_sideMenuSize.width, 0, mainView.view.frame.size.width, mainView.view.frame.size.height);
    } completion:^(BOOL finished) {
        
        if (finished) {
            _showingSideMenu = @"left";
        }
    }];
}

- (void)resetViewsFor:(UIViewController*)mainView and:(UITableViewController*)sideMenu {
    
    [UIView animateWithDuration:0.55 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        //Reposition mainView frame and its bounds
        mainView.view.frame = CGRectMake(0, 0, mainView.view.frame.size.width, mainView.view.frame.size.height);
        mainView.view.bounds = CGRectMake(0, 0, mainView.view.frame.size.width, mainView.view.frame.size.height);
        
        // Reposition sideMenu frame
        if ([_showingSideMenu isEqualToString:@"left"]) {
            sideMenu.view.frame = CGRectMake(-_sideMenuSize.width, 20, _sideMenuSize.width, _sideMenuSize.height);
        } else if ([_showingSideMenu isEqualToString:@"right"]) {
            sideMenu.view.frame = CGRectMake(mainView.view.frame.size.width, 20, _sideMenuSize.width, _sideMenuSize.height);
        }
    } completion:^(BOOL finished) {
        
        if (finished) {
            _showingSideMenu = @"no";
            [sideMenu.view removeFromSuperview];
        }
    }];
}

#pragma mark - Setter methods

- (void)setTheMainView:(UIViewController *)mainView {
    _mainView = mainView;
}

- (void)setTheSize:(CGSize)size {
    _sideMenuSize = size;
}

- (void)setTheSideMenu:(UITableViewController *)sideMenu {
    _sideMenu = sideMenu;
}

@end
