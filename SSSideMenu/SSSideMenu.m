//
//  SSSideMenu.m
//  SSSideMenu
//
//  Created by Scherer Software on 28/09/15.
//  Copyright © 2015 Scherer Software. All rights reserved.
//

#import "SSSideMenu.h"

NSString * const LEFT_SIDE = @"Left";
NSString * const RIGHT_SIDE = @"Right";
NSString * const BOTH_SIDES = @"Both";
NSString * const NO_SIDE = @"No";

@interface SSSideMenu ()

@property UITableViewController *sideMenu;
@property CGSize sideMenuSize;
@property UIViewController *mainView;
@property NSString *side;

@end

@implementation SSSideMenu

#pragma mark - Setups

- (void)initSSSideMenuWithSwipeOnSide:(NSString *)side
                               onView:(UIViewController *)mainView
                              forMenu:(UITableViewController*)sideMenu {

    // Needed for Pan Gesture Recognizer
    _sideMenu = sideMenu;
    _mainView = mainView;
    _side = side;
    
    // Set Pan Gesture Recognizer
    UIPanGestureRecognizer *moveSide = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveSide:)];
    [mainView.view addGestureRecognizer:moveSide];
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

#pragma mark - Pan Gesture Recognizer - Handling

/**
 *  Open / Close sideMenu via Pan Gesture
 *
 *  @param recognizer Pan Gesture Recognizer
 */
- (void)moveSide:(UIPanGestureRecognizer*)recognizer {
    // Define position of pan gesture and its translation from starting point
    CGPoint position = [recognizer locationInView:_mainView.view];
    CGPoint translation = [recognizer translationInView:_sideMenu.view];
    
    // Checks if _side is Right / Both
    if ([_side isEqualToString:RIGHT_SIDE] || [_side isEqualToString:BOTH_SIDES]) {
        // Check if sideMenu is not showing and if pan position is in BoundingBox to open it
        if (([_showingSideMenu isEqualToString:NO_SIDE] || ! _showingSideMenu)
            && CGRectContainsPoint(CGRectMake(_mainView.view.frame.size.width + _sideMenuSize.width, 20,
                                              translation.x - (40 +  _sideMenuSize.width), _sideMenuSize.height), position)) {
            // Move sideMenu
            [self moveSideMenuWithRecognizerTranslation:translation fromRecognizer:recognizer inDirection:RIGHT_SIDE];
            return;
        }
        // Check if sideMenu is open on RightSide
        if ([_showingSideMenu isEqualToString:RIGHT_SIDE]) {
            // If position is in BoundingBox of sideMenu
            if (CGRectContainsPoint(_sideMenu.view.frame, position)) {
                // Move sideMenu
                [self moveSideMenuWithRecognizerTranslation:translation fromRecognizer:recognizer inDirection:RIGHT_SIDE];
                return;
            }
            // Resets translation to Zero
            [recognizer setTranslation:CGPointZero inView:_mainView.view];
            // Else open / close sideMenu depending on current position
            [self openSideMenuCorrectly:RIGHT_SIDE withRecognizer:recognizer];
            return;
        }
    }
    // Checks if _side Left / Both
    if ([_side isEqualToString:LEFT_SIDE] || [_side isEqualToString:BOTH_SIDES]) {
        // Check if sideMenu is not showing and if pan position is in BoundingBox to open it
        if (([_showingSideMenu isEqualToString:NO_SIDE] || ! _showingSideMenu)
            && CGRectContainsPoint(CGRectMake(0 - _sideMenuSize.width, 20,
                                              _sideMenuSize.width + 40 + translation.x, _sideMenuSize.height), position)) {
            // Move sideMenu
            [self moveSideMenuWithRecognizerTranslation:translation fromRecognizer:recognizer inDirection:LEFT_SIDE];
            return;
        }
        // Check if sideMenu is open on LeftSide
        if ([_showingSideMenu isEqualToString:LEFT_SIDE]) {

            // If position is in BoundingBox of sideMenu
            if (CGRectContainsPoint(_sideMenu.view.frame, position)) {
                // Move sideMenu
                [self moveSideMenuWithRecognizerTranslation:translation fromRecognizer:recognizer inDirection:LEFT_SIDE];
                return;
            }
            // Resets translation to Zero
            [recognizer setTranslation:CGPointZero inView:_mainView.view];
            // Else open / close sideMenu depending on current position
            [self openSideMenuCorrectly:LEFT_SIDE withRecognizer:recognizer];
            return;
        }
    }
}

