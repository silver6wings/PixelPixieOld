//
//  PPRootVC.m
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-8.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPRootVC.h"

@interface PPRootVC ()
@end

@implementation PPRootVC

- (void)viewDidLoad
{
    [super viewDidLoad];

	if ([ConfigData instance].launchWithVC) {
		[self launchWithLoginVC];
	} else {
		//TODO:launch with mainVC
	}
}

// 启动时显示LoginViewController
- (void)launchWithLoginVC {

	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPStoryboard" bundle:nil];
	PPLoginVC *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"PPLoginVC"];
	loginVC.view.frame = self.view.bounds;
	[self addChildViewController:loginVC];
	[self.view addSubview:loginVC.view];
	[loginVC didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
