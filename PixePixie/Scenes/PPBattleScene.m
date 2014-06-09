
#import "PPBattleScene.h"
#import "PPControllers.h"
#import "PPModels.h"
@interface PPBattleScene ()
@property (weak, nonatomic) PPPassNumberScroll *menu;
@property (nonatomic) SKLabelNode * lbStart;
@property (nonatomic) SKSpriteNode * playerPixie;
@property (nonatomic) NSMutableArray * pixieAnimation;
@end

@implementation PPBattleScene
@synthesize menu;
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
    
    self.backgroundColor = [UIColor grayColor];
    
    SKSpriteNode *spriteContent=[SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(100, 400)];
    spriteContent.name=@"contentSprite";
    spriteContent.position=CGPointMake(100, 300);
    [self addChild:spriteContent];
    
    
    PPCustomButton *sprit1=[PPCustomButton buttonWithSize:CGSizeMake(80.0f, 80.0f) andTitle:@"精灵No.1"];
    sprit1.target=self;
    sprit1.name=@"sprite1";
    sprit1.position=CGPointMake(-50, 100);
    sprit1.selector=@selector(spriteChooseClick:);
    [spriteContent addChild:sprit1];
    
    
    PPCustomButton *sprit2=[PPCustomButton buttonWithSize:CGSizeMake(80.0f, 80.0f) andTitle:@"精灵No.2"];
    sprit2.target=self;
    sprit2.name=@"sprite2";
    sprit2.position=CGPointMake(sprit1.position.x, 00);
    sprit2.selector=@selector(spriteChooseClick:);
    [spriteContent addChild:sprit2];
    
    
    PPCustomButton *sprit3=[PPCustomButton buttonWithSize:CGSizeMake(80.0f, 80.0f) andTitle:@"精灵No.3"];
    sprit3.target=self;
    sprit3.name=@"sprite3";
    sprit3.position=CGPointMake(sprit1.position.x, -100);
    sprit3.selector=@selector(spriteChooseClick:);
    [spriteContent addChild:sprit3];

    
    
}
-(void)spriteChooseClick:(PPCustomButton *)spriteBtn
{
    
    SKSpriteNode *spriteTmp=(SKSpriteNode *)[self childNodeWithName:@"contentSprite"];
    spriteTmp.hidden=YES;
    
    // 加载开始按钮
    _lbStart = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _lbStart.name = @"bt_start";
    _lbStart.text = @"Click me to start ^~^";
    _lbStart.fontSize = 15;
    _lbStart.fontColor = [UIColor yellowColor];
    _lbStart.position = CGPointMake(CGRectGetMidX(self.frame),50);
    [self addChild:_lbStart];

    // 添加己方精灵
    _playerPixie = [SKSpriteNode spriteNodeWithImageNamed:@"变身效果01000"];
    _playerPixie.position = CGPointMake(CGRectGetMidX(self.frame)+30,400);
    _playerPixie.size = CGSizeMake(339, 242);
    [self addChild:_playerPixie];

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

    SKLabelNode *titilePass = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    titilePass.name = @"";
    titilePass.text = [NSString stringWithFormat:@"副本%d",203-PP_PASSNUM_CHOOSE_TABLE_TAG+1];
    titilePass.fontSize = 20;
    titilePass.fontColor=[UIColor whiteColor];
    titilePass.position = CGPointMake(CGRectGetMidX(self.frame),self.frame.size.height-40);
    [self addChild:titilePass];
    
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
             PPPixie * playerPixie = [PPPixie birthPixieWith:PPElementTypePlant Generation:2];             
             PPPixie * eneplayerPixie = [PPPixie birthPixieWith:PPElementTypePlant Generation:3];
             
             
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
