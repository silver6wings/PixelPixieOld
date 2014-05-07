//
//  PPTabBarController.h
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-17.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

typedef NS_ENUM(NSInteger,PPMenuSwitchType) {
	PPMenuSwitchToPixieView = 0,
	PPMenuSwitchToPackView	= 1,
	PPMenuSwitchToFightView = 2,
	PPMenuSwitchToShopView	= 3,
	PPMenuSwitchToSettingView = 4
};

@interface PPTabBarController : UIViewController

@property (nonatomic, strong) UIViewController *relatedActivityViewController;

@property (nonatomic, copy) void (^activityVCWillMoveToParentVCBlock)(UIViewController *activityVC);

@property (nonatomic, copy) void (^activityVCSwitchToPreviousVCByMenuTypeBlock)(PPMenuSwitchType type,UIViewController *previousVC);

@end
