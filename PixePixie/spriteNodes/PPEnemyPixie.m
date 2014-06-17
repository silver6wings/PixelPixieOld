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
@synthesize pixieSatiation,pixieName, pixieIntimate, pixieLEVEL,
pixieHP, pixieHPmax, pixieMP, pixieMPmax, pixieAP, pixieDP, pixieGP, pixieDEX,
pixieGeneration, pixieElement, pixieBuffs, pixieSkills, pixieBall;
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
