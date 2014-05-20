//
//  PPSettingScene.m
//  PixelPixie
//
//  Created by xiefei on 5/20/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPSettingScene.h"
#import "PPTableView.h"

@implementation PPSettingScene
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {

        self.backgroundColor = [UIColor whiteColor];
        
//        PPTableView *ppTable1=[[PPTableView alloc] initWithFrame:self.view.frame];
//        [ppTable1 setBackgroundColor:[UIColor blackColor]];
//        NSArray *productInfoArray=[NSArray arrayWithObjects:@"奖励",@"好友排行榜",@"收件箱",@"好友",@"邀请好友",@"论坛", nil];
//        [ppTable1 ppsetTableViewWithData:productInfoArray];
//        [self addChild:(SKSpriteNode *)ppTable1];
        
        
    }
    return self;
}
@end
