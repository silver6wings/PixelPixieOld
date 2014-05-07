
#import "PPElement.h"
#import "PPBall.h"

@interface PPPixie : NSObject {
    
    
    // 喂养属性
    float pixieSatiation;   // 饱食度
    float pixieIntimate;    // 亲密度
    
    // 战斗属性
    int pixieLEVEL;         // 等级
    
    float pixieHP;      // 生命值 HealthPoint
    float pixieHPmax;   // 生命值上限 HealthPointMax
    float pixieMP;      // 魔法值 ManaPoint
    float pixieMPmax;   // 魔法值上限 ManaPointMax
    float pixieAP;      // 攻击力 AttackPoint;
    float pixieDP;      // 防御力 DefendPoint;
    
    float pixieGP;      // 成长值 GrowthPoint;
    float pixieDEX;     // 闪避值 Dexterity
    
    // 固有属性
    int pixieGeneration;    // 进化的代数
    PPElementType pixieElement;     // 属性
    PPBall * pixieBall;             // 小球
    NSArray * pixieSkills;          // 技能
    NSArray * pixieBuffs;           // 状态
}

@property (nonatomic, assign) float pixieSatiation;
@property (nonatomic, assign) float pixieIntimate;

@property (nonatomic, assign) int pixieLEVEL;
@property (nonatomic, assign) float pixieHP;
@property (nonatomic, assign) float pixieHPmax;
@property (nonatomic, assign) float pixieMP;
@property (nonatomic, assign) float pixieMPmax;
@property (nonatomic, assign) float pixieAP;
@property (nonatomic, assign) float pixieDP;
@property (nonatomic, assign) float pixieGP;
@property (nonatomic, assign) float pixieDEX;

@property (nonatomic, assign) int pixieGeneration;
@property (nonatomic) PPElementType pixieElement;
@property (nonatomic) NSArray * pixieSkills;
@property (nonatomic) NSArray * pixieBuffs;

@property (nonatomic) PPBall * pixieBall;

+(PPPixie *)birthPixieWith:(PPElementType)pixieElement
                Generation:(int)generation;

@end