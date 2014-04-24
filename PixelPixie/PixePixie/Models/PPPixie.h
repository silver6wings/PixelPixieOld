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
    float ppSatiation;  // 饱食度
    float ppIntimate;   // 亲密度
    
    // 战斗属性
    int ppLEVEL;    // 等级
    
    float ppHP;     // 生命值 HealthPoint
    float ppHPmax;  // 生命值上限 HealthPointMax
    float ppMP;     // 魔法值 ManaPoint
    float ppMPmax;  // 魔法值上限 ManaPointMax
    float ppAP;     // 攻击力 AttackPoint;
    float ppDP;     // 防御力 DefendPoint;
    
    float ppGP;     // 成长值 GrowthPoint;
    float ppDEX;    // 闪避值 Dexterity
    
    PPElementType ppElement;    // 属性
    NSArray * ppSkills;         // 技能
    NSArray * ppBuffs;          // 状态
}

@property (nonatomic, assign) float ppSatiation;
@property (nonatomic, assign) float ppIntimate;

@property (nonatomic, readonly) int ppLEVEL;
@property (nonatomic, assign) float ppHP;
@property (nonatomic, assign) float ppHPmax;
@property (nonatomic, assign) float ppMP;
@property (nonatomic, assign) float ppMPmax;
@property (nonatomic, assign) float ppAP;
@property (nonatomic, assign) float ppDP;

@property (nonatomic, assign) float ppGP;
@property (nonatomic, assign) float ppDEX;

@property (nonatomic, readonly) PPElementType ppElement;

+(PPPixie *)birthPixiePlant:(int)Generation;

@end