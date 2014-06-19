//
//  PPEnemyPixie.m
//  PixelPixie
//
//  Created by xiefei on 6/16/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPEnemyPixie.h"
#import "PPBall.h"

@implementation PPEnemyPixie
@synthesize pixieSatiation;
@synthesize pixieName;
@synthesize pixieIntimate;
@synthesize pixieLEVEL;
@synthesize pixieHP;
@synthesize pixieHPmax;
@synthesize pixieMP;
@synthesize pixieMPmax;
@synthesize pixieAP;
@synthesize pixieDP;
@synthesize pixieGP;
@synthesize pixieDEX;
@synthesize pixieGeneration;
@synthesize pixieElement;
@synthesize pixieBuffs;
@synthesize pixieSkills;
@synthesize pixieBall;
// 创建新的怪物
+(PPEnemyPixie *)birthEnemyPixieWithPetsInfo:(NSDictionary *)petsDict;
{
    
    PPEnemyPixie * tPixie = [[PPEnemyPixie alloc] init];
    
    tPixie.pixieHPmax = 1000*[[petsDict objectForKey:@"enemystatus"] intValue];
    tPixie.pixieMPmax = 1000*[[petsDict objectForKey:@"enemystatus"] intValue];
    tPixie.pixieName = [petsDict objectForKey:@"enemyname"];
    tPixie.pixieHP = tPixie.pixieHPmax;
    tPixie.pixieMP = tPixie.pixieMPmax;
    tPixie.pixieAP = 10;
    tPixie.pixieDP = 1;
    tPixie.pixieGeneration = [[petsDict objectForKey:@"enemystatus"] intValue];
    
    tPixie.pixieElement = [[petsDict objectForKey:@"enemytype"] intValue];
    tPixie.pixieSkills = [NSArray arrayWithArray:[petsDict objectForKey:@"enemySkills"]];
    tPixie.pixieBuffs = [NSArray arrayWithObjects:nil];
    tPixie.pixieBall = [PPBall ballWithEnemyPixie:tPixie];
    
    return tPixie;
}


@end
