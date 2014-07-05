
#import "PPSkillCaculate.h"

static PPSkillCaculate *skillCaculate = nil;

@implementation PPSkillCaculate

+ (instancetype)getInstance
{
    @synchronized([PPSkillCaculate class])
    {
        if(skillCaculate == nil)
        {
            skillCaculate = [[PPSkillCaculate alloc] init];
        }
    }
    return skillCaculate;
}

#warning 写注释啊亲，我看不懂
// 这里在向你招手
- (CGFloat)bloodChangeForPhysicalAttack:(CGFloat)attackValue
                            andAddition:(CGFloat)attValueAddition
                     andOppositeDefense:(CGFloat)defValue
                 andOppositeDefAddition:(CGFloat)defAddition
                           andDexterity:(CGFloat)dexterity
{
    return -200.0f;
}

#warning 跟上边一样
// 这里也在向你招手
-(CGFloat)bloodChangeForBallAttack:(BOOL)targetDirection
                            andPet:(PPPixie * )petPixie
                          andEnemy:(PPEnemyPixie *)enemyPixie
{
    return -300.0f;
}


@end
