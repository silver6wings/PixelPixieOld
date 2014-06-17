//
//  PPPixie.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-4-21.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "PPPixie.h"

@implementation PPPixie
@synthesize pixieSatiation,pixieName, pixieIntimate, pixieLEVEL,
            pixieHP, pixieHPmax, pixieMP, pixieMPmax, pixieAP, pixieDP, pixieGP, pixieDEX,
            pixieGeneration, pixieElement, pixieBuffs, pixieSkills, pixieBall;

// 创建新的宠物
+(PPPixie *)birthPixieWithPetsInfo:(NSDictionary *)petsDict
{
    
    PPPixie * tPixie = [[PPPixie alloc] init];
    
    tPixie.pixieHPmax = 1000*[[petsDict objectForKey:@"petstatus"] intValue];
    tPixie.pixieMPmax = 1000*[[petsDict objectForKey:@"petstatus"] intValue];
    tPixie.pixieName = [petsDict objectForKey:@"petname"];
    tPixie.pixieHP = tPixie.pixieHPmax;
    tPixie.pixieMP = tPixie.pixieMPmax;
    tPixie.pixieAP = 10;
    tPixie.pixieDP = 1;
    tPixie.pixieGeneration = [[petsDict objectForKey:@"petstatus"] intValue];
    
    tPixie.pixieElement = [[petsDict objectForKey:@"petelementtype"] intValue];
    tPixie.pixieSkills = [NSArray arrayWithArray:[petsDict objectForKey:@"pixieSkills"]];
    tPixie.pixieBuffs = [NSArray arrayWithObjects:nil];
    tPixie.pixieBall = [PPBall ballWithPixie:tPixie];
    
    return tPixie;
}


@end
