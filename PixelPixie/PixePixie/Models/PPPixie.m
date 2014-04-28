//
//  PPPixie.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-4-21.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "PPPixie.h"

@interface PPPixie ()
@property (nonatomic, assign) float ppSatiation;
@property (nonatomic, assign) float ppIntimate;

@property (nonatomic, assign) int ppLEVEL;
@property (nonatomic, assign) float ppHP;
@property (nonatomic, assign) float ppHPmax;
@property (nonatomic, assign) float ppMP;
@property (nonatomic, assign) float ppMPmax;
@property (nonatomic, assign) float ppAP;
@property (nonatomic, assign) float ppDP;
@property (nonatomic, assign) float ppGP;
@property (nonatomic, assign) float ppDEX;

@property (nonatomic) PPElementType ppElement;
@property (nonatomic) PPBall * ppBall;

@end

@implementation PPPixie
@synthesize ppSatiation, ppIntimate, ppElement, ppLEVEL,
            ppHP, ppHPmax, ppMP, ppMPmax, ppAP, ppDP, ppGP, ppDEX;

+(PPPixie *)birthPixieWith:(PPElementType)pixieElement
                       And:(int)generation{
    
    PPPixie * tPixie = [[PPPixie alloc] init];
    
    tPixie.ppHPmax = 1000*generation;
    tPixie.ppMPmax = 100*generation;
    tPixie.ppAP = 10;
    tPixie.ppDP = 1;
    
    tPixie.ppElement = pixieElement;
    
    return tPixie;
}

@end
