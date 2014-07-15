//
//#import "PPPixie.h"
//
//@class PPBall;
//@class PPBuff;
//@class PPPixie;
//
//@interface PPEnemyPixie : NSObject
//{
//    
//    // 喂养属性
//    CGFloat pixieSatiation;   // 饱食度
//    CGFloat pixieIntimate;    // 亲密度
//    
//    // 战斗属性
//    int pixieLEVEL;         // 等级
//    
//    // 固有属性
//    CGFloat pixieGP;      // 成长值 GrowthPoint;
//    PPElementType pixieElement;     // 属性
//    PPBall * pixieBall;             // 小球
//    NSArray * pixieSkills;          // 技能
//    NSArray * pixieBuffs;           // 附加状态
//    int status;                     // 形态
//    
//    
//}
//
//@property (nonatomic,retain)NSString *pixieName;
//@property (nonatomic, assign) CGFloat pixieSatiation;
//@property (nonatomic, assign) CGFloat pixieIntimate;
//
//@property (nonatomic, assign) int pixieLEVEL;
//@property (nonatomic, assign) CGFloat currentHP;      // 当前生命值
//@property (nonatomic, assign) CGFloat pixieHPmax;   // 生命值上限 HealthPointMax
//@property (nonatomic, assign) CGFloat currentMP;      // 魔法值 ManaPoint
//@property (nonatomic, assign) CGFloat pixieMPmax;   // 魔法值上限 ManaPointMax
//@property (nonatomic, assign) CGFloat pixieAPmax;      // 攻击力 AttackPoint;
//@property (nonatomic, assign) CGFloat currentAP;      // 当前攻击力 AttackPoint;
//@property (nonatomic, assign) CGFloat pixieDPmax;      // 防御力 DefendPoint;
//@property (nonatomic, assign) CGFloat currentDP;      // 当前防御力 DefendPoint;
//@property (nonatomic, assign) CGFloat pixieDEXmax;     // 闪避值 Dexterity
//@property (nonatomic, assign) CGFloat currentDEX;     // 当前闪避值 Dexterity
//@property (nonatomic, assign) CGFloat pixieDEFmax; // 防御  Defense
//@property (nonatomic, assign) CGFloat currentDEF;  // 当前防御  Defense
//
//@property (nonatomic, assign) int pixieGeneration;
//@property (nonatomic) PPElementType pixieElement;
//@property (nonatomic,retain) NSArray * pixieSkills;
//@property (nonatomic,retain) PPBuff *pixieBuffAgg;
//
//@property (nonatomic) PPBall * pixieBall;
//
//// 创建新的敌人怪物
//+(PPEnemyPixie *)birthEnemyPixieWithPetsInfo:(NSDictionary *)petsDict;
//
//@end
