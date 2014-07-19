

#import "PPPetChooseScene.h"

@interface PPPetChooseScene()
@end

@implementation PPPetChooseScene
@synthesize petsArray;
@synthesize passDictInfo;

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        [self setBackTitleText:@"宠物选择" andPositionY:450.0f];
        
        [self setPetsChooseContent];

//        CGFloat sizeFitFor5 = 0.0f;
//        if (CurrentDeviceRealSize.height>500) {
//            sizeFitFor5 = 44.0f;
//        }
//        
//        
//        SKLabelNode *skillNameLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
//        [skillNameLabel setFontSize:20];
//        skillNameLabel.fontColor = [UIColor whiteColor];
//        skillNameLabel.text = @"";
//        skillNameLabel.position = CGPointMake(100.0f,221);
//        [self addChild:skillNameLabel];
//        
//        SKLabelNode *ballsLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
//        [ballsLabel setFontSize:20];
//        ballsLabel.fontColor = [UIColor whiteColor];
////        ballsLabel.text = [NSString stringWithFormat:@"吸收球数:%d",(int)ballsCount];
//        ballsLabel.position = CGPointMake(200.0f,221);
//        [self addChild:ballsLabel];
//        
//        
//        SKAction *action = [SKAction fadeAlphaTo:0.0f duration:5];
//        [skillNameLabel runAction:action];
//        [ballsLabel runAction:action];
//        
//        
//        
//        SKSpriteNode *skillAnimate = [SKSpriteNode spriteNodeWithImageNamed:@"变身效果01000"];
//        skillAnimate.size = CGSizeMake(self.frame.size.width, 242);
//        skillAnimate.position = CGPointMake(0.0f,0.0f);
//        
//        [self addChild:skillAnimate];
//        
//        NSMutableArray *textureNameArray=[[NSMutableArray alloc] init];
//        @synchronized(textureNameArray)
//        {
//            for (int i=1; i <= 43; i++) {
//                NSString *textureName = [NSString stringWithFormat:@"变身效果01%03d.png", i];
//                SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
//                [textureNameArray addObject:temp];
//                
//            }
//        }
//
//        
//        [skillAnimate runAction:[SKAction animateWithTextures:textureNameArray timePerFrame:0.02f]
//                     completion:^{
//                         [self setPetsChooseContent];
//                     }];
//
//        
//        
        
    }
    return self;
}


-(void)coinButton:(NSValue *)valueTmp
{
    
}

-(void)setPetsChooseContent
{
    
    
    
    SKSpriteNode *spriteContent = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(300, 350)];
    spriteContent.name = PP_HURDLE_PETCHOOSE_CONTENT_NAME;
    spriteContent.position = CGPointMake(160.0, 260.0);
    [self addChild:spriteContent];
    
    NSDictionary * dictUserPets = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserPetInfo"
                                                                                                             ofType:@"plist"]];
    NSArray *petsInfoArray = [[NSArray alloc] initWithArray:[dictUserPets objectForKey:@"userpetinfo"]];
    NSInteger petsCount = [petsInfoArray count];
    
    for (int i = 0; i < petsCount; i++) {
        
        PPCustomButton *sprit1 = [PPCustomButton buttonWithSize:CGSizeMake(80.0f, 80.0f)
                                                     andTitle:[[petsInfoArray objectAtIndex:i] objectForKey:@"petname"]
                                                   withTarget:self
                                                 withSelecter:@selector(spriteChooseClick:)];
        sprit1.name = [NSString stringWithFormat:@"%d", PP_PETS_CHOOSE_BTN_TAG + i];
        sprit1.position = CGPointMake(0.0, 100 * (i - 1));
        [spriteContent addChild:sprit1];
    }

    self.petsArray = [NSArray arrayWithArray:petsInfoArray];
    
    SKLabelNode *titilePass = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    titilePass.name = @"eee";
    titilePass.text = @"选择它去战斗吧";
    titilePass.fontSize = 10;
    titilePass.color = [UIColor yellowColor];
    titilePass.fontColor = [UIColor whiteColor];
    titilePass.position = CGPointMake(100.0f,100.0f);
    [spriteContent addChild:titilePass];
    
    
    
}

-(void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
}

-(void)spriteChooseClick:(PPCustomButton *)spriteBtn
{
    
    NSDictionary * petsChoosedInfo = [self.petsArray objectAtIndex:[spriteBtn.name integerValue]-PP_PETS_CHOOSE_BTN_TAG];
    NSDictionary *choosedPet=[NSDictionary dictionaryWithDictionary:petsChoosedInfo];
    // 初始化 ballScene
    PPPixie * playerPixie = [PPPixie birthPixieWithPetsInfo:choosedPet];
    PPPixie * enemyPixie = [PPPixie birthPixieWithPetsInfo:choosedPet];
    
    
    PPBallBattleScene * ballScene = [[PPBallBattleScene alloc] initWithSize:CurrentDeviceRealSize
                                                                PixiePlayer:playerPixie
                                                                 PixieEnemy:enemyPixie];
    
    ballScene->previousScene = self;
    ballScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene:ballScene
                 transition:[SKTransition doorsOpenVerticalWithDuration:0.5f]];
    
    

}

-(void)backButtonClick:(NSString *)backName
{
    [self.view presentScene:previousScene];
}

@end
