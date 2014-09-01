#import "PPMenuDungeonScene.h"
@interface PPMenuDungeonScene()
{
    PPHurdleReadyScene * battleScene;
}
@end

@implementation PPMenuDungeonScene
@synthesize passDictInfo;

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        
        
        [self setBackTitleText:@"小场景推进" andPositionY:450.0f];
        
        
        [self addPassChoose];

        
        
        [self setBackgroundColor:[UIColor purpleColor]];
    
    }
    return self;
}

-(void)introduceInfoLabel:(NSString *)text
{
    
    PPBasicSpriteNode *enemyDeadContent=[[PPBasicSpriteNode alloc] initWithColor:[UIColor orangeColor] size:CGSizeMake(320, 350)];
    [enemyDeadContent setPosition:CGPointMake(160.0f, 200.0f)];
    [self addChild:enemyDeadContent];
    
    
    
    PPBasicLabelNode *labelNode=(PPBasicLabelNode *)[self childNodeWithName:@"RoundLabel"];
    if (labelNode) {
        [labelNode removeFromParent];
    }
    
    
    PPBasicLabelNode *additonLabel= [[PPBasicLabelNode alloc] init];
    additonLabel.name  = @"titleLabel";
    additonLabel.fontColor = [UIColor redColor];
    additonLabel.position = CGPointMake(0.0f, 100.0f);
    [additonLabel setText:text];
    [enemyDeadContent addChild:additonLabel];
    
    
    
    PPBasicLabelNode *infoContentLabel= [[PPBasicLabelNode alloc] init];
    infoContentLabel.name  = @"contentLabel";
    infoContentLabel.fontColor = [UIColor redColor];
    infoContentLabel.position = CGPointMake(0.0f, 0.0f);
    [infoContentLabel setText:@"介绍内容"];
    [enemyDeadContent addChild:infoContentLabel];
    
    
    PPSpriteButton *  confirmButton = [PPSpriteButton buttonWithColor:[UIColor blueColor] andSize:CGSizeMake(90, 60)];
    
    [confirmButton setLabelWithText:@"知道了" andFont:[UIFont systemFontOfSize:15] withColor:nil];
    confirmButton.position = CGPointMake(0.0f,-100.0f);

    [confirmButton addTarget:self selector:@selector(confirmBtnClick:) withObject:enemyDeadContent forControlEvent:PPButtonControlEventTouchUpInside];
    [enemyDeadContent addChild:confirmButton];
    
    
    
    
//    SKAction *actionScale = [SKAction scaleBy:2.0 duration:1];
//    [additonLabel runAction:actionScale completion:^{
//        [additonLabel removeFromParent];
//        [self addPassChoose];
//    }];
    
}
-(void)confirmBtnClick:(PPBasicSpriteNode *)contentNode
{
    
    if (contentNode != nil) {
        [contentNode removeFromParent];
        contentNode = nil;
    }
    

   
}
-(void)addPassChoose
{
    for (int i = 0; i < 5; i++) {
        PPSpriteButton *  passButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(90, 60)];
        
        [passButton setLabelWithText:[NSString stringWithFormat:@"副本 %d",5-i] andFont:[UIFont systemFontOfSize:15] withColor:nil];
        passButton.position = CGPointMake(160.0f,i*70+60);
        passButton.name = [NSString stringWithFormat:@"%d",i+PP_SECONDARY_PASSNUM_BTN_TAG];
        [passButton addTarget:self selector:@selector(menuDungeonGoForward:) withObject:passButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:passButton];
        
        
        
        PPSpriteButton *  passIntroduceButton = [PPSpriteButton buttonWithColor:[UIColor redColor] andSize:CGSizeMake(30, 30)];
        [passIntroduceButton setLabelWithText:[NSString stringWithFormat:@"%d信息",5-i] andFont:[UIFont systemFontOfSize:11] withColor:nil];
        passIntroduceButton.position = CGPointMake(passButton.position.x+60.0f,passButton.position.y+15.0f);
        passIntroduceButton.name = [NSString stringWithFormat:@"副本%d介绍",5-i];
        [passIntroduceButton addTarget:self selector:@selector(introduceInfoLabel:) withObject:passIntroduceButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:passIntroduceButton];
        
        
        
    }
    
}

-(void)secondaryPassChoose:(NSString *)stringname
{
}

-(void)menuDungeonGoForward:(NSString *)stringName
{
    PPBasicSpriteNode *goForwardContent=[[PPBasicSpriteNode alloc] initWithColor:[UIColor darkGrayColor] size:CGSizeMake(320.0f, 360)];
    goForwardContent.name = PP_GOFORWARD_MENU_DUNGEON_FIGHTING;
    [goForwardContent setPosition:CGPointMake(160.0f, 200.0f)];
    [self addChild:goForwardContent];
    
    SKLabelNode *skillNameLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [skillNameLabel setFontSize:20];
    skillNameLabel.fontColor = [UIColor whiteColor];
    skillNameLabel.text = @"场景推进动画";
    skillNameLabel.position = CGPointMake(0.0f,151);
    [goForwardContent addChild:skillNameLabel];
    
    SKLabelNode *ballsLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [ballsLabel setFontSize:20];
    ballsLabel.fontColor = [UIColor whiteColor];
    ballsLabel.text = [NSString stringWithFormat:@"小场景:%@",stringName];
    ballsLabel.position = CGPointMake(100.0f,121);
    [goForwardContent addChild:ballsLabel];
    
//    SKAction *action = [SKAction fadeAlphaTo:0.0f duration:5];
//    [skillNameLabel runAction:action];
//    [ballsLabel runAction:action];
    
    SKSpriteNode *skillAnimate = [SKSpriteNode spriteNodeWithImageNamed:@"变身效果01000"];
    skillAnimate.size = CGSizeMake(self.frame.size.width, 240);
    skillAnimate.position = CGPointMake(0.0f,0.0f);
    
    [goForwardContent addChild:skillAnimate];
    
    NSMutableArray *textureNameArray=[[NSMutableArray alloc] init];
    @synchronized(textureNameArray)
    {
        for (int i=1; i <= 43; i++) {
            NSString *textureName = [NSString stringWithFormat:@"变身效果01%03d.png", i];
            SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
            [textureNameArray addObject:temp];
            
        }
    }
    
    [skillAnimate runAction:[SKAction animateWithTextures:textureNameArray timePerFrame:0.02f]
                 completion:^{
                 [self enterHurdleReady];
                 }];
}

-(void)enterHurdleReady
{
    SKNode *spriteNode=[self childNodeWithName:PP_GOFORWARD_MENU_DUNGEON_FIGHTING];
    if (spriteNode) {
        [spriteNode removeFromParent];
    }
    NSDictionary * dictEnemy = [NSDictionary dictionaryWithContentsOfFile:
                                [[NSBundle mainBundle]pathForResource:@"EnemyInfo" ofType:@"plist"]];
    
//    PPHurdleReadyScene * battleScene = [[PPHurdleReadyScene alloc] initWithSize:self.view.bounds.size];
//    battleScene.allEnemys = dictEnemy;
//    battleScene->previousScene = self;
//    [battleScene setEnemysArray];
//    [battleScene setCurrentHurdle:0];
    
    battleScene = [[PPHurdleReadyScene alloc] initWithSize:self.view.bounds.size];
    battleScene.allEnemys = dictEnemy;
    battleScene->previousScene = self;
    [battleScene setEnemysArray];
    [battleScene setCurrentHurdle:0];
    [self.view presentScene:battleScene];
}

-(void)backButtonClick:(NSString *)backName
{
    [self.view presentScene:previousScene];
}

@end
