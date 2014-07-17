
#import "PPSkillNode.h"
#import "PPCustomAlertNode.h"

@interface PPBallBattleScene : PPBasicScene <SkillShowEndDelegate>
{
    int currentEnemyIndex;
}

-(id)initWithSize:(CGSize)size
      PixiePlayer:(PPPixie *)pixieA
       PixieEnemy:(PPPixie *)pixieB;

@end
