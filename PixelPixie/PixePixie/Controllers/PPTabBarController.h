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

@property (nonatomic, strong) UIViewController *previousChildVC;

@property (nonatomic, copy) void (^tabBarItemSelectedBlock)(PPMenuSwitchType type);

@property (nonatomic, copy) void (^switchMenuVCFromPreviousChildVCBlock)(PPMenuSwitchType type,UIViewController *previousChildVC);

@end
