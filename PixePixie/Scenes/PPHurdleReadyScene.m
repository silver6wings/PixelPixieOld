
#import "PPHurdleReadyScene.h"

@interface PPHurdleReadyScene ()
@property (retain,nonatomic) NSArray *petsArray;
@property (nonatomic) SKSpriteNode * playerPixie;
@property (nonatomic) NSMutableArray * pixieAnimation;
@end

@implementation PPHurdleReadyScene
@synthesize petsArray;
@synthesize choosedPet;
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        [self setBackTitleText:@"遭遇怪物" andPositionY:450.0f];

    }
    return self;
}

#pragma mark - add a scroling uiview

- (void)didMoveToView:(SKView *)view
{
    // Called immediately after a scene is presented by a view.
    [super didMoveToView:view];
    [self setBackgroundColor:[UIColor cyanColor]];

    
    
    // 加载开始按钮
    SKLabelNode *lbStart = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lbStart.name = @"bt_start";
    lbStart.text = @"Click me to start ^~^";
    lbStart.fontSize = 15;
    lbStart.fontColor = [UIColor blackColor];
    lbStart.position = CGPointMake(CGRectGetMidX(self.frame),50);
    [self addChild:lbStart];
    
    
        // 添加己方精灵
        _playerPixie = [SKSpriteNode spriteNodeWithImageNamed:@"变身效果01000"];
        _playerPixie.position = CGPointMake(CGRectGetMidX(self.frame)+30,300);
        _playerPixie.size = CGSizeMake(_playerPixie.size.width/2.0f, _playerPixie.size.height/2.0f);
        _playerPixie.size = CGSizeMake(_playerPixie.frame.size.width/3, _playerPixie.frame.size.height/3);
        [self addChild:_playerPixie];
        
        SKLabelNode *statusLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        statusLabel.fontSize = 15;
        statusLabel.text = [NSString stringWithFormat:@"%@ 形态:%ld",[self.choosedPet objectForKey:@"petname"],
                            (long)[[self.choosedPet objectForKey:@"petstatus"] integerValue]];
        statusLabel.position = CGPointMake(_playerPixie.frame.size.width/2+statusLabel.frame.size.width/2.0f,
                                           _playerPixie.position.y+_playerPixie.frame.size.height/2+statusLabel.frame.size.height/2.0f);
        [self addChild:statusLabel];
    
    // 添加敌方精灵
    SKSpriteNode * enemyPixie = [SKSpriteNode spriteNodeWithImageNamed:@"pixie_plant2_battle1.png"];
    [enemyPixie setColor:[UIColor blackColor]];
    enemyPixie.position = CGPointMake(CGRectGetMidX(self.frame)-30,170);
    enemyPixie.size = CGSizeMake(enemyPixie.size.width/2.0f, enemyPixie.size.height/2.0f);
    [self addChild:enemyPixie];
    
    
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
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode * touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
    
    // 点击开始按钮
    if ([[touchedNode name] isEqualToString:@"bt_start"]) {
        

        
        
        
        [_playerPixie runAction:[SKAction animateWithTextures:self.pixieAnimation timePerFrame:0.02f]
                     completion:^{
                        
                         
        PPPetChooseScene *petchoose = [[PPPetChooseScene alloc] initWithSize:self.view.bounds.size];
        petchoose->previousScene = self;
        [self.view presentScene:petchoose transition:[SKTransition doorsOpenHorizontalWithDuration:1]];
                         
                     }];
    }
}

-(void)backButtonClick:(NSString *)backName
{
    [self.view presentScene:previousScene transition:[SKTransition doorwayWithDuration:1.0]];
}

@end