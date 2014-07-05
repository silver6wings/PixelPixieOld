
#import "PPEnemyPixie.h"

@implementation PPEnemyPixie
@synthesize pixieSatiation;
@synthesize pixieName;
@synthesize pixieIntimate;
@synthesize pixieLEVEL;


@synthesize currentHP;      // 当前生命值
@synthesize pixieHPmax;   // 生命值上限 HealthPointMax
@synthesize currentMP;      // 魔法值 ManaPoint
@synthesize pixieMPmax;   // 魔法值上限 ManaPointMax
@synthesize pixieAPmax;      // 攻击力 AttackPoint;
@synthesize currentAP;      // 当前攻击力 AttackPoint;
@synthesize pixieDPmax;      // 防御力 DefendPoint;
@synthesize currentDP;      // 当前防御力 DefendPoint;
@synthesize pixieDEXmax;     // 闪避值 Dexterity
@synthesize currentDEX;     // 当前闪避值 Dexterity
@synthesize pixieDEFmax; // 防御  Defense
@synthesize currentDEF;  // 当前防御  Defense


@synthesize pixieGeneration;
@synthesize pixieElement;
@synthesize pixieBuffAgg;
@synthesize pixieSkills;
@synthesize pixieBall;
// 创建新的怪物
+(PPEnemyPixie *)birthEnemyPixieWithPetsInfo:(NSDictionary *)petsDict;
{
    
    PPEnemyPixie * tPixie = [[PPEnemyPixie alloc] init];
    
    tPixie.pixieHPmax = 1000*[[petsDict objectForKey:@"enemystatus"] intValue];
    tPixie.pixieMPmax = 1000*[[petsDict objectForKey:@"enemystatus"] intValue];
    tPixie.pixieName = [petsDict objectForKey:@"enemyname"];
    tPixie.currentHP = tPixie.pixieHPmax;
    tPixie.currentMP = tPixie.pixieMPmax;
    tPixie.pixieAPmax = 10;
    tPixie.pixieDPmax = 1;
    tPixie.pixieGeneration = [[petsDict objectForKey:@"enemystatus"] intValue];
    
    tPixie.pixieElement = [[petsDict objectForKey:@"enemytype"] intValue];
    tPixie.pixieSkills = [NSArray arrayWithArray:[petsDict objectForKey:@"enemySkills"]];
    
    #warning 这里到时候再说
    tPixie.pixieBuffAgg = [[PPBuff alloc] init];
    tPixie.pixieBall = [PPBall ballWithEnemyPixie:tPixie];
    
    return tPixie;
}


@end
