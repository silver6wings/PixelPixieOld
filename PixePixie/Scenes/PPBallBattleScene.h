
#import "PPSkillNode.h"
#import "PPCustomAlertNode.h"

@interface PPBallBattleScene : PPBasicScene <SkillShowEndDelegate>
{
    int currentEnemyIndex;
}

@property (nonatomic,retain)NSArray *choosedEnemys;

-(id)initWithSize:(CGSize)size
           PixieA:(PPPixie *)pixieA
           PixieB:(NSArray *)enemyS;

@end
