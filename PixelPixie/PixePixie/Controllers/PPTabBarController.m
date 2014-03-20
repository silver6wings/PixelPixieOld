//
//  PPTabBarController.m
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-17.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPTabBarController.h"

@interface PPTabBarController ()

@property (nonatomic) PPMenuSwitchType switchType;

@end

@implementation PPTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//	if (self.tabBarItemSelectedBlock) {
//		self.tabBarItemSelectedBlock(PPMenuSwitchToPixieView);
//	}
}

- (IBAction)tabBarItemSelected:(UIButton *)sender {
	switch (sender.tag) {
		case 100:
			self.switchType = PPMenuSwitchToPixieView;
			break;
		case 101:
			self.switchType = PPMenuSwitchToPackView;
			break;
		case 102:
			self.switchType = PPMenuSwitchToFightView;
			break;
		case 103:
			self.switchType = PPMenuSwitchToShopView;
			break;
		case 104:
			self.switchType = PPMenuSwitchToSettingView;
			break;
		default:
			break;
	}
//	if (self.tabBarItemSelectedBlock) {
//		self.tabBarItemSelectedBlock(self.switchType);
//	}
	if (self.switchMenuVCFromPreviousChildVCBlock) {
		self.switchMenuVCFromPreviousChildVCBlock(self.switchType,self.previousChildVC);
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
