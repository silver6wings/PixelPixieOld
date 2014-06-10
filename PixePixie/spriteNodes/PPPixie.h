
#import "PPElement.h"
#import "PPBall.h"
#import "PPSkillNode.h"
@interface PPPixie : NSObject {
    
    
    // 喂养属性
    CGFloat pixieSatiation;   // 饱食度
    CGFloat pixieIntimate;    // 亲密度
    
    // 战斗属性
    int pixieLEVEL;         // 等级
    
    CGFloat pixieHP;      // 生命值 HealthPoint
    CGFloat pixieHPmax;   // 生命值上限 HealthPointMax
    CGFloat pixieMP;      // 魔法值 ManaPoint
    CGFloat pixieMPmax;   // 魔法值上限 ManaPointMax
    CGFloat pixieAP;      // 攻击力 AttackPoint;
    CGFloat pixieDP;      // 防御力 DefendPoint;
    
    
    CGFloat pixieGP;      // 成长值 GrowthPoint;
    CGFloat pixieDEX;     // 闪避值 Dexterity
    CGFloat pixieDefense; // 防御  Defense
    
    
    // 固有属性
    int pixieGeneration;    // 进化的代数
    PPElementType pixieElement;     // 属性
    PPBall * pixieBall;             // 小球
    NSArray * pixieSkills;          // 技能
    NSArray * pixieBuffs;           // 状态
    int status;                     // 形态
    
    
}

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
@property (nonatomic) NSArray * pixieSkills;
@property (nonatomic) NSArray * pixieBuffs;

@property (nonatomic) PPBall * pixieBall;

+(PPPixie *)birthPixieWith:(PPElementType)pixieElement
                Generation:(int)generation;

@end