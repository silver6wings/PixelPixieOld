

#import "PPDamageCaculate.h"

static PPDamageCaculate *skillCaculate = nil;

@implementation PPDamageCaculate

+ (instancetype)getInstance
{
    @synchronized([PPDamageCaculate class]){
        if(skillCaculate == nil){
            skillCaculate = [[PPDamageCaculate alloc] init];
        }
    }
    return skillCaculate;
}

// 物理攻击计算方法
- (CGFloat)bloodChangeForPhysicalAttack:(CGFloat)attackValue
                            andAddition:(CGFloat)attValueAddition
                     andOppositeDefense:(CGFloat)defValue
                 andOppositeDefAddition:(CGFloat)defAddition
                           andDexterity:(CGFloat)dexterity{
    
    return -200.0f;
}

// 普通球攻击地方宠物减少的血量
-(CGFloat)bloodChangeForBallAttack:(BOOL)targetDirection
                            andPet:(PPPixie *)petPixie
                          andEnemy:(PPPixie *)enemyPixie{
    
    return -300.0f;
}

@end
