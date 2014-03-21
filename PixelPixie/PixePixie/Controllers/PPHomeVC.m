//
//  PPHomeVC.m
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-11.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPHomeVC.h"

@interface PPHomeVC ()

@property (weak, nonatomic) IBOutlet UIView *tabBarView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) PPTabBarController *tabBarController;

@property (nonatomic, strong) PPMenuPixieVC *pixieVC;
@property (nonatomic, strong) PPMenuPackVC *packVC;
@property (nonatomic, strong) PPMenuFightVC *fightVC;
@property (nonatomic, strong) PPMenuShopVC *shopVC;
@property (nonatomic, strong) PPMenuSettingVC *settingVC;

//contentView中的ChildVC
@property (nonatomic, weak) UIViewController *activityViewController;

@end

@implementation PPHomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self addChildViewController:self.tabBarController];
	[self.tabBarView addSubview:self.tabBarController.view];
	[self.tabBarController didMoveToParentViewController:self];
	self.tabBarController.activityVCWillMoveToParentVCBlock(self.activityViewController);
}
#pragma tabBarController
- (PPTabBarController *)tabBarController {
	if (!_tabBarController) {
		_tabBarController = [[PPTabBarController alloc] initWithNibName:@"PPTabBarController" bundle:nil];
		_tabBarController.view.frame = self.tabBarView.bounds;
		if (!self.activityViewController) {
			self.activityViewController = self.pixieVC;
			_tabBarController.relatedActivityViewController = self.activityViewController;
		}
		
		__weak __typeof(&*self) weakSelf = self;
		//进入主界面默认怪兽VC是ActivityVC
		[_tabBarController setActivityVCWillMoveToParentVCBlock:^(UIViewController *activityViewController) {
			[weakSelf addChildViewController:activityViewController];
			[weakSelf.contentView addSubview:activityViewController.view];
			[activityViewController didMoveToParentViewController:weakSelf];
		}];
		//点击tabBar切换ActivityVC
		[_tabBarController setActivityVCSwitchToPreviousVCByMenuTypeBlock:^(PPMenuSwitchType type, UIViewController *previousViewController) {
			switch (type) {
				case PPMenuSwitchToPixieView:
					weakSelf.activityViewController = weakSelf.pixieVC;
					weakSelf.tabBarController.relatedActivityViewController = weakSelf.pixieVC;
					break;
				case PPMenuSwitchToPackView:
					weakSelf.activityViewController = weakSelf.packVC;
					weakSelf.tabBarController.relatedActivityViewController = weakSelf.packVC;
					break;
				case PPMenuSwitchToFightView:
					weakSelf.activityViewController = weakSelf.fightVC;
					weakSelf.tabBarController.relatedActivityViewController = weakSelf.fightVC;
					break;
				case PPMenuSwitchToShopView:
					weakSelf.activityViewController = weakSelf.shopVC;
					weakSelf.tabBarController.relatedActivityViewController = weakSelf.shopVC;
					break;
				case PPMenuSwitchToSettingView:
					weakSelf.activityViewController = weakSelf.settingVC;
					weakSelf.tabBarController.relatedActivityViewController = weakSelf.settingVC;
					break;
				default:
					break;
			}
			[UIView animateWithDuration:.5f animations:^{
				previousViewController.view.frame = CGRectMake(-CGRectGetWidth(weakSelf.contentView.bounds), 0, CGRectGetWidth(weakSelf.contentView.bounds), CGRectGetHeight(weakSelf.contentView.bounds));
			} completion:^(BOOL finished) {
				[previousViewController willMoveToParentViewController:nil];
				[previousViewController.view removeFromSuperview];
				[previousViewController removeFromParentViewController];
				if (finished) {
					[weakSelf addChildViewController:weakSelf.activityViewController];
					[weakSelf.contentView addSubview:weakSelf.activityViewController.view];
					[weakSelf.activityViewController didMoveToParentViewController:weakSelf];
					[UIView animateWithDuration:.5f animations:^{
						weakSelf.activityViewController.view.frame = weakSelf.contentView.bounds;
					}];
				}
			}];
		}];
	}
	return _tabBarController;
}
#pragma MenuVCs
- (PPMenuPixieVC *)pixieVC {
	if (!_pixieVC) {
		PPMenuPixieVC *pixieVC = [[PPMenuPixieVC alloc] initWithNibName:@"PPMenuVC" bundle:nil];
		pixieVC.view.frame = self.contentView.bounds;
		pixieVC.menuTitle = @"怪兽";
		[self bindingRemoveFunctionWithActivityViewController:pixieVC];
		_pixieVC = pixieVC;
	}
	return _pixieVC;
}

- (PPMenuPackVC *)packVC {
	if (!_packVC) {
		PPMenuPackVC *packVC = [[PPMenuPackVC alloc] initWithNibName:@"PPMenuVC" bundle:nil];
		packVC.view.frame = CGRectMake(-CGRectGetWidth(self.contentView.bounds), 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds));
		packVC.menuTitle = @"背包";
		[self bindingRemoveFunctionWithActivityViewController:packVC];
		_packVC = packVC;
	}
	return _packVC;
}

- (PPMenuFightVC *)fightVC {
	if (!_fightVC) {
		PPMenuFightVC *fightVC = [[PPMenuFightVC alloc] initWithNibName:@"PPMenuVC" bundle:nil];
		fightVC.view.frame = CGRectMake(-CGRectGetWidth(self.contentView.bounds), 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds));
		fightVC.menuTitle = @"战斗";
		[self bindingRemoveFunctionWithActivityViewController:fightVC];
		_fightVC = fightVC;

	}
	return _fightVC;
}

- (PPMenuShopVC *)shopVC {
	if (!_shopVC) {
		PPMenuShopVC *shopVC = [[PPMenuShopVC alloc] initWithNibName:@"PPMenuVC" bundle:nil];
		shopVC.view.frame = CGRectMake(-CGRectGetWidth(self.contentView.bounds), 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds));
		shopVC.menuTitle = @"商店";
		[self bindingRemoveFunctionWithActivityViewController:shopVC];
		_shopVC = shopVC;
	}
	return _shopVC;
}

- (PPMenuSettingVC *)settingVC {
	if (!_settingVC) {
		PPMenuSettingVC *settingVC = [[PPMenuSettingVC alloc] initWithNibName:@"PPMenuVC" bundle:nil];
		settingVC.view.frame = CGRectMake(-CGRectGetWidth(self.contentView.bounds), 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds));
		settingVC.menuTitle = @"设置";
		[self bindingRemoveFunctionWithActivityViewController:settingVC];
		_settingVC = settingVC;
	}
	return _settingVC;
}

- (void)bindingRemoveFunctionWithActivityViewController:(PPMenuVC *)activityViewController {
	//点击返回按钮移除activityVC
	__weak __typeof(&*self) weakSelf = self;
	[activityViewController setActivityVCRemoveFromParentVC:^(UIViewController *activityViewController) {
		[UIView animateWithDuration:.5f animations:^{
			activityViewController.view.frame = CGRectMake(-CGRectGetWidth(weakSelf.contentView.bounds), 0, CGRectGetWidth(weakSelf.contentView.bounds), CGRectGetHeight(weakSelf.contentView.bounds));
		} completion:^(BOOL finished) {
			[activityViewController willMoveToParentViewController:nil];
			[activityViewController.view removeFromSuperview];
			[activityViewController removeFromParentViewController];
		}];
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
