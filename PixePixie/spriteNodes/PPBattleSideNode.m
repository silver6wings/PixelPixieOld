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
@synthesize currentEenemyPPPixie;
@synthesize physicsAttackSelector;

-(void)setSideElementsForPet:(PPPixie *)ppixie
{
    
    
    PPCustomButton*ppixieBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f) andImage:@"ball_pixie_plant2.png" withTarget:self withSelecter:@selector(physicsAttackClick:)];
    ppixieBtn.position = CGPointMake(40.0f, -10.0f);
    [self addChild:ppixieBtn];
    
    
    
    PPBasicLabelNode *ppixieBtnLabel=[[PPBasicLabelNode alloc] init];
    ppixieBtnLabel.fontSize=10;
    [ppixieBtnLabel setColor:[SKColor redColor]];
    NSLog(@"pixieName=%@",ppixie.pixieName);
    [ppixieBtnLabel setText:@"物理攻击"];
    ppixieBtnLabel.position = CGPointMake(0, 0);
    [ppixieBtn addChild:ppixieBtnLabel];
    
    
    
    self.currentPPPixie = ppixie;
    
    
    PPBasicLabelNode *ppixieNameLabel=[[PPBasicLabelNode alloc] init];
    ppixieNameLabel.fontSize=12;
    [ppixieNameLabel setColor:[SKColor blueColor]];
    NSLog(@"pixieName=%@",ppixie.pixieName);
    [ppixieNameLabel setText:ppixie.pixieName];
    ppixieNameLabel.position = CGPointMake(0, ppixieBtn.position.y+5);
    [self addChild:ppixieNameLabel];
    
    
    // 添加 HP bar
    barPlayerHP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(90, 6)];
    [barPlayerHP setMaxValue:ppixie.pixieHPmax andCurrentValue:ppixie.currentHP andShowType:PP_HPTYPE];
    barPlayerHP.anchorPoint = CGPointMake(0, 0.0);
    barPlayerHP.position = CGPointMake(40.0f,15.0);
    [self addChild:barPlayerHP];
    
    
    // 添加 MP bar
    barPlayerMP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(90, 6)];
    [barPlayerMP setMaxValue:ppixie.pixieMPmax andCurrentValue:ppixie.currentHP andShowType:PP_MPTYPE];
    barPlayerMP.anchorPoint = CGPointMake(0, 0.0);
    barPlayerMP.position = CGPointMake(40.0f,barPlayerHP.position.y-10);
    [self addChild:barPlayerMP];
    
    NSArray *skillsArray = [NSArray arrayWithArray:ppixie.pixieSkills];
    for (int i=0; i<[ppixie.pixieSkills count]; i++) {
        PPCustomButton*ppixieSkillBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f) andTitle:[[skillsArray objectAtIndex:i] objectForKey:@"skillname"] withTarget:self withSelecter:@selector(skillClick:)];
        ppixieSkillBtn.name=[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i];
        ppixieSkillBtn.position = CGPointMake(70.0f*i+70, -30.0f);
        [self addChild:ppixieSkillBtn];
    }
    
}
-(void)setSideElementsForEnemy:(PPEnemyPixie *)ppixie
{
    
    PPCustomButton*ppixieBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f) andImage:@"ball_pixie_plant2.png" withTarget:self withSelecter:@selector(physicsAttackClick:)];
    ppixieBtn.position = CGPointMake(40.0f, -10.0f);
    
    [self addChild:ppixieBtn];
    
    
    PPBasicLabelNode *ppixieBtnLabel=[[PPBasicLabelNode alloc] init];
    ppixieBtnLabel.fontSize=10;
    NSLog(@"pixieName=%@",ppixie.pixieName);
    [ppixieBtnLabel setText:@"物理攻击"];
    ppixieBtnLabel.position = CGPointMake(0, 0);
    [ppixieBtn addChild:ppixieBtnLabel];
    
    
    
    self.currentEenemyPPPixie = ppixie;
    
    
    PPBasicLabelNode *ppixieNameLabel=[[PPBasicLabelNode alloc] init];
    ppixieNameLabel.fontSize=12;
    [ppixieNameLabel setColor:[SKColor redColor]];
    NSLog(@"pixieName=%@",ppixie.pixieName);
    [ppixieNameLabel setText:ppixie.pixieName];
    ppixieNameLabel.position = CGPointMake(0, ppixieBtn.position.y+15);
    [self addChild:ppixieNameLabel];
    
    
    // 添加 HP bar
    barPlayerHP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(90, 6)];
    [barPlayerHP setMaxValue:ppixie.pixieHPmax andCurrentValue:ppixie.pixieHP andShowType:PP_HPTYPE];
    barPlayerHP.anchorPoint = CGPointMake(0, 0.0);
    barPlayerHP.position = CGPointMake(40.0f,15.0);
    [self addChild:barPlayerHP];
    
    
    // 添加 MP bar
    barPlayerMP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(90, 6)];
    [barPlayerMP setMaxValue:ppixie.pixieMPmax andCurrentValue:ppixie.pixieMP andShowType:PP_MPTYPE];
    barPlayerMP.anchorPoint = CGPointMake(0, 0.0);
    barPlayerMP.position = CGPointMake(40.0f,barPlayerHP.position.y-10);
    [self addChild:barPlayerMP];
    
    
    for (int i=0; i<[ppixie.pixieSkills count]; i++) {
        PPCustomButton*ppixieSkillBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f) andTitle:[[ppixie.pixieSkills objectAtIndex:i] objectForKey:@"skillname"] withTarget:self withSelecter:@selector(enemyskillClick:)];
        ppixieSkillBtn.name=[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i];
        ppixieSkillBtn.position = CGPointMake(70.0f*i+70, -30.0f);
        [self addChild:ppixieSkillBtn];
    }
    
}

-(void)physicsAttackClick:(PPCustomButton *)sender
{
    
    
    if (self.target!=nil &&self.physicsAttackSelector!=nil &&[self.target respondsToSelector:self.physicsAttackSelector]) {
        [self.target performSelectorInBackground:self.physicsAttackSelector withObject:self.name];
    }
    
    
}

-(void)skillClick:(PPCustomButton *)sender
{
    
    NSDictionary *skillChoosed=[self.currentPPPixie.pixieSkills objectAtIndex:[sender.name intValue]-PP_SKILLS_CHOOSE_BTN_TAG];
    
      if (self.target!=nil &&self.skillSelector!=nil &&[self.target respondsToSelector:self.skillSelector]) {
          [self.target performSelectorInBackground:self.skillSelector withObject:skillChoosed];
      }
   
}
-(void)enemyskillClick:(PPCustomButton *)sender
{
    
    NSDictionary *skillChoosed=[self.currentEenemyPPPixie.pixieSkills objectAtIndex:[sender.name intValue]-PP_SKILLS_CHOOSE_BTN_TAG];
    
    if (self.target!=nil &&self.skillSelector!=nil &&[self.target respondsToSelector:self.skillSelector]) {
        [self.target performSelectorInBackground:self.skillSelector withObject:skillChoosed];
    }
    
}
-(void)changeHPValue:(CGFloat)HPValue
{
    
    [barPlayerHP valueShowChangeMaxValue:0 andCurrentValue:HPValue];
    
}
-(void)changeMPValue:(CGFloat)MPValue
{
    [barPlayerMP valueShowChangeMaxValue:0 andCurrentValue:MPValue];
}
@end
