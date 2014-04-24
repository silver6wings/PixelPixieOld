//
//  PPPixie.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-4-21.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "PPPixie.h"

@implementation PPPixie
@synthesize ppSatiation, ppIntimate, ppElement, ppLEVEL,
            ppHP, ppHPmax, ppMP, ppMPmax, ppAP, ppDP, ppGP, ppDEX;

+(PPPixie *)birthPixiePlant:(int)Generation{
    
    PPPixie * tPixie = [[PPPixie alloc] init];
    
    tPixie.ppHPmax = 1000;
    tPixie.ppMPmax = 100;
    tPixie.ppAP = 10;
    tPixie.ppDP = 1;
    
    return tPixie;
}

@end
