//
//  PPPixie.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-4-21.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "PPPixie.h"

@implementation PPPixie
@synthesize pixieSatiation, pixieIntimate, pixieLEVEL,
            pixieHP, pixieHPmax, pixieMP, pixieMPmax, pixieAP, pixieDP, pixieGP, pixieDEX,
            pixieGeneration, pixieElement, pixieBuffs, pixieSkills, pixieBall;

// 创建新的宠物
+(PPPixie *)birthPixieWith:(PPElementType)pixieElement
                Generation:(int)generation{
    
    PPPixie * tPixie = [[PPPixie alloc] init];
    
    tPixie.pixieHPmax = 1000*generation;
    tPixie.pixieMPmax = 100*generation;
    tPixie.pixieAP = 10;
    tPixie.pixieDP = 1;
    
    tPixie.pixieGeneration = generation;
    tPixie.pixieElement = pixieElement;
    tPixie.pixieSkills = [NSArray arrayWithObjects:nil];
    tPixie.pixieBuffs = [NSArray arrayWithObjects:nil];
    tPixie.pixieBall = [PPBall ballWithPixie:tPixie];
    
    return tPixie;
}

@end
