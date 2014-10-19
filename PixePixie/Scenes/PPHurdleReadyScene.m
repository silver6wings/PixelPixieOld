
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
        chooseSceneType = PPElementTypePlant;

    }
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    // Called immediately after a scene is presented by a view.
    [super didMoveToView:view];
    [self setBackgroundColor:[UIColor cyanColor]];
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
    
//    PPBasicSpriteNode *hurdleReadyContentNode=[[PPBasicSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(CurrentDeviceRealSize.width, 480.0f)];
    PPBasicSpriteNode *hurdleReadyContentNode=[[PPBasicSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@_encounter.png",kElementTypeString[chooseSceneType]]]];
    hurdleReadyContentNode.name = PP_HURDLE_READY_CONTENT_NAME;
    [hurdleReadyContentNode setPosition:CGPointMake(160.0f, 240)];
    [self addChild:hurdleReadyContentNode];
    
//    PPBasicSpriteNode *forwardSprite=[[PPBasicSpriteNode alloc] initWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_forward_0000.png",kElementTypeString[chooseSceneType]]]]];
    PPBasicSpriteNode *forwardSprite=[[PPBasicSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@_forward_0000.png",kElementTypeString[chooseSceneType]]]];
    forwardSprite.position = CGPointMake(0.0f, 0.0f);
    [hurdleReadyContentNode addChild:forwardSprite];
    
    
    
    NSMutableArray *texturesArray = [[NSMutableArray alloc] initWithCapacity:44];
    @synchronized(texturesArray)
    {
        
        for (int i = 0; i < 20; i++) {
            NSString * textureName =
            [NSString stringWithFormat:@"%@_forward_%04d.png", kElementTypeString[chooseSceneType],i];
            SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
            [texturesArray addObject:temp];
        }
        
    }
    
    [forwardSprite runAction:[SKAction animateWithTextures:texturesArray timePerFrame:kFrameInterval]
                  completion:^{
        [forwardSprite removeFromParent];
        [self addChangeStatus:hurdleReadyContentNode];
    }];
    
//    // 添加己方精灵
//    _playerPixie = [SKSpriteNode spriteNodeWithImageNamed:@"变身效果01000"];
//    _playerPixie.position = CGPointMake(30.0f,100);
//    _playerPixie.size = CGSizeMake(_playerPixie.frame.size.width/3, _playerPixie.frame.size.height/3);
//    [hurdleReadyContentNode addChild:_playerPixie];
//    
//    
//    SKLabelNode *statusLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
//    statusLabel.fontSize = 15;
//    statusLabel.fontColor = [UIColor redColor];
//    statusLabel.text = [NSString stringWithFormat:@"遭遇怪物: %@ id:%d",[[self.enemysArray objectAtIndex:currentIndex] objectForKey:@"enemyname"],
//                        [[[self.enemysArray objectAtIndex:currentIndex] objectForKey:@"enemyId"] intValue]];
//    statusLabel.position = CGPointMake(0,
//                                      140.0f);
//    [hurdleReadyContentNode addChild:statusLabel];
//    
//    
//    // 添加敌方精灵
//    SKSpriteNode * enemyPixie = [SKSpriteNode spriteNodeWithImageNamed:@"pixie_plant2_battle1.png"];
//    enemyPixie.position = CGPointMake(0.0f,20.0f);
//    enemyPixie.size = CGSizeMake(enemyPixie.size.width/2.0f, enemyPixie.size.height/2.0f);
//    [hurdleReadyContentNode addChild:enemyPixie];
//    SKAction *testAction=[SKAction scaleTo:2.0f duration:1.0f];
//    [enemyPixie runAction:testAction];
//    [statusLabel runAction:testAction];
    
    

}
-(void)addChangeStatus:(PPBasicSpriteNode *)contentSprite
{
    
    // 添加己方精灵
    _playerPixie = [SKSpriteNode spriteNodeWithImageNamed:@"fire_shield_cast_0000.png"];
    _playerPixie.position = CGPointMake(0.0f,0.0f);
    _playerPixie.size = CGSizeMake(320.0f, 480.0f);
    [contentSprite addChild:_playerPixie];
 //预加载变身动画
    
    
    NSMutableArray *texturesArray = [[NSMutableArray alloc] initWithCapacity:44];
    @synchronized(texturesArray)
    {
        
        for (int i = 0; i < 27; i++) {
            NSString *textureName = [NSString stringWithFormat:@"fire_shield_cast_00%02d.png", i];
            SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
            [texturesArray addObject:temp];
        }
        
    }
    self.pixieAnimation = [NSMutableArray arrayWithArray:texturesArray];
    
    
    [_playerPixie runAction:[SKAction animateWithTextures:self.pixieAnimation timePerFrame:0.02f]
                 completion:^{
                     [_playerPixie removeFromParent];
                     _playerPixie = nil;
                     [self setPetsChooseContent];
                 }];
}
#pragma mark - add a pet choose node

-(void)setPetsChooseContent
{
    PPBasicSpriteNode *enemyNode = [[PPBasicSpriteNode alloc] init];
    [enemyNode setSize:CGSizeMake(125.0f, 125.0f)];
    [enemyNode setPosition:CGPointMake(self.size.width/2.0f, self.size.height/2.0f)];
    [enemyNode setTexture:[[TextureManager pixie_info] textureNamed:[NSString stringWithFormat:@"%@3_encounter",kElementTypeString[chooseSceneType]]]];
    [self addChild:enemyNode];

    
    SKSpriteNode *spriteContent = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(320, 100)];
    spriteContent.name = PP_HURDLE_PETCHOOSE_CONTENT_NAME;
    spriteContent.position = CGPointMake(160.0, -50.0);
    [self addChild:spriteContent];
    
    NSDictionary * dictUserPets = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserPetInfo"
                                                                                                             ofType:@"plist"]];
    NSArray *petsInfoArray = [[NSArray alloc] initWithArray:[dictUserPets objectForKey:@"userpetinfo"]];
    NSInteger petsCount = [petsInfoArray count];
    
    for (int i = 0; i < petsCount; i++) {

        PPSpriteButton *petChooseButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(80.0f, 80.0f)];
        [petChooseButton setLabelWithText:[[petsInfoArray objectAtIndex:i] objectForKey:@"petname"] andFont:[UIFont systemFontOfSize:15] withColor:nil];
        petChooseButton.position = CGPointMake(100 * (i - 1),0.0);
        petChooseButton.name = [NSString stringWithFormat:@"%d", PP_PETS_CHOOSE_BTN_TAG + i];
        [petChooseButton addTarget:self selector:@selector(spriteChooseClick:) withObject:petChooseButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [spriteContent addChild:petChooseButton];
        
    }
    
//    NSString *string[2]={@"木系场景", @"火系场景"};
//    
//    for (int i = 0; i < 2; i++) {
//        
//        PPSpriteButton *sceneTypeChooseButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(80.0f, 80.0f)];
//        [sceneTypeChooseButton setLabelWithText:string[i] andFont:[UIFont systemFontOfSize:15] withColor:nil];
//        sceneTypeChooseButton.position = CGPointMake(100 * (i - 1),200.0);
//        sceneTypeChooseButton.name =[NSString stringWithFormat:@"%d",i];
//        if (i==0) {
//            sceneTypeChooseButton.color = [UIColor blueColor];
//        }
//        [sceneTypeChooseButton addTarget:self selector:@selector(sceneChooseClick:) withObject:sceneTypeChooseButton forControlEvent:PPButtonControlEventTouchUpInside];
//        [spriteContent addChild:sceneTypeChooseButton];
//        
//    }
    
    
    
    
    self.petsArray = [NSArray arrayWithArray:petsInfoArray];
    
    SKLabelNode *titilePass = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    titilePass.name = @"eee";
    titilePass.text = @"选择它去战斗吧";
    titilePass.fontSize = 15;
    titilePass.color = [UIColor yellowColor];
    titilePass.fontColor = [UIColor whiteColor];
    titilePass.position = CGPointMake(0.0f,-150.0f);
    [spriteContent addChild:titilePass];
    
    // 显示精灵选择菜单
    SKAction * actionMove=[SKAction moveTo:CGPointMake(160.0, 50) duration:0.5];
    [spriteContent runAction:actionMove];
}
-(void)sceneChooseClick:(PPSpriteButton *)btn
{
    
    PPBasicSpriteNode *contentSprite= (PPBasicSpriteNode *)[self childNodeWithName:PP_HURDLE_PETCHOOSE_CONTENT_NAME];
    
    for (int i=0;i<5;i++) {
        PPSpriteButton *btnObj=(PPSpriteButton *)[contentSprite childNodeWithName:[NSString stringWithFormat:@"%d",i]];
        if (btnObj == btn) {
            btnObj.color = [UIColor blueColor];
        }else
        {
            btnObj.color = [UIColor orangeColor];

        }
        
    }
    
    switch ([btn.name intValue]) {
        case 0:
        {
            
            chooseSceneType = PPElementTypePlant;
        }
            break;
        case 1:
        {
            chooseSceneType = PPElementTypeFire;

        }
            break;
            
        default:
            break;
    }
    
}
-(void)spriteChooseClick:(NSString *)spriteName
{

    
    NSDictionary * petsChoosedInfo = [self.petsArray objectAtIndex:[spriteName integerValue]-PP_PETS_CHOOSE_BTN_TAG];
    NSDictionary *choosedPet = [NSDictionary dictionaryWithDictionary:petsChoosedInfo];
    
    // 初始化 ballScene
    PPPixie * playerPixie = [PPPixie birthPixieWithPetsInfo:choosedPet];
    PPPixie * enemyPixie = [PPPixie birthEnemyPixieWithPetsInfo:[self.enemysArray objectAtIndex:currentEnemyIndex]];
    if (playerPixie == nil || enemyPixie == nil) return;
    
    
    
    // 创建战斗场景并显示
    PPBallBattleScene * ballScene = [[PPBallBattleScene alloc] initWithSize:CurrentDeviceRealSize
                                                                PixiePlayer:playerPixie
                                                                 PixieEnemy:enemyPixie  andSceneType:chooseSceneType];
    
    ballScene.scaleMode = SKSceneScaleModeAspectFill;
    ballScene.hurdleReady = self;
    [ballScene setEnemyAtIndex:currentEnemyIndex];
    [self.view presentScene:ballScene];
}

#pragma mark - add a scroling uiview




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
    [self.view presentScene:previousScene];
}

@end
