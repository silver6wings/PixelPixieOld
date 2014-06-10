//
//  PPBattleSideNode.m
//  PixelPixie
//
//  Created by xiefei on 6/10/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPBattleSideNode.h"

@implementation PPBattleSideNode
-(void)setSideElements:(PPPixie *)ppixie
{
    PPCustomButton*ppixieBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f) andImage:@"ball_pixie_plant2.png" withTarget:self withSelecter:@selector(pixieClick:)];
    ppixieBtn.position = CGPointMake(40.0f, 0.0f);
    [self addChild:ppixieBtn];
    
    
    // 添加 HP bar
    barPlayerHP = [PPHPSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(90, 10)];
    barPlayerHP.anchorPoint = CGPointMake(0, 0.0);
    barPlayerHP.position = CGPointMake(0.0f,15.0);
    [self addChild:barPlayerHP];
    
    for (int i=0; i<5; i++) {
        PPCustomButton*ppixieSkillBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f) andTitle:[NSString stringWithFormat:@"技能%d",i] withTarget:self withSelecter:@selector(skillClick:)];
        ppixieSkillBtn.position = CGPointMake(40.0f*i+70, -10.0f);
        [self addChild:ppixieSkillBtn];
    }
    
}
-(void)pixieClick:(PPCustomButton *)sender
{
    
}
-(void)skillClick:(PPCustomButton *)sender
{
    
}
-(void)changeHPValue:(CGFloat)HPValue
{
    [barPlayerHP HPChangeWith:HPValue];
    
}
@end
