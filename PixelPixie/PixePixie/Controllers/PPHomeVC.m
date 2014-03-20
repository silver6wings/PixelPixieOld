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
@property (nonatomic, strong) PPMenuVC *menuVC;

@end

@implementation PPHomeVC

- (PPTabBarController *)tabBarController {
	if (!_tabBarController) {
		__weak __typeof(&*self) weakSelf = self;
		_tabBarController = [[PPTabBarController alloc] initWithNibName:@"PPTabBarController" bundle:nil];
		_tabBarController.view.frame = self.tabBarView.bounds;
//		[_tabBarController setTabBarItemSelectedBlock:^(PPMenuSwitchType type) {
//			switch (type) {
//				case PPMenuSwitchToPixieView:
//					weakSelf.menuVC.menuTitle = @"怪兽";
//					[weakSelf contentViewAddMenuVC];
//					break;
//				case PPMenuSwitchToPackView:
//					weakSelf.contentView.backgroundColor = [UIColor magentaColor];
//					break;
//				case PPMenuSwitchToFightView:
//					weakSelf.contentView.backgroundColor = [UIColor greenColor];
//					break;
//				case PPMenuSwitchToShopView:
//					weakSelf.contentView.backgroundColor = [UIColor purpleColor];
//					break;
//				case PPMenuSwitchToSettingView:
//					weakSelf.contentView.backgroundColor = [UIColor yellowColor];
//					break;
//				default:
//					break;
//			}
//		}];
		[_tabBarController setSwitchMenuVCFromPreviousChildVCBlock:^(PPMenuSwitchType type, UIViewController *previousChildVC) {
			switch (type) {
				case PPMenuSwitchToPixieView:
					weakSelf.menuVC.menuTitle = @"怪兽";
					[weakSelf contentViewSwitchMenuVCFromPreviousChildVC:previousChildVC];
					break;
					
				default:
					break;
			}
		}];
	}
	return _tabBarController;
}

- (PPMenuVC *)menuVC {
	if (!_menuVC) {
		_menuVC = [[PPMenuVC alloc] initWithNibName:@"PPMenuVC" bundle:nil];
		_menuVC.view.frame = self.contentView.bounds;
		__weak __typeof(&*self) weakSelf = self;
		[_menuVC setRemoveFromParentVCBlock:^(UIViewController *viewController) {
			[UIView animateWithDuration:.5f animations:^{
				weakSelf.menuVC.view.frame = CGRectMake(-CGRectGetWidth(weakSelf.contentView.bounds), 0, CGRectGetWidth(weakSelf.contentView.bounds), CGRectGetHeight(weakSelf.contentView.bounds));
			} completion:^(BOOL finished) {
				[viewController willMoveToParentViewController:nil];
				[viewController.view removeFromSuperview];
				[viewController removeFromParentViewController];
			}];
		}];
	}
	return _menuVC;
}

- (void)contentViewSwitchMenuVCFromPreviousChildVC:(UIViewController *)previousChildVC {
	[UIView animateWithDuration:.5f animations:^{
		previousChildVC.view.frame = CGRectMake(-CGRectGetWidth(self.contentView.bounds), 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds));
	} completion:^(BOOL finished) {
		[previousChildVC willMoveToParentViewController:nil];
		[previousChildVC.view removeFromSuperview];
		[previousChildVC removeFromParentViewController];
		if (finished) {
			[self addChildViewController:self.menuVC];
			[self.contentView addSubview:self.menuVC.view];
			[self.menuVC didMoveToParentViewController:self];
			[UIView animateWithDuration:.5f animations:^{
				self.menuVC.view.frame = self.contentView.bounds;
			}];
		}
	}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self addChildViewController:self.tabBarController];
	[self.tabBarView addSubview:self.tabBarController.view];
	[self.tabBarController didMoveToParentViewController:self];
	self.tabBarController.switchMenuVCFromPreviousChildVCBlock(PPMenuSwitchToPixieView,self.menuVC);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
