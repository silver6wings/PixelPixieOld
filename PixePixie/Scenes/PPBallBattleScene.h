
#import "PPSkillNode.h"
#import "PPCustomAlertNode.h"
@class PPHurdleReadyScene;
@interface PPBallBattleScene : PPBasicScene <SkillShowEndDelegate>
{
    
    int roundIndex;
    BOOL roundRuning;
    int roundActionNum;
    int enemyCombos;
    int petCombos;
    CGFloat interCoefficient;
   
    
    
    @public
    int currentEnemyIndex;
    
}
@property(strong)PPHurdleReadyScene *hurdleReady;
-(id)initWithSize:(CGSize)size
      PixiePlayer:(PPPixie *)pixieA
       PixieEnemy:(PPPixie *)pixieB;
-(void)setEnemyAtIndex:(int)index;
@end
