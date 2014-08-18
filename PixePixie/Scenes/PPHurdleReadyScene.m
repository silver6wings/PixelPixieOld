
#import "PPHurdleReadyScene.h"

@interface PPHurdleReadyScene ()
{
    int currentEnemyIndex;
}
@property (retain,nonatomic) NSArray *enemysArray;
@property (nonatomic) SKSpriteNode * playerPixie;
@property (nonatomic) NSMutableArray * pixieAnimation;
@end

@implementation PPHurdleReadyScene
@synthesize enemysArray;
@synthesize petsArray;
@synthesize allEnemys;
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        [self setBackTitleText:@"遭遇怪物" andPositionY:450.0f];

    }
    return self;
}
#pragma mark - add current Hurdle

-(void)setEnemysArray
{
    self.enemysArray = [[NSArray alloc] initWithArray:[self.allEnemys objectForKey:@"EnemysInfo"]];

}
-(void)setCurrentHurdle:(int)currentIndex
{
    
    SKNode *contentNode=[self childNodeWithName:PP_HURDLE_READY_CONTENT_NAME];
    if (contentNode!=nil) {
        [contentNode removeFromParent];
    }
    
    SKNode *contentPetChooseNode=[self childNodeWithName:PP_HURDLE_PETCHOOSE_CONTENT_NAME];
    if (contentPetChooseNode!=nil) {
        [contentPetChooseNode removeFromParent];
    }

    
    if ([self.enemysArray count] <= currentIndex)
    {
        NSLog(@"战斗结束，结算奖励");
        
        NSDictionary *dict = @{@"title":@"最后一个怪物死了",
                               @"context":@"副本结束"};
        PPCustomAlertNode *alertCustom = [[PPCustomAlertNode alloc] initWithFrame:CustomAlertFrame];
        [alertCustom showCustomAlertWithInfo:dict];
        [self addChild:alertCustom];
        
        return;
    }
    
    currentEnemyIndex = currentIndex;
    
    
    PPBasicSpriteNode *hurdleReadyContentNode=[[PPBasicSpriteNode alloc] initWithColor:[UIColor purpleColor] size:CGSizeMake(CurrentDeviceRealSize.width, 300)];
    hurdleReadyContentNode.name = PP_HURDLE_READY_CONTENT_NAME;
    [hurdleReadyContentNode setPosition:CGPointMake(160.0f, 240)];
    [self addChild:hurdleReadyContentNode];
    
    
    // 添加己方精灵
    _playerPixie = [SKSpriteNode spriteNodeWithImageNamed:@"变身效果01000"];
    _playerPixie.position = CGPointMake(30.0f,100);
    _playerPixie.size = CGSizeMake(_playerPixie.frame.size.width/3, _playerPixie.frame.size.height/3);
    [hurdleReadyContentNode addChild:_playerPixie];
    
    
    SKLabelNode *statusLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    statusLabel.fontSize = 15;
    statusLabel.fontColor = [UIColor redColor];
    statusLabel.text = [NSString stringWithFormat:@"遭遇怪物: %@ id:%d",[[self.enemysArray objectAtIndex:currentIndex] objectForKey:@"enemyname"],
                        [[[self.enemysArray objectAtIndex:currentIndex] objectForKey:@"enemyId"] intValue]];
    statusLabel.position = CGPointMake(0,
                                      140.0f);
    [hurdleReadyContentNode addChild:statusLabel];
    
    
    // 添加敌方精灵
    SKSpriteNode * enemyPixie = [SKSpriteNode spriteNodeWithImageNamed:@"pixie_plant2_battle1.png"];
    enemyPixie.position = CGPointMake(0.0f,20.0f);
    enemyPixie.size = CGSizeMake(enemyPixie.size.width/2.0f, enemyPixie.size.height/2.0f);
    [hurdleReadyContentNode addChild:enemyPixie];
    SKAction *testAction=[SKAction scaleTo:2.0f duration:1.0f];
    [enemyPixie runAction:testAction];
    [statusLabel runAction:testAction];
    
    
    // 预加载变身动画
    NSMutableArray *texturesArray = [[NSMutableArray alloc] initWithCapacity:44];
    @synchronized(texturesArray)
    {
        
        for (int i = 1; i <= 43; i++) {
            NSString *textureName = [NSString stringWithFormat:@"变身效果01%03d.png", i];
            SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
            [texturesArray addObject:temp];
        }
        
    }
    self.pixieAnimation = [NSMutableArray arrayWithArray:texturesArray];
    
    
    [_playerPixie runAction:[SKAction animateWithTextures:self.pixieAnimation timePerFrame:0.02f]
                 completion:^{
                     
//                     PPSpriteButton *monsterButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(200.0f, 40.0f)];
//                     [monsterButton setLabelWithText:@"choose pet to battle" andFont:[UIFont systemFontOfSize:15] withColor:nil];
//                     monsterButton.position = CGPointMake(0.0f,-120.0f);
//                     monsterButton.name = @"bt_start";
//                     [monsterButton addTarget:self selector:@selector(battleStartButtonClick:) withObject:monsterButton.name forControlEvent:PPButtonControlEventTouchUpInside];
//                     [hurdleReadyContentNode addChild:monsterButton];
                     
                     [self battleStartButtonClick:nil];
                     
                 }];
    
}
-(void)battleStartButtonClick:(NSString *)stringname
{
    
    
//    SKNode *contentNode=[self childNodeWithName:PP_HURDLE_READY_CONTENT_NAME];
//    if (contentNode!=nil) {
//        [contentNode removeFromParent];
//    }
//    
    [self setPetsChooseContent];
    
}
#pragma mark - add a pet choose node

