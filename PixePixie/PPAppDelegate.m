//
//  AppDelegate.m
//  PixePixie
//
//  Created by silver6wings on 14-3-5.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPAppDelegate.h"
#import "PPControllers.h"

@implementation PPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    PPMainViewController * vc = [[PPMainViewController alloc] init];
    
    UINavigationController *navMain=[[UINavigationController alloc] initWithRootViewController:vc];
    navMain.navigationBarHidden=YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navMain;
    
    [self.window makeKeyAndVisible];
    
	return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application{}
- (void)applicationDidEnterBackground:(UIApplication *)application{}
- (void)applicationWillEnterForeground:(UIApplication *)application{}
- (void)applicationDidBecomeActive:(UIApplication *)application{}
- (void)applicationWillTerminate:(UIApplication *)application{}

@end
