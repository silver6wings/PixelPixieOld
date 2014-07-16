

#import "PPDamageCaculate.h"


@implementation PPDamageCaculate

// 物理攻击计算方法
+ (CGFloat)bloodChangeForPhysicalAttack:(CGFloat)attackValue
                            andAddition:(CGFloat)attValueAddition
                     andOppositeDefense:(CGFloat)defValue
                 andOppositeDefAddition:(CGFloat)defAddition
                           andDexterity:(CGFloat)dexterity{
    
    return -200.0f;
}

// 普通球攻击地方宠物减少的血量
+(CGFloat)bloodChangeForBallAttack:(BOOL)targetDirection
                            andPet:(PPPixie *)petPixie
                          andEnemy:(PPPixie *)enemyPixie{
    
    return -300.0f;
}

@end