-(void)setPetsChooseContent
{
    
    
    SKSpriteNode *spriteContent = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(320, 100)];
    spriteContent.name = PP_HURDLE_PETCHOOSE_CONTENT_NAME;
    spriteContent.position = CGPointMake(480.0, 45.0);
    [self addChild:spriteContent];
    
    NSDictionary * dictUserPets = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserPetInfo"
                                                                                                             ofType:@"plist"]];
    NSArray *petsInfoArray = [[NSArray alloc] initWithArray:[dictUserPets objectForKey:@"userpetinfo"]];
    NSInteger petsCount = [petsInfoArray count];
    
    for (int i = 0; i < petsCount; i++) {
//        
//        PPSpriteButton *sprit1 = [PPCustomButton buttonWithSize:CGSizeMake(80.0f, 80.0f)
//                                                       andTitle:[[petsInfoArray objectAtIndex:i] objectForKey:@"petname"]
//                                                     withTarget:self
//                                                   withSelecter:@selector(spriteChooseClick:)];
//        
//        
//        sprit1.name = [NSString stringWithFormat:@"%d", PP_PETS_CHOOSE_BTN_TAG + i];
//        sprit1.position = CGPointMake(100 * (i - 1),0.0);
//        [spriteContent addChild:sprit1];
//        
        
        
        PPSpriteButton *petChooseButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(80.0f, 80.0f)];
        [petChooseButton setLabelWithText:[[petsInfoArray objectAtIndex:i] objectForKey:@"petname"] andFont:[UIFont systemFontOfSize:15] withColor:nil];
        petChooseButton.position = CGPointMake(100 * (i - 1),0.0);
        petChooseButton.name = [NSString stringWithFormat:@"%d", PP_PETS_CHOOSE_BTN_TAG + i];
        [petChooseButton addTarget:self selector:@selector(spriteChooseClick:) withObject:petChooseButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [spriteContent addChild:petChooseButton];
        
    }
    
    
    self.petsArray = [NSArray arrayWithArray:petsInfoArray];
    
    
    SKLabelNode *titilePass = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    titilePass.name = @"eee";
    titilePass.text = @"选择它去战斗吧";
    titilePass.fontSize = 15;
    titilePass.color = [UIColor yellowColor];
    titilePass.fontColor = [UIColor whiteColor];
    titilePass.position = CGPointMake(0.0f,-150.0f);
    [spriteContent addChild:titilePass];
    
    
    SKAction *actionMove=[SKAction moveTo:CGPointMake(160.0f, spriteContent.position.y) duration:0.5];
    [spriteContent runAction:actionMove];
    
    
}

-(void)spriteChooseClick:(NSString *)spriteName
{
    
    
    NSDictionary * petsChoosedInfo = [self.petsArray objectAtIndex:[spriteName integerValue]-PP_PETS_CHOOSE_BTN_TAG];
    NSDictionary *choosedPet=[NSDictionary dictionaryWithDictionary:petsChoosedInfo];
    // 初始化 ballScene
    
    
    PPPixie * playerPixie = [PPPixie birthPixieWithPetsInfo:choosedPet];
    PPPixie * enemyPixie = [PPPixie birthEnemyPixieWithPetsInfo:[self.enemysArray objectAtIndex:currentEnemyIndex]];

    
    
    PPBallBattleScene * ballScene = [[PPBallBattleScene alloc] initWithSize:CurrentDeviceRealSize
                                                                PixiePlayer:playerPixie
                                                                 PixieEnemy:enemyPixie];
    ballScene.hurdleReady = self;
    [ballScene setEnemyAtIndex:currentEnemyIndex];
    ballScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene:ballScene
                 transition:[SKTransition doorsOpenVerticalWithDuration:0.5f]];
    
    
}
#pragma mark - add a scroling uiview

- (void)didMoveToView:(SKView *)view
{
    // Called immediately after a scene is presented by a view.
    [super didMoveToView:view];
    [self setBackgroundColor:[UIColor cyanColor]];


}

-(void)startBattle:(PPPixie *)ppsprite
{
    
  
    
    
}

//得到应用程序Documents文件夹下的目标路径
-(NSString *)getPersonalSetTargetPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cahcesPlist = [paths objectAtIndex:0];
    
    return cahcesPlist;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
 
}

-(void)backButtonClick:(NSString *)backName
{
    [self.view presentScene:previousScene transition:[SKTransition doorwayWithDuration:1.0]];
}

@end
