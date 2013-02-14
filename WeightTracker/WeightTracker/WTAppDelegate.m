//
//  WTAppDelegate.m
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/11/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import "WTAppDelegate.h"

#import "WTViewController.h"
#import "WTNavigationBar.h"

@implementation WTAppDelegate

- (void) customizeAppearance {
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    UIImage *navBarImage = [[UIImage imageNamed:@"navBar44.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    // Set the background image for *all* UINavigationBars
    [[WTNavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    
    // Customize the title text for *all* UINavigationBars
    [[WTNavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0], UITextAttributeTextColor,
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0], UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)], UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Futura" size:0.0], UITextAttributeFont,
      nil]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self customizeAppearance];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[WTViewController alloc] initWithNibName:@"WTViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[WTViewController alloc] initWithNibName:@"WTViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
