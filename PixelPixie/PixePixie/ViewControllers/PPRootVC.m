//
//  PPRootVC.m
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-8.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPRootVC.h"
#import "PPLoginVC.h"

@interface PPRootVC ()

@end

@implementation PPRootVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	//make system setting
	BOOL setting = YES;
	if (setting) {
		[self launchWithLoginVC];
	} else {
		//TODO:launch with mainVC
	}
}

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
