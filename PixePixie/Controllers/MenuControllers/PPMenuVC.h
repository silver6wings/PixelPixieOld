//
//  PPMenuVC.h
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-20.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//


@interface PPMenuVC : UIViewController

@property (nonatomic, copy) NSString *menuTitle;

@property (nonatomic, readonly) PPMenuSwitchType type;

@property (nonatomic, copy) void (^activityVCRemoveFromParentVC)(UIViewController *activityVC);

@end