#pragma mark - View movement - Pan Gesture Recognizer - Open

/**
 *  Open sideMenu for given side
 *
 *  @param direction = Side of screen
 */
- (void)openMenuWithDirection:(NSString*)direction {
    _showingSideMenu = direction;
    // Open sideMenu animated depending on direction
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        NSInteger prefix = 1;
        if ([direction isEqualToString:LEFT_SIDE]) {
            prefix = -1;
        }
        _mainView.view.bounds = CGRectMake(_sideMenuSize.width * prefix, 0, _mainView.view.frame.size.width, _mainView.view.frame.size.height);
    } completion:nil];
}

/**
 *  Called if Pan Gesture is lost during open / close procedure
 *
 *  @param direction  = Side of screen
 *  @param recognizer = Pan Gesture Recognizer
 */
- (void)openSideMenuCorrectly:(NSString*)direction withRecognizer:(UIPanGestureRecognizer*)recognizer {
    // Checks if direction is Left or Right
    if ([direction isEqualToString:LEFT_SIDE]) {
        // If sideMenu is less than half open --> Close it
        if (_mainView.view.bounds.origin.x > -_sideMenuSize.width / 2) {
            [self resetViewsFor:_mainView and:_sideMenu];
        }
        // If sideMenu is more than half open --> Open it
        if (_mainView.view.bounds.origin.x <= -_sideMenuSize.width / 2) {
            [self openMenuWithDirection:direction];
        }
    } else if ([direction isEqualToString:RIGHT_SIDE]) {
        // If sideMenu is less than half open --> Close it
        if (_mainView.view.bounds.origin.x < _sideMenuSize.width / 2) {
            [self resetViewsFor:_mainView and:_sideMenu];
        }
        // If sideMenu is more than half open --> Open it
        if (_mainView.view.bounds.origin.x >= _sideMenuSize.width / 2) {
            [self openMenuWithDirection:direction];
        }
    }
}

#pragma mark - View movement - Pan Gesture Recognizer - Move

/**
 *  Move sideMenu depending on current Translation, Pan Gesture Recognizer and side of screen
 *
 *  @param recognizerTranslation Current translation from pan gesture starting point
 *  @param recognizer            Pan Gesture Recognizer
 *  @param direction             Side of screen
 */
