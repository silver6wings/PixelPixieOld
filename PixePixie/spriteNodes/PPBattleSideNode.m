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
@synthesize currentPPPixie;
-(void)setSideElements:(PPPixie *)ppixie
{
    PPCustomButton*ppixieBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f) andImage:@"ball_pixie_plant2.png" withTarget:self withSelecter:@selector(pixieClick:)];
    ppixieBtn.position = CGPointMake(40.0f, -10.0f);
    [self addChild:ppixieBtn];
    self.currentPPPixie = ppixie;
    
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
    
    
    for (int i=0; i<[ppixie.pixieSkills count]; i++) {
        PPCustomButton*ppixieSkillBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f) andTitle:[[ppixie.pixieSkills objectAtIndex:i] objectForKey:@"skillname"] withTarget:self withSelecter:@selector(skillClick:)];
        ppixieSkillBtn.name=[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i];
        ppixieSkillBtn.position = CGPointMake(70.0f*i+70, -30.0f);
        [self addChild:ppixieSkillBtn];
    }
    
}
-(void)pixieClick:(PPCustomButton *)sender
{
    
}
-(void)skillClick:(PPCustomButton *)sender
{
    
    NSDictionary *skillChoosed=[self.currentPPPixie.pixieSkills objectAtIndex:[sender.name intValue]-PP_SKILLS_CHOOSE_BTN_TAG];
    
      if (self.target!=nil &&self.skillSelector!=nil &&[self.target respondsToSelector:self.skillSelector]) {
          [self.target performSelectorInBackground:self.skillSelector withObject:skillChoosed];
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
