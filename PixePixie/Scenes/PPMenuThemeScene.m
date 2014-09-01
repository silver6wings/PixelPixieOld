
#import "PPMenuThemeScene.h"
#import "PPNodes.h"

@implementation PPMenuThemeScene

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [UIColor blueColor];
        [self setBackTitleText:@"世界地图" andPositionY:450.0f];
        
        
        for (int i = 0; i < 3; i++) {
            
          PPSpriteButton *  passButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(80, 80)];
            
            switch (i) {
                case 0:
                {
                    [passButton setLabelWithText:[NSString stringWithFormat:@"场景 %d",i+1] andFont:[UIFont systemFontOfSize:15] withColor:nil];
                    passButton.position = CGPointMake(80.0f,80.0f);
                }
                    break;
                case 1:
                {
                    [passButton setLabelWithText:[NSString stringWithFormat:@"场景 %d",i+1] andFont:[UIFont systemFontOfSize:15] withColor:nil];
                    
                    passButton.position = CGPointMake(120.0f,380.0f);
                }
                    
                    break;
                case 2:
                {
                    [passButton setLabelWithText:[NSString stringWithFormat:@"场景 %d",i+1] andFont:[UIFont systemFontOfSize:15] withColor:nil];
                    
                    passButton.position = CGPointMake(220.0f,180.0f);
                }
                    
                    break;
                    
                default:
                    break;
            }
            passButton.name = [NSString stringWithFormat:@"%d",i+PP_PASSNUM_CHOOSE_TABLE_TAG];
            [passButton addTarget:self selector:@selector(passChoose:) withObject:passButton.name forControlEvent:PPButtonControlEventTouchUpInside];
            [self addChild:passButton];
        }
    }
    return self;
}

-(void)backButtonClick:(NSString *)backName
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PP_BACK_TO_MAIN_VIEW object:PP_BACK_TO_MAIN_VIEW_FIGHTING];
}

-(void)passChoose:(NSString *)passchoose
{
        NSDictionary *dictPassInfo = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PassInfo"
                                                                                                                ofType:@"plist"]];
        NSArray *passArray = [[NSArray alloc] initWithArray:[dictPassInfo objectForKey:@"transcriptinfo"]];
        
        NSInteger passCount = [passArray count];
        NSInteger index = [passchoose integerValue]-PP_PASSNUM_CHOOSE_TABLE_TAG;
        NSDictionary *passDictInfo = nil;
        if (passCount > index) {
            passDictInfo=[NSDictionary dictionaryWithDictionary:[passArray objectAtIndex:index]];
        }
        
        PPMenuDungeonScene * menuDungeonScene = [[PPMenuDungeonScene alloc] initWithSize:self.view.bounds.size];
        menuDungeonScene.passDictInfo=passDictInfo;
        menuDungeonScene->previousScene=self;
        menuDungeonScene.scaleMode = SKSceneScaleModeAspectFill;
    
        [self.view presentScene:menuDungeonScene];
}

@end
