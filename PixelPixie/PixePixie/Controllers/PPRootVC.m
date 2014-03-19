//
//  PPRootVC.m
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-8.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPRootVC.h"

NSString *const kPPSelectPixieVCWillMoveToParentVC = @"kPPSelectPixieVCWillMoveToParentVC";
NSString *const kPPHomeVCWillMoveToParentVC = @"kPPHomeVCWillMoveToParentVC";

@interface PPRootVC ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, weak) PPLoginVC *loginVC;

@property (nonatomic, weak) PPSelectPixieVC *pixieVC;

@property (nonatomic, weak) PPHomeVC *homeVC;

@end

@implementation PPRootVC

- (PPLoginVC *)loginVC {
	if (!_loginVC) {
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPStoryboard" bundle:nil];
		PPLoginVC *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"PPLoginVC"];
		loginVC.view.frame = self.contentView.bounds;
		_loginVC = loginVC;
	}
	return _loginVC;
}

- (PPSelectPixieVC *)pixieVC {
	if (!_pixieVC) {
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPStoryboard" bundle:nil];
		PPSelectPixieVC *pixieVC = [storyboard instantiateViewControllerWithIdentifier:@"PPSelectPixieVC"];
		pixieVC.view.frame = CGRectMake(CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds));
		_pixieVC = pixieVC;
	}
	return _pixieVC;
}

- (PPHomeVC *)homeVC {
	if (!_homeVC) {
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPStoryboard" bundle:nil];
		PPHomeVC *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"PPHomeVC"];
		homeVC.view.frame = CGRectMake(CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds));
		_homeVC = homeVC;
	}
	return _homeVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addSelectPixieVCToParentVC) name:kPPSelectPixieVCWillMoveToParentVC object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addHomeVCToParentVC) name:kPPHomeVCWillMoveToParentVC object:nil];
	
	if ([ConfigData instance].launchWithVC) {
		[self launchWithLoginVC];
	} else {
		[self launchWithHomeVC];
	}
}

// 首次启动时显示LoginViewController
- (void)launchWithLoginVC {
	[self addChildViewController:self.loginVC];
	[self.contentView addSubview:self.loginVC.view];
	[self.loginVC didMoveToParentViewController:self];
}

- (void)launchWithHomeVC {
	[self addChildViewController:self.homeVC];
	[self.contentView addSubview:self.homeVC.view];
	[self.homeVC didMoveToParentViewController:self];
}
// LoginVC确认按钮点击后执行的方法
- (void)addSelectPixieVCToParentVC {
	[UIView animateWithDuration:.5f animations:^{
		self.loginVC.view.frame = CGRectMake(CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.loginVC.view.frame), CGRectGetHeight(self.loginVC.view.frame));
	} completion:^(BOOL finished) {
		[self.loginVC willMoveToParentViewController:nil];
		[self.loginVC.view removeFromSuperview];
		[self.loginVC removeFromParentViewController];
		if (finished) {
			[self addChildViewController:self.pixieVC];
			[self.contentView addSubview:self.pixieVC.view];
			[self.pixieVC didMoveToParentViewController:self];
			[UIView animateWithDuration:.5f animations:^{
				self.pixieVC.view.frame = self.contentView.bounds;
			}];
		}
	}];
}
// PixieVC确认按钮点击后执行的方法
- (void)addHomeVCToParentVC {
	[UIView animateWithDuration:.5f animations:^{
		self.pixieVC.view.frame = CGRectMake(CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.pixieVC.view.frame), CGRectGetHeight(self.pixieVC.view.frame));
	} completion:^(BOOL finished) {
		[self.pixieVC willMoveToParentViewController:nil];
		[self.pixieVC.view removeFromSuperview];
		[self.pixieVC removeFromParentViewController];
		if (finished) {
			[self launchWithHomeVC];
			[UIView animateWithDuration:.5f animations:^{
				self.homeVC.view.frame = self.contentView.bounds;
			}];
		}
	}];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kPPSelectPixieVCWillMoveToParentVC object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kPPHomeVCWillMoveToParentVC object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
