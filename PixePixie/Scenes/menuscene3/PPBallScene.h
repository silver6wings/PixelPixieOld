#import "PPSkillNode.h"
@interface PPBallScene : PPBasicScene<SkillShowEndDelegate>

-(id)initWithSize:(CGSize)size
           PixieA:(PPPixie *)pixieA
           PixieB:(PPEnemyPixie *)pixieB;

@end
