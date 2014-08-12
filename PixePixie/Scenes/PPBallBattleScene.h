
#import "PPSkillNode.h"
#import "PPCustomAlertNode.h"
@class PPHurdleReadyScene;
@interface PPBallBattleScene : PPBasicScene <SkillShowEndDelegate>
{
    
    int roundIndex;
    BOOL roundRuning;
    int roundActionNum;
    
    int enemyCombos; //怪物连击数
    int petCombos;  //宠物连击数
    
    
    int petAssimSameEleNum;   //宠物吸收己方元素球个数
    int petAssimDiffEleNum;   //宠物吸收敌方方元素球个数
    int enemyAssimSameEleNum; //怪物吸收怪物方元素球个数
    int enemyAssimDiffEleNum; //怪物吸收宠物方元素球个数
    
    
    
    CGFloat interCoefficient;  //怪物与宠物之间属性关系
    
    @public
    int currentEnemyIndex;
    
    
}
@property(strong)PPHurdleReadyScene *hurdleReady;
-(id)initWithSize:(CGSize)size
      PixiePlayer:(PPPixie *)pixieA
       PixieEnemy:(PPPixie *)pixieB;
-(void)setEnemyAtIndex:(int)index;
@end
