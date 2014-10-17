#import "PPPixie.h"

@implementation PPPixie

@synthesize pixieName;
@synthesize pixieStatus;
@synthesize pixieSatiation;
@synthesize pixieIntimate;
@synthesize pixieGP;

@synthesize pixieLEVEL;     // 战斗等级
@synthesize pixieHPmax;     // 生命值上限 HealthPointMax
@synthesize pixieMPmax;     // 魔法值上限 ManaPointMax
@synthesize pixieAP;        // 攻击力 AttackPoint;
@synthesize pixieDP;        // 防御力 DefendPoint;
@synthesize pixieDEX;       // 闪避值 Dexterity
@synthesize pixieDEF;       // 格挡值 Defense

@synthesize currentHP;      // 当前生命值 HitPoint
@synthesize currentMP;      // 当前魔法值 ManaPoint
@synthesize currentAP;      // 当前攻击力 AttackPoint;
@synthesize currentDP;      // 当前防御力 DefendPoint;
@synthesize currentDEX;     // 当前闪避值 Dexterity
@synthesize currentDEF;     // 当前防御  Defense

@synthesize pixieElement;
@synthesize pixieGeneration;
@synthesize pixieSkills;
@synthesize pixieBuffs;
@synthesize pixieBall;


// 物理攻击伤害计算
-(CGFloat)countPhysicalDamageTo:(PPPixie *)targetPixie
{
    return 600;
}

// 技能伤害计算
-(CGFloat)countMagicalDamageTo:(PPPixie *)targetPixie
                     WithSkill:(PPSkill *)usingSkill
{
    return 350;
}

// 创建新的宠物
+(PPPixie *)birthPixieWithPetsInfo:(NSDictionary *)petsDict
{
    PPPixie * tPixie = [[PPPixie alloc] init];
    
    tPixie.pixieHPmax = 1000*[[petsDict objectForKey:@"petstatus"] intValue];
    tPixie.pixieMPmax = 1000*[[petsDict objectForKey:@"petstatus"] intValue];
    tPixie.pixieName = [petsDict objectForKey:@"petname"];
    tPixie.currentHP = tPixie.pixieHPmax;
    NSLog(@"currentHP=%f hpmax=%f",tPixie.currentHP,tPixie.pixieHPmax);
    
    tPixie.currentMP = 0.0f;
    
    tPixie.currentAP = 10;
    tPixie.currentDP = 1;
    tPixie.pixieGeneration = [[petsDict objectForKey:@"petstatus"] intValue];
    
    tPixie.pixieElement = [[petsDict objectForKey:@"petelementtype"] intValue];
    tPixie.pixieSkills = [NSArray arrayWithArray:[petsDict objectForKey:@"pixieSkills"]];
    tPixie.pixieBuffs = [[NSArray alloc] initWithObjects:@"buff1",@"buff2",@"buff3", nil];
    tPixie.pixieBall = [PPBall ballWithPixie:tPixie];
    
    return tPixie;
}

// 创建新的敌方宠物
+(PPPixie *)birthEnemyPixieWithPetsInfo:(NSDictionary *)petsDict;
{
    PPPixie * tPixie = [[PPPixie alloc] init];
    
    tPixie.pixieHPmax = 1000*[[petsDict objectForKey:@"enemystatus"] intValue];
    tPixie.pixieMPmax = 1000*[[petsDict objectForKey:@"enemystatus"] intValue];
    tPixie.pixieName = [petsDict objectForKey:@"enemyname"];
    tPixie.currentHP = tPixie.pixieHPmax;
    tPixie.currentMP = 0.0f;
    tPixie.pixieAP = 10;
    tPixie.pixieDP = 1;
    tPixie.pixieGeneration = [[petsDict objectForKey:@"enemystatus"] intValue];
    tPixie.pixieBall.ballElementType = [[petsDict objectForKey:@"enemyelementtype"] intValue];
    tPixie.pixieElement = [[petsDict objectForKey:@"enemyelementtype"] intValue];
    tPixie.pixieSkills = [NSArray arrayWithArray:[petsDict objectForKey:@"enemySkills"]];
    
    tPixie.pixieBuffs = [[NSArray alloc] initWithObjects:@"buff1",@"buff2",@"buff3", nil];
    tPixie.pixieBall = [PPBall ballWithPixieEnemy:tPixie];
    
    return tPixie;
}

@end
