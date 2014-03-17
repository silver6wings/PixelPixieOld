//
//  PPHomeVC.m
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-11.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPHomeVC.h"

@interface PPHomeVC ()

@property (nonatomic, strong) PPTabBarController *tabBarController;

@end

@implementation PPHomeVC

- (PPTabBarController *)tabBarController {
	if (!_tabBarController) {
		_tabBarController = [[PPTabBarController alloc] initWithNibName:@"PPTabBarController" bundle:nil];
	}
	return _tabBarController;
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
	self.tabBarController.view.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 70, CGRectGetWidth(self.view.frame), 70);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self addChildViewController:self.tabBarController];
	[self.view addSubview:self.tabBarController.view];
	[self.tabBarController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