- (void)moveSideMenuWithRecognizerTranslation:(CGPoint)recognizerTranslation fromRecognizer:(UIPanGestureRecognizer*)recognizer
                                  inDirection:(NSString*)direction {
    
    // Checks if pan gesture ended. Open / Close sideMenu depending on current position
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self openSideMenuCorrectly:direction withRecognizer:recognizer];
        return;
    }
    
    // Checks if sideMenu is not opened
    if ([_showingSideMenu isEqualToString:NO_SIDE] || ! _showingSideMenu) {
        // Return if try to open sideMenu in opposite direction
        if ((recognizerTranslation.x <= 0 && [direction isEqualToString:LEFT_SIDE]) ||
            (recognizerTranslation.x >= 0 && [direction isEqualToString:RIGHT_SIDE])) {
            return;
        }
        
        // Return if sideMenu is fully opened
        if ((recognizerTranslation.x >= _sideMenuSize.width && [direction isEqualToString:LEFT_SIDE]) ||
            (-recognizerTranslation.x >= _sideMenuSize.width && [direction isEqualToString:RIGHT_SIDE])) {
            [self openMenuWithDirection:direction];
            return;
        }
        
        [self setupSideMenu:_sideMenu with:_mainView];
        [_mainView.view bringSubviewToFront:_sideMenu.view];
    }
    
    // Check if sideMenu is opened
    if ([_showingSideMenu isEqualToString:LEFT_SIDE] || [_showingSideMenu isEqualToString:RIGHT_SIDE]) {
        
        // Return if try to close sideMenu in opposite direction
        if (((-_sideMenuSize.width) - recognizerTranslation.x <= -_sideMenuSize.width && [direction isEqualToString:LEFT_SIDE])
            || (_sideMenuSize.width - recognizerTranslation.x >= _sideMenuSize.width && [direction isEqualToString:RIGHT_SIDE])) {
            return;
        }
        
        // Return if sideMenu is fully closed
        if (recognizerTranslation.x >= _sideMenuSize.width || recognizerTranslation.x <= -_sideMenuSize.width) {
            [self resetViewsFor:_mainView and:_sideMenu];
            return;
        }
    }
    
    // Set sideMenu frame depending on direction
    _sideMenu.view.frame = CGRectMake(-_sideMenuSize.width, 20, _sideMenuSize.width, _sideMenuSize.height);
    if ([direction isEqualToString:RIGHT_SIDE]) {
        _sideMenu.view.frame = CGRectMake(_mainView.view.frame.size.width, 20, _sideMenuSize.width, _sideMenuSize.height);
    }
    
    // Move sideMenu animated depending if it is closed / opened
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        NSInteger numbPrefix = 1;
        if ([_showingSideMenu isEqualToString:NO_SIDE] || ! _showingSideMenu) {
            numbPrefix = 0;
        }
        if ([_showingSideMenu isEqualToString:LEFT_SIDE]) {
            numbPrefix = -1;
        }
        
        _mainView.view.bounds = CGRectMake((numbPrefix * _sideMenuSize.width) - recognizerTranslation.x, 0, _mainView.view.frame.size.width, _mainView.view.frame.size.height);
        
    } completion:nil];
}

#pragma mark - View movement - Buttons - Action

- (void)openSideMenuViaButtonFor:(UIViewController*)mainView andSideMenu:(UITableViewController*)sideMenu fromSide:(NSString*)side {
    // If already open, close it
    if ([_showingSideMenu isEqualToString:RIGHT_SIDE] || [_showingSideMenu isEqualToString:LEFT_SIDE]) {
        [self resetViewsFor:mainView and:sideMenu];
        return;
    }
    // Setup sideMenu
    [self setupSideMenu:sideMenu with:mainView];
    [mainView.view bringSubviewToFront:sideMenu.view];
    
    // Set sideMenu frame depending on side
    if ([side isEqualToString:LEFT_SIDE]) {
        sideMenu.view.frame = CGRectMake(-_sideMenuSize.width, 20, _sideMenuSize.width, _sideMenuSize.height);
    }
    if ([side isEqualToString:RIGHT_SIDE]) {
        sideMenu.view.frame = CGRectMake(mainView.view.frame.size.width, 20, _sideMenuSize.width, _sideMenuSize.height);
    }
    
    [self openMenuWithDirection:side];
}

#pragma mark - View movement - Reset

- (void)resetViewsFor:(UIViewController*)mainView and:(UITableViewController*)sideMenu {
    // Close sideMenu animated
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        //Reposition mainView frame and its bounds
        mainView.view.frame = CGRectMake(0, 0, mainView.view.frame.size.width, mainView.view.frame.size.height);
        mainView.view.bounds = mainView.view.frame;
        
    } completion:^(BOOL finished) {
        if (finished) {
            _showingSideMenu = NO_SIDE;
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
