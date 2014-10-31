
#import "PPHurdleReadyScene.h"

@interface PPHurdleReadyScene ()
{
    int currentEnemyIndex;
}
@property (nonatomic, retain) NSArray * enemysArray;
@property (nonatomic) NSMutableArray * pixieAnimation;
@property (nonatomic) SKSpriteNode * playerPixie;
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
    [super didMoveToView:view];
}


#pragma mark - add current Hurdle

//
-(void)setEnemysArray
{
    self.enemysArray = [[NSArray alloc] initWithArray:[self.allEnemys objectForKey:@"EnemysInfo"]];
}

//
-(void)setCurrentHurdle:(int)currentIndex
{
    SKNode *contentNode = [self childNodeWithName:PP_HURDLE_READY_CONTENT_NAME];
    if (contentNode != nil) {
        [contentNode removeFromParent];
    }
    
    SKNode *contentPetChooseNode = [self childNodeWithName:PP_HURDLE_PETCHOOSE_CONTENT_NAME];
    if (contentPetChooseNode != nil) {
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
    
//    SKSpriteNode *hurdleReadyContentNode=[[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(CurrentDeviceRealSize.width, 480.0f)];
    SKSpriteNode *hurdleReadyContentNode=[[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@_encounter.png",kElementTypeString[chooseSceneType]]]];
    hurdleReadyContentNode.name = PP_HURDLE_READY_CONTENT_NAME;
    [hurdleReadyContentNode setSize:CGSizeMake(320.0f, 480.0f)];
    [hurdleReadyContentNode setPosition:CGPointMake(160.0f, 240)];
    [self addChild:hurdleReadyContentNode];
    
//    SKSpriteNode *forwardSprite=[[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_forward_0000.png",kElementTypeString[chooseSceneType]]]]];
    SKSpriteNode *forwardSprite=[[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@_forward_0000.png",kElementTypeString[chooseSceneType]]]];
    forwardSprite.position = CGPointMake(0.0f, 0.0f);
    [hurdleReadyContentNode addChild:forwardSprite];
    
    NSMutableArray * texturesArray = [[NSMutableArray alloc] initWithCapacity:44];
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
//        [forwardSprite removeFromParent];
        [self addChangeStatus:hurdleReadyContentNode];
    }];
}

-(void)addChangeStatus:(SKSpriteNode *)contentSprite
{
    // 添加己方精灵
    _playerPixie = [SKSpriteNode spriteNodeWithImageNamed:@"fire_shield_cast_0000.png"];
    _playerPixie.position = CGPointMake(0.0f,0.0f);
    _playerPixie.size = CGSizeMake(320.0f, 150.0f);
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
    SKSpriteNode *enemyNode = [[SKSpriteNode alloc] init];
    [enemyNode setSize:CGSizeMake(125.0f, 125.0f)];
    [enemyNode setPosition:CGPointMake(self.size.width/2.0f, self.size.height/2.0f)];
    [enemyNode setTexture:[[PPAtlasManager pixie_info] textureNamed:[NSString stringWithFormat:@"%@3_encounter",kElementTypeString[chooseSceneType]]]];
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

//        PPSpriteButton *petChooseButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(80.0f, 80.0f)];
        
        PPSpriteButton *petChooseButton = [PPSpriteButton buttonWithTexture:[[PPAtlasManager pixie_info] textureNamed:[[petsInfoArray objectAtIndex:i] objectForKey:@"petimage"]] andSize:CGSizeMake(80, 80)];
        NSLog(@"petimage=%@",[[petsInfoArray objectAtIndex:i] objectForKey:@"petimage"]);
        [petChooseButton setLabelWithText:[[petsInfoArray objectAtIndex:i] objectForKey:@"petname"] andFont:[UIFont systemFontOfSize:15] withColor:nil];
        [petChooseButton.label setPosition:CGPointMake(0.0f, -42.0f)];
        petChooseButton.position = CGPointMake(100 * (i - 1),0.0);
        petChooseButton.name = [NSString stringWithFormat:@"%d", PP_PETS_CHOOSE_BTN_TAG + i];
        [petChooseButton addTarget:self selector:@selector(spriteChooseClick:) withObject:petChooseButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [spriteContent addChild:petChooseButton];
        
    }

    
    self.petsArray = [NSArray arrayWithArray:petsInfoArray];
    
    SKLabelNode * titilePass = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
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
    SKSpriteNode * contentSprite = (SKSpriteNode *)[self childNodeWithName:PP_HURDLE_PETCHOOSE_CONTENT_NAME];
    
    for (int i = 0; i < 5; i++) {
        PPSpriteButton * btnObj = (PPSpriteButton *)[contentSprite childNodeWithName:[NSString stringWithFormat:@"%d",i]];
        if (btnObj == btn) {
            btnObj.color = [UIColor blueColor];
        }else{
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
    NSDictionary * choosedPet = [NSDictionary dictionaryWithDictionary:petsChoosedInfo];
    
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
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * cahcesPlist = [paths objectAtIndex:0];
    
    return cahcesPlist;
}

-(void)backButtonClick:(NSString *)backName
{
    [self.view presentScene:previousScene];
}

@end
