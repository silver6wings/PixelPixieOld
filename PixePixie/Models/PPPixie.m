//
//  PPPixie.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-4-21.
//  Copyright (c) 2014年 silver6wings. All rights reserved.//42.120.21.30
//

#import "PPPixie.h"

@implementation PPPixie
@synthesize pixieSatiation;
@synthesize pixieName;
@synthesize pixieIntimate ;
@synthesize pixieLEVEL;
@synthesize currentHP;      // 当前生命值
@synthesize pixieHPmax;     // 生命值上限 HealthPointMax
@synthesize currentMP;      // 魔法值 ManaPoint
@synthesize pixieMPmax;     // 魔法值上限 ManaPointMax
@synthesize pixieAPmax;     // 攻击力 AttackPoint;
@synthesize currentAP;      // 当前攻击力 AttackPoint;
@synthesize pixieDPmax;     // 防御力 DefendPoint;
@synthesize currentDP;      // 当前防御力 DefendPoint;
@synthesize pixieDEXmax;    // 闪避值 Dexterity
@synthesize currentDEX;     // 当前闪避值 Dexterity
@synthesize pixieDEFmax;    // 防御  Defense
@synthesize currentDEF;     // 当前防御  Defense
@synthesize pixieGeneration;
@synthesize pixieElement;
@synthesize pixieSkills;
@synthesize pixieBall;
@synthesize pixieBuffAgg;

// 创建新的宠物
+(PPPixie *)birthPixieWithPetsInfo:(NSDictionary *)petsDict
{
    PPPixie * tPixie = [[PPPixie alloc] init];
    
    tPixie.pixieHPmax = 1000*[[petsDict objectForKey:@"petstatus"] intValue];
    tPixie.pixieMPmax = 1000*[[petsDict objectForKey:@"petstatus"] intValue];
    tPixie.pixieName = [petsDict objectForKey:@"petname"];
    tPixie.currentHP = tPixie.pixieHPmax;
    tPixie.currentMP = tPixie.pixieMPmax;
    tPixie.currentAP = 10;
    tPixie.currentDP = 1;
    tPixie.pixieGeneration = [[petsDict objectForKey:@"petstatus"] intValue];
    
    tPixie.pixieElement = [[petsDict objectForKey:@"petelementtype"] intValue];
    tPixie.pixieSkills = [NSArray arrayWithArray:[petsDict objectForKey:@"pixieSkills"]];
    tPixie.pixieBuffAgg = [[PPBuffAgg alloc] init];
    tPixie.pixieBall = [PPBall ballWithPixie:tPixie];
    
    return tPixie;
}

@end
