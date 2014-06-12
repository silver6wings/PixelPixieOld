
#import "PPBattleScene.h"
#import "PPControllers.h"
#import "PPModels.h"
@interface PPBattleScene ()
@property (retain, nonatomic) PPPassNumberScroll *menu;
@property (retain,nonatomic) NSArray *petsArray;
@property (nonatomic) SKSpriteNode * playerPixie;
@property (nonatomic) NSMutableArray * pixieAnimation;
@property (nonatomic,retain)NSDictionary *choosedPet;
@end

@implementation PPBattleScene
@synthesize menu;
@synthesize petsArray;
@synthesize choosedPet;
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
   
    }
    
    return self;
}
#pragma mark - add a scroling uiview
- (void)didMoveToView:(SKView *)view
{
    //Called immediately after a scene is presented by a view.
    [super didMoveToView:view];
    
    PPPassNumberScroll *pppassView=[[PPPassNumberScroll alloc] initWithFrame:CGRectMake(0.0, 150.0, 320.0f, 200)];
    NSDictionary *dictPassInfo=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PassInfo" ofType:@"plist"]];
    pppassView.target=self;
    pppassView.selector=@selector(chooseSpriteToBattle:);
    [pppassView creatPassNumberScroll:dictPassInfo with:self];
    [pppassView setBackgroundColor:[UIColor redColor]];
    self.menu=pppassView;
    self.menu.scene=self;
    [self.view addSubview:self.menu];
    
}
-(void)startBattle:(PPPixie *)ppsprite
{
    
}
-(void)chooseSpriteToBattle:(NSNumber *)passName
{
    NSLog(@"passName=%@",passName);
    NSDictionary *dictPassInfo=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PassInfo" ofType:@"plist"]];
    NSArray *passArray=[NSArray arrayWithArray:[dictPassInfo objectForKey:@"transcriptinfo"]];
    NSInteger passCount=[passArray count];
    int index=[passName integerValue]-PP_PASSNUM_CHOOSE_TABLE_TAG;
    NSDictionary *passDictInfo=nil;
    if (passCount>index) {
        NSLog(@"pass choosed=%@",[passArray objectAtIndex:index]);
        passDictInfo=[NSDictionary dictionaryWithDictionary:[passArray objectAtIndex:index]];
    }
    
    self.backgroundColor = [UIColor grayColor];
    
    SKSpriteNode *spriteContent=[SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(100, 400)];
    spriteContent.name=@"contentSprite";
    spriteContent.position=CGPointMake(100, 300);
    [self addChild:spriteContent];
    
    
    NSDictionary * dictUserPets=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserPetInfo" ofType:@"plist"]];
    
    NSLog(@"dictUserPets=%@",dictUserPets);
    self.petsArray=[NSArray arrayWithArray:[dictUserPets objectForKey:@"userpetinfo"]];
    for (int i=0; i<[self.petsArray count]; i++) {
        
        PPCustomButton *sprit1=[PPCustomButton buttonWithSize:CGSizeMake(80.0f, 80.0f) andTitle:[[self.petsArray objectAtIndex:i] objectForKey:@"petname"] withTarget:self withSelecter:@selector(spriteChooseClick:)];
        sprit1.name=[NSString stringWithFormat:@"%d",PP_PETS_CHOOSE_BTN_TAG+i];
        sprit1.position=CGPointMake(-50, 100*(i-1));
        [spriteContent addChild:sprit1];
        
        
    }
    
    
    SKLabelNode *titilePass = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    titilePass.name = @"";
    titilePass.text = [NSString stringWithFormat:@"副本id:%@",[passDictInfo objectForKey:@"passid"]];
    titilePass.fontSize = 20;
    titilePass.fontColor=[UIColor whiteColor];
    titilePass.position = CGPointMake(0.0f,spriteContent.frame.size.height/2.0f);
    [spriteContent addChild:titilePass];
    
    
    
}
-(void)spriteChooseClick:(PPCustomButton *)spriteBtn
{
    
    NSDictionary *petsChoosedInfo=[self.petsArray objectAtIndex:[spriteBtn.name integerValue]-PP_PETS_CHOOSE_BTN_TAG];
    
    NSLog(@"petsChoose=%@",petsChoosedInfo);
    self.choosedPet = [NSDictionary dictionaryWithDictionary:petsChoosedInfo];
    
    SKSpriteNode *spriteTmp=(SKSpriteNode *)[self childNodeWithName:@"contentSprite"];
    spriteTmp.hidden=YES;
 
    
    
    // 加载开始按钮
    SKLabelNode *lbStart = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lbStart.name = @"bt_start";
    lbStart.text = @"Click me to start ^~^";
    lbStart.fontSize = 15;
    lbStart.fontColor = [UIColor yellowColor];
    lbStart.position = CGPointMake(CGRectGetMidX(self.frame),50);
    [self addChild:lbStart];
    
    
    if ([[petsChoosedInfo objectForKey:@"petstatus"] intValue]) {
      
        
        
        // 添加己方精灵
        _playerPixie = [SKSpriteNode spriteNodeWithImageNamed:@"变身效果01000"];
        _playerPixie.position = CGPointMake(CGRectGetMidX(self.frame)+30,400);
        _playerPixie.size = CGSizeMake(_playerPixie.frame.size.width/3, _playerPixie.frame.size.height/3);
        [self addChild:_playerPixie];
        
        
        SKLabelNode *statusLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        statusLabel.text=[NSString stringWithFormat:@"%@ 形态:%d",[petsChoosedInfo objectForKey:@"petname"],[[petsChoosedInfo objectForKey:@"petstatus"] integerValue]];
        statusLabel.position=CGPointMake(_playerPixie.frame.size.width/2+statusLabel.frame.size.width/2.0f, _playerPixie.position.y+_playerPixie.frame.size.height/2+statusLabel.frame.size.height/2.0f);
        [self addChild:statusLabel];
        
        
    }
    
    // 添加敌方精灵
    SKSpriteNode * enemyPixie = [SKSpriteNode spriteNodeWithImageNamed:@"pixie_plant2_battle1.png"];
    enemyPixie.position = CGPointMake(CGRectGetMidX(self.frame)-30,200);
    [self addChild:enemyPixie];

    // 预加载变身动画
    self.pixieAnimation = [[NSMutableArray alloc] init];
    for (int i=1; i <= 43; i++) {
        NSString *textureName = [NSString stringWithFormat:@"变身效果01%03d.png", i];
        SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
        [self.pixieAnimation addObject:temp];
    }
    


    
}
//得到应用程序Documents文件夹下的目标路径
-(NSString *)getPersonalSetTargetPath
{
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cahcesPlist=[paths objectAtIndex:0];
    
    return cahcesPlist;
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode * touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
    
    // 点击开始按钮
    if ([[touchedNode name] isEqualToString:@"bt_start"]) {
        
        [_playerPixie runAction:
         [SKAction sequence:@[
            [SKAction animateWithTextures:self.pixieAnimation timePerFrame:0.02f],
            [SKAction runBlock:^{
             
             // 初始化 ballScene
             PPPixie * playerPixie = [PPPixie birthPixieWithPetsInfo:self.choosedPet];
             PPPixie * eneplayerPixie = [PPPixie birthPixieWithPetsInfo:self.choosedPet];
             
             
             PPBallScene * ballScene = [[PPBallScene alloc] initWithSize:self.view.bounds.size
                                                                  PixieA:playerPixie
                                                                  PixieB:eneplayerPixie];
             ballScene.scaleMode = SKSceneScaleModeAspectFill;
             
             [self.view presentScene:ballScene transition:[SKTransition doorsOpenVerticalWithDuration:0.5f]];
            }]
        ]]];
    
    }
}

@end
