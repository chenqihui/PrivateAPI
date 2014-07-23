//
//  AppDelegate.m
//  ForInstallApp
//
//  Created by chen on 14-7-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}

//打包在<ForInstallApp1.ipa>里面
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
//    NSLog(@"URL scheme:%@", [url scheme]);
//    NSLog(@"URL query: %@", [url query]);
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"URL openURL"
//                                                    message:[NSString stringWithFormat:
//                                                             @"result for:\r\n %@--%@--%@", sourceApplication, [url scheme], [url query]]
//                                                   delegate:self cancelButtonTitle:@"Ok"
//                                          otherButtonTitles:nil];
//    [alert show];
//    
//    return YES;
//}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSLog(@"Application handleOpenURL: %@", [url absoluteString]);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL query: %@", [url query]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"URL handleOpenURL"
                                                    message:[NSString stringWithFormat:
                                                             @"result for:\r\n %@--%@--%@", [url absoluteString], [url scheme], [url query]]
                                                   delegate:self cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
    
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
