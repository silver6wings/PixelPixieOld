
#import "PPBattleScene.h"

@interface PPBattleScene ()
@property (nonatomic) SKLabelNode * lbStart;
@property (nonatomic) SKSpriteNode * playerPixie;
@property (nonatomic) NSMutableArray * pixieAnimation;
@end

@implementation PPBattleScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [UIColor blackColor];
        
       
        
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
        _pixieAnimation = [NSMutableArray array];
        for (int i=1; i <= 43; i++) {
            NSString *textureName = [NSString stringWithFormat:@"变身效果01%03d.png", i];
            SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
            [_pixieAnimation addObject:temp];
        }
    }
    
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode * touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
    
    // 点击开始按钮
    if ([[touchedNode name] isEqualToString:@"bt_start"]) {
        
        [_playerPixie runAction:
         [SKAction sequence:@[
            [SKAction animateWithTextures:_pixieAnimation timePerFrame:0.02f],
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
