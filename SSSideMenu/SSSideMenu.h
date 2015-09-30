//
//  SSSideMenu.h
//  SSSideMenu
//
//  Created by Scherer Software on 28/09/15.
//  Copyright © 2015 Scherer Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSSideMenu : NSObject

@property NSString* showingSideMenu;

/**
 *  Init SSSideMenu and set size of side menu
 *
 *  @param size Size of side menu
 *
 *  @return self
 */
- (id)setupSSSideMenuWithSize:(CGSize)size;

/**
 *  Use for activate Swipe Gesture Recognizer
 *
 *  @param side     For side: 'Both' / 'Left' / 'Right'
 *  @param mainView For main ViewController
 *  @param sideMenu For sideMenu TableViewController
 */
- (void)initSSSideMenuWithSwipeOnSide:(NSString *)side
                               onView:(UIViewController *)mainView
                              forMenu:(UITableViewController*)sideMenu;

/**
 *  Reset views to default / closes side menus
 *
 *  @param mainView Main ViewController
 *  @param sideMenu Side menu that will be closed
 */
- (void)resetViewsFor:(UIViewController*)mainView and:(UITableViewController*)sideMenu;

/**
 *  Set MainView
 *
 *  @param mainView Main ViewController
 */
- (void)setTheMainView:(UIViewController*)mainView;

/**
 *  Set Side Menu
 *
 *  @param sideMenu Side Menu
 */
- (void)setTheSideMenu:(UITableViewController*)sideMenu;

/**
 *  Set the size of side menu
 *
 *  @param size
 */
- (void)setTheSize:(CGSize)size;

/**
 *  Opens side menu via button action
 *
 *  @param mainView For main ViewController
 *  @param sideMenu For sideMenu TableViewController
 *  @param side     For side: Left / Right
 */
- (void)openSideMenuViaButtonFor:(UIViewController*)mainView andSideMenu:(UITableViewController*)sideMenu fromSide:(NSString*)side;

@end
