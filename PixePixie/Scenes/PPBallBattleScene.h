
#import "PPSkillNode.h"
#import "PPCustomAlertNode.h"

@interface PPBallBattleScene : PPBasicScene <SkillShowEndDelegate>
{
    @public
    int currentEnemyIndex;
}

-(id)initWithSize:(CGSize)size
      PixiePlayer:(PPPixie *)pixieA
       PixieEnemy:(PPPixie *)pixieB;
-(void)setEnemyAtIndex:(int)index;
@end
