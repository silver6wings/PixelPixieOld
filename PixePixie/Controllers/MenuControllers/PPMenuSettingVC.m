//
//  PPMenuSettingVC.m
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-20.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPMenuSettingVC.h"
#import "PPTableView.h"
@interface PPMenuSettingVC ()

@end

@implementation PPMenuSettingVC

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
    
    

    PPTableView *ppTable1=[[PPTableView alloc] initWithFrame:self.view.frame];
    NSArray *productInfoArray=[NSArray arrayWithObjects:@"奖励",@"好友排行榜",@"收件箱",@"好友",@"邀请好友",@"论坛", nil];
    [ppTable1 ppsetTableViewWithData:productInfoArray];
    [self.view addSubview:ppTable1];
    //    for (int i=0; i<[Tmparray count]; i++) {
    //        UILabel *labelProductInfo = [[UILabel alloc] initWithFrame:CGRectMake(-100, i*35.0f, 270, 30)];
    //        labelProductInfo.text =[Tmparray objectAtIndex:i];
    //        [labelProductInfo setFont:[UIFont boldSystemFontOfSize:12]];
    //        labelProductInfo.backgroundColor = [UIColor redColor];
    //        labelProductInfo.textColor = [UIColor blackColor];
    //        [labelProductInfo sizeToFit];
    //        [self addSubview:labelProductInfo];
    //        
    //    }
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
