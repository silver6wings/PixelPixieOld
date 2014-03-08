//
//  PPSelectPixieVC.m
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-8.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPSelectPixieVC.h"

@interface PPSelectPixieVC ()

@end

@implementation PPSelectPixieVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	double delayInSeconds = 15.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[self.navigationController popViewControllerAnimated:YES];
	});
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
