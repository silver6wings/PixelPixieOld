//
//  AppDelegate.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-2-25.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "AppDelegate.h"
#import "PlaneViewController.h"
#import "BallViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    if( [UIScreen mainScreen].bounds.size.height <= 480.0f ){
        NSLog(@"ip4");
    } else {
        NSLog(@"ip5");
    }
    
    UIViewController * vc = [[BallViewController alloc] init];
//    UIViewController * vc = [[PlaneViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application{}
- (void)applicationDidEnterBackground:(UIApplication *)application{}
- (void)applicationWillEnterForeground:(UIApplication *)application{}
- (void)applicationDidBecomeActive:(UIApplication *)application{}
- (void)applicationWillTerminate:(UIApplication *)application{}

@end
