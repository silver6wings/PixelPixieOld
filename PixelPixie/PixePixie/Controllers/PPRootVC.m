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

@property (nonatomic, weak) PPLoginVC *loginVC;

@property (nonatomic, weak) PPSelectPixieVC *pixieVC;

@property (nonatomic, weak) PPHomeVC *homeVC;

@end

@implementation PPRootVC

- (PPLoginVC *)loginVC {
	if (!_loginVC) {
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPStoryboard" bundle:nil];
		PPLoginVC *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"PPLoginVC"];
		loginVC.view.frame = self.view.bounds;
		_loginVC = loginVC;
	}
	return _loginVC;
}

- (PPSelectPixieVC *)pixieVC {
	if (!_pixieVC) {
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPStoryboard" bundle:nil];
		PPSelectPixieVC *pixieVC = [storyboard instantiateViewControllerWithIdentifier:@"PPSelectPixieVC"];
		pixieVC.view.frame = self.view.bounds;
		pixieVC.view.transform = CGAffineTransformMakeScale(0.f, 0.f);
		_pixieVC = pixieVC;
	}
	return _pixieVC;
}

- (PPHomeVC *)homeVC {
	if (!_homeVC) {
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PPStoryboard" bundle:nil];
		PPHomeVC *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"PPHomeVC"];
		homeVC.view.frame = self.view.bounds;
		homeVC.view.alpha = 0.f;
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
	[self.view addSubview:self.loginVC.view];
	[self.loginVC didMoveToParentViewController:self];
}

- (void)launchWithHomeVC {
	[self addChildViewController:self.homeVC];
	[self.view addSubview:self.homeVC.view];
	[self.homeVC didMoveToParentViewController:self];
}
// LoginVC确认按钮点击后执行的方法
- (void)addSelectPixieVCToParentVC {
	[UIView animateWithDuration:2.f animations:^{
		self.loginVC.view.transform = CGAffineTransformMakeScale(0.f, 0.f);
	} completion:^(BOOL finished) {
		[self.loginVC willMoveToParentViewController:nil];
		[self.loginVC.view removeFromSuperview];
		[self.loginVC removeFromParentViewController];
		if (finished) {
			[self addChildViewController:self.pixieVC];
			[self.view addSubview:self.pixieVC.view];
			[self.pixieVC didMoveToParentViewController:self];
			[UIView animateWithDuration:2.f animations:^{
				self.pixieVC.view.transform = CGAffineTransformMakeScale(1.f, 1.f);
			}];
		}
	}];
}
// PixieVC确认按钮点击后执行的方法
- (void)addHomeVCToParentVC {
	[UIView animateWithDuration:2.f animations:^{
		self.pixieVC.view.alpha = 0.f;
	} completion:^(BOOL finished) {
		[self.pixieVC willMoveToParentViewController:nil];
		[self.pixieVC.view removeFromSuperview];
		[self.pixieVC removeFromParentViewController];
		if (finished) {
			[self launchWithHomeVC];
			[UIView animateWithDuration:2.f animations:^{
				self.homeVC.view.alpha = 1.f;
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
