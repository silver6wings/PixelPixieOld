
#import "PPSkillNode.h"

@class PPHurdleReadyScene;

@interface PPBallBattleScene : PPBasicScene < SkillShowEndDelegate >
{
    int roundIndex;
    int roundActionNum;
    BOOL roundRuning;
    
    int enemyCombos;    // 怪物连击数
    int petCombos;      // 宠物连击数
    
    int petAssimSameEleNum;     // 宠物吸收己方元素球个数
    int petAssimDiffEleNum;     // 宠物吸收敌方方元素球个数
    int enemyAssimSameEleNum;   // 怪物吸收怪物方元素球个数
    int enemyAssimDiffEleNum;   // 怪物吸收宠物方元素球个数
    int currentPhysicsAttack;   // 当前攻击方的标记 1：玩家攻击 2：敌方攻击
    
    CGFloat interCoefficient;   // 宠物与对手之间属性克制关系
@public
    int currentEnemyIndex;
}

@property(strong) PPHurdleReadyScene *hurdleReady;
/**
 * @brief 初始化场景
 * @param pixieA 我方战斗宠物
 * @param pixieB 敌方战斗宠物
 * @param sceneType 战斗场景类型
 */
-(id)initWithSize:(CGSize)size
      PixiePlayer:(PPPixie *)pixieA
       PixieEnemy:(PPPixie *)pixieB
     andSceneType:(PPElementType)sceneType;
/**
 * @brief 设置本次战斗怪物。
 */
-(void)setEnemyAtIndex:(int)index;

-(void)physicsAttackAnimationEnd:(NSString *)stringSide;
/**
 * @brief 移除buff显示
 * @param buffToRemove 需要移除的buff
 * @param stringSide 标记哪一方的buff 敌方或者我方
 */
-(void)removeBuff:(PPBuff *)buffToRemove andSide:(NSString *)stringSide;

@end
