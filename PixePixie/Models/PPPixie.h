@class PPElement;
@class PPSkill;
@class PPBuff;
@class PPBall;

@interface PPPixie : NSObject

@property (nonatomic, retain) NSString * pixieName;
@property (nonatomic, assign) int pixieStatus;          // 活动状态
@property (nonatomic, assign) CGFloat pixieSatiation;   // 饱食度
@property (nonatomic, assign) CGFloat pixieIntimate;    // 亲密度
@property (nonatomic, assign) CGFloat pixieGP;          // 固定成长值

@property (nonatomic, assign) int pixieLEVEL;           // 等级
@property (nonatomic, assign) CGFloat pixieHPmax;       // 生命值上限 HealthPointMax
@property (nonatomic, assign) CGFloat pixieMPmax;       // 魔法值上限 ManaPointMax
@property (nonatomic, assign) CGFloat pixieAP;          // 基础攻击力 AttackPoint;
@property (nonatomic, assign) CGFloat pixieDP;          // 基础防御力 DefendPoint;
@property (nonatomic, assign) CGFloat pixieDEX;         // 基础闪避值 Dexterity
@property (nonatomic, assign) CGFloat pixieDEF;         // 基础格挡值 Defense

@property (nonatomic, assign) CGFloat currentHP;        // 当前生命值
@property (nonatomic, assign) CGFloat currentMP;        // 当前魔法值
@property (nonatomic, assign) CGFloat currentAP;        // 当前攻击力
@property (nonatomic, assign) CGFloat currentDP;        // 当前防御力
@property (nonatomic, assign) CGFloat currentDEX;       // 当前闪避值
@property (nonatomic, assign) CGFloat currentDEF;       // 当前格挡值

@property (nonatomic) PPElementType pixieElement;       // 宠物的元素属性
@property (nonatomic, assign) int pixieGeneration;      // 第几个进化态
@property (nonatomic, retain) NSArray *pixieSkills;     // 技能
@property (nonatomic, retain) NSArray *pixieBuffs;      // 附加状态
@property (nonatomic) PPBall *pixieBall;                // 小球

-(CGFloat)countPhysicalDamageTo:(PPPixie *)targetPixie;
-(CGFloat)countMagicalDamageTo:(PPPixie *)targetPixie
                     WithSkill:(PPSkill *)usingSkill;

+(PPPixie *)birthPixieWithPetsInfo:(NSDictionary *)petsDict;
+(PPPixie *)birthEnemyPixieWithPetsInfo:(NSDictionary *)petsDict;

@end
