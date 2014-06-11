//
//  PPBattleSideNode.h
//  PixelPixie
//
//  Created by xiefei on 6/10/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPBasicSpriteNode.h"

@interface PPBattleSideNode : PPBasicSpriteNode
{
    PPHPSpriteNode *barPlayerHP;
    PPHPSpriteNode *barPlayerMP;
}
//回调对象
@property(nonatomic,assign) id target;
//回调方法
@property(nonatomic,assign) SEL skillSelector;

-(void)setSideElements:(PPPixie *)ppixie;
-(void)changeHPValue:(CGFloat)HPValue;
-(void)changeMPValue:(CGFloat)MPValue;
@end
