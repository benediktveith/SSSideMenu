//
//  SSSideMenu.h
//  SSSideMenu
//
//  Created by Benedikt Veith on 28/09/15.
//  Copyright © 2015 Benedikt Veith. All rights reserved.
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
 *  @param side     Whether 'Both' / 'Left' / 'Right'
 *  @param mainView Main ViewController
 *  @param sideMenu Side menu that will be opened
 */
- (void)initSSSideMenuWithSwipeOnSide:(NSString *)side
                               onView:(UIViewController *)mainView
                              forMenu:(UITableViewController*)sideMenu;

/**
 *  Open side menu on the left side of screen
 *
 *  @param mainView Main ViewController
 *  @param sideMenu Side menu that will be opened
 */
- (void)moveViewFromLeftToRightFor:(UIViewController*)mainView and:(UITableViewController*)sideMenu;

/**
 *  Open side menu on the right side of screen
 *
 *  @param mainView Main ViewController
 *  @param sideMenu Side menu that will be opened
 */
- (void)moveViewFromRightToLeftFor:(UIViewController*)mainView and:(UITableViewController*)sideMenu;

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

@end
