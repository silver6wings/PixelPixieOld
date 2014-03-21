//
//  PPMenuVC.m
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-20.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPMenuVC.h"

@interface PPMenuVC ()

@property (weak, nonatomic) IBOutlet UILabel *menuTitleLabel;

@end

@implementation PPMenuVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
	}
	return self;
}

- (void)setMenuTitle:(NSString *)menuTitle {
	_menuTitleLabel.text = menuTitle;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)removeFromParentViewController:(UIButton *)sender {
	if (self.activityVCRemoveFromParentVC) {
		self.activityVCRemoveFromParentVC(self);
	}
}

- (void)dealloc {
	NSLog(@"dealloc MenuVC");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
