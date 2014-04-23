//
//  PPPixie.h
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-4-21.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "PPElement.h"

@interface PPPixie : NSObject {
    
    // 喂养属性
    float ppSAT;    // 饱食度 Satiation
    float ppINT;    // 亲密度 Intimate
    
    // 战斗属性
    int ppLevel;    // 等级
    
    float ppHP;     // 生命值 HealthPoint
    float ppMP;     // 魔法值 ManaPoint
    float ppAP;     // 攻击力 AttackPoint;
    float ppDP;     // 防御力 DefendPoint;
    
    float ppGP;     // 成长值 GrowthPoint;
    float ppDEX;    // 闪避值 Dexterity
    
    PPElementType ppElement;  // 属性
}

@property (nonatomic) float ppSAT;
@property (nonatomic) float ppINT;

@property (nonatomic, readonly) int ppLevel;

@property (nonatomic) float ppHP;
@property (nonatomic) float ppMP;
@property (nonatomic) float ppAP;
@property (nonatomic) float ppDP;

@property (nonatomic) float ppGP;
@property (nonatomic) float ppDEX;

@property (nonatomic, readonly) PPElementType ppElement;



@end