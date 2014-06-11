//
//  PPBattleSideNode.m
//  PixelPixie
//
//  Created by xiefei on 6/10/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPBattleSideNode.h"

@implementation PPBattleSideNode
@synthesize target=_target;
@synthesize skillSelector=_skillSelector;
-(void)setSideElements:(PPPixie *)ppixie
{
    PPCustomButton*ppixieBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f) andImage:@"ball_pixie_plant2.png" withTarget:self withSelecter:@selector(pixieClick:)];
    ppixieBtn.position = CGPointMake(40.0f, -10.0f);
    [self addChild:ppixieBtn];
    
    
    // 添加 HP bar
    barPlayerHP = [PPHPSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(90, 6)];
    barPlayerHP.anchorPoint = CGPointMake(0, 0.0);
    barPlayerHP.position = CGPointMake(40.0f,15.0);
    [self addChild:barPlayerHP];
    
    // 添加 MP bar
    barPlayerMP = [PPHPSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(90, 6)];
    barPlayerMP.anchorPoint = CGPointMake(0, 0.0);
    barPlayerMP.position = CGPointMake(40.0f,barPlayerHP.position.y-10);
    [barPlayerMP setColor:[UIColor blueColor]];
    [self addChild:barPlayerMP];
    
    
    for (int i=0; i<5; i++) {
        PPCustomButton*ppixieSkillBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f) andTitle:[NSString stringWithFormat:@"技能%d",i] withTarget:self withSelecter:@selector(skillClick:)];
        ppixieSkillBtn.position = CGPointMake(40.0f*i+70, -30.0f);
        [self addChild:ppixieSkillBtn];
    }
    
}
-(void)pixieClick:(PPCustomButton *)sender
{
    
}
-(void)skillClick:(PPCustomButton *)sender
{
      if (self.target!=nil &&self.skillSelector!=nil &&[self.target respondsToSelector:self.skillSelector]) {
          [self.target performSelectorInBackground:self.skillSelector withObject:sender.name];
      }
   
}
-(void)changeHPValue:(CGFloat)HPValue
{
    [barPlayerHP HPChangeWith:HPValue];
}
-(void)changeMPValue:(CGFloat)MPValue
{
    [barPlayerMP MPChangeWith:MPValue];
}
@end
