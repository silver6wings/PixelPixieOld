//
//  PPEnemyPixie.h
//  PixelPixie
//
//  Created by xiefei on 6/16/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPElement.h"
#import "PPSkillNode.h"
@class PPBall;
@interface PPEnemyPixie : NSObject
{
    
    
    // 喂养属性
    CGFloat pixieSatiation;   // 饱食度
    CGFloat pixieIntimate;    // 亲密度
    
    // 战斗属性
    int pixieLEVEL;         // 等级
    
    
    CGFloat currentHP;      // 当前生命值
    CGFloat pixieHPmax;   // 生命值上限 HealthPointMax
    CGFloat currentMP;      // 魔法值 ManaPoint
    CGFloat pixieMPmax;   // 魔法值上限 ManaPointMax
    CGFloat pixieAPmax;      // 攻击力 AttackPoint;
    CGFloat currentAP;      // 当前攻击力 AttackPoint;
    CGFloat pixieDPmax;      // 防御力 DefendPoint;
    CGFloat currentDP;      // 当前防御力 DefendPoint;
    CGFloat pixieDEXmax;     // 闪避值 Dexterity
    CGFloat currentDEX;     // 当前闪避值 Dexterity
    CGFloat pixieDEFmax; // 防御  Defense
    CGFloat currentDEF;  // 当前防御  Defense
    
    
    // 固有属性
    CGFloat pixieGP;      // 成长值 GrowthPoint;
    PPElementType pixieElement;     // 属性
    PPBall * pixieBall;             // 小球
    NSArray * pixieSkills;          // 技能
    NSArray * pixieBuffs;           // 附加状态
    int status;                     // 形态
    
    
}
@property (nonatomic,retain)NSString *pixieName;
@property (nonatomic, assign) CGFloat pixieSatiation;
@property (nonatomic, assign) CGFloat pixieIntimate;

@property (nonatomic, assign) int pixieLEVEL;
@property (nonatomic, assign) CGFloat pixieHP;
@property (nonatomic, assign) CGFloat pixieHPmax;
@property (nonatomic, assign) CGFloat pixieMP;
@property (nonatomic, assign) CGFloat pixieMPmax;
@property (nonatomic, assign) CGFloat pixieAP;
@property (nonatomic, assign) CGFloat pixieDP;
@property (nonatomic, assign) CGFloat pixieGP;
@property (nonatomic, assign) CGFloat pixieDEX;

@property (nonatomic, assign) int pixieGeneration;
@property (nonatomic) PPElementType pixieElement;
@property (nonatomic,retain) NSArray * pixieSkills;
@property (nonatomic) NSArray * pixieBuffs;

@property (nonatomic) PPBall * pixieBall;

// 创建新的敌人怪物
+(PPEnemyPixie *)birthEnemyPixieWithPetsInfo:(NSDictionary *)petsDict;

@end
