
#import "PPBallScene.h"

#define SPACE_BOTTOM 60
#define BALL_RANDOM_X kBallSize / 2 + arc4random() % (int)(320 - kBallSize)
#define BALL_RANDOM_Y kBallSize / 2 + arc4random() % (int)(450 - kBallSize)+SPACE_BOTTOM

static const uint32_t kBallCategory      =  0x1 << 0;
static const uint32_t kGroundCategory    =  0x1 << 1;

@interface PPBallScene () <SKPhysicsContactDelegate>

@property (nonatomic) BOOL isBallDragging;
@property (nonatomic) BOOL isBallRolling;
@property (nonatomic) PPBall * ballPlayer;
@property (nonatomic) PPBall * ballShadow;
@property (nonatomic) PPBall * ballEnemy;
@property (nonatomic) NSMutableArray * ballsElement;
@property (nonatomic) NSMutableArray * trapFrames;

@property (nonatomic) SKSpriteNode * barPlayerHP;
@property (nonatomic) SKSpriteNode * barPlayerMP;
@property (nonatomic) SKSpriteNode * barEnemyHP;
@property (nonatomic) SKSpriteNode * barEnemyMP;
@property (nonatomic) SKSpriteNode * btSkill;

@property (nonatomic) BOOL isTrapEnable;

@end

@implementation PPBallScene

-(id)initWithSize:(CGSize)size
           PixieA:(PPPixie *)pixieA
           PixieB:(PPPixie *)pixieB{
    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor blackColor];
        
        SKSpriteNode * bg = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(320, 450)];
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [bg setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"bg_01.png"]]];
        [self addChild:bg];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        // demo 初始化 skill parameter
        _isTrapEnable = NO;
        
        // demo 添加 Skill Button
        _btSkill = [SKSpriteNode spriteNodeWithImageNamed:@"skill_plant.png"];
        _btSkill.size = CGSizeMake(30, 30);
        _btSkill.name = @"bt_skill";
        _btSkill.position = CGPointMake(CGRectGetMidX(self.frame), 30);
        [self addChild:_btSkill];
        
        // demo 预加载 动画 frames
        _trapFrames = [NSMutableArray array];
        for (int i=1; i <= 40; i++) {
            NSString * textureName = [NSString stringWithFormat:@"陷阱%04d.png", i];
            SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
            [_trapFrames addObject:temp];
        }
        
        
        // demo 添加头像
        SKSpriteNode * playerPortrait = [SKSpriteNode spriteNodeWithImageNamed:@"ball_pixie_plant2.png"];
        playerPortrait.size = CGSizeMake(30, 30);
        playerPortrait.position = CGPointMake(30, 20);
        [self addChild:playerPortrait];
        
        
        SKSpriteNode * enemyPortrait = [SKSpriteNode spriteNodeWithImageNamed:@"ball_pixie_plant3.png"];
        enemyPortrait.size = CGSizeMake(30, 30);
        enemyPortrait.position = CGPointMake(30, 541);
        [self addChild:enemyPortrait];
        
        
        // 添加 HP bar
        _barPlayerHP = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(90, 10)];
        _barPlayerHP.anchorPoint = CGPointMake(0, 0.0);
        _barPlayerHP.position = CGPointMake(playerPortrait.frame.origin.x, playerPortrait.frame.origin.y+_barPlayerHP.frame.size.height+playerPortrait.frame.size.height);
        [self addChild:_barPlayerHP];
        
        _barEnemyHP = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(90, 10)];
        _barEnemyHP.anchorPoint = CGPointMake(0, 0.5);
        _barEnemyHP.position = CGPointMake(enemyPortrait.frame.origin.x+enemyPortrait.frame.size.width+10.0f, CGRectGetMaxY(self.frame) - 20);
        [self addChild:_barEnemyHP];
        
//        // 添加 MP bar
//        _barPlayerMP = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(75, 10)];
//        _barPlayerMP.anchorPoint = CGPointMake(1, 0.5);
//        _barPlayerMP.position = CGPointMake(CGRectGetMidX(self.frame) - 10, CGRectGetMaxY(self.frame) - 35);
//        [self addChild:_barPlayerMP];
        
//        _barEnemyMP = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(75, 10)];
//        _barEnemyMP.anchorPoint = CGPointMake(0, 0.5);
//        _barEnemyMP.position = CGPointMake(CGRectGetMidX(self.frame) + 10, CGRectGetMaxY(self.frame) - 35);
//        [self addChild:_barEnemyMP];
        
        // 添加 Walls
        CGFloat tWidth = 320;
        CGFloat tHeight = 450;
        [self addWalls:CGSizeMake(tWidth, kWallThick*2) atPosition:CGPointMake(tWidth / 2, tHeight + SPACE_BOTTOM)];
        [self addWalls:CGSizeMake(tWidth, kWallThick*2) atPosition:CGPointMake(tWidth / 2, 0 + SPACE_BOTTOM)];
        [self addWalls:CGSizeMake(kWallThick*2, tHeight) atPosition:CGPointMake(0, tHeight / 2 + SPACE_BOTTOM)];
        [self addWalls:CGSizeMake(kWallThick*2, tHeight) atPosition:CGPointMake(tWidth, tHeight / 2 + SPACE_BOTTOM)];
        
        // 添加 Ball of Self
        _ballPlayer = pixieA.pixieBall;
        _ballPlayer.name = @"ball_player";
        _ballPlayer.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);
        _ballPlayer.physicsBody.categoryBitMask = kBallCategory;
        _ballPlayer.physicsBody.contactTestBitMask = kBallCategory;
        [self addChild:_ballPlayer];
        
        // 添加 Ball of Enemey
        _ballEnemy = pixieB.pixieBall;
        _ballEnemy.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);
        _ballEnemy.physicsBody.categoryBitMask = kBallCategory;
        _ballEnemy.physicsBody.contactTestBitMask = kBallCategory;
        [self addChild:_ballEnemy];
        
        // 添加 Balls of Element
        _ballsElement = [NSMutableArray arrayWithObjects:nil];
        
        for (int i = 0; i < 5; i++) {
            PPBall * tBall = [PPBall ballWithElement:i + 1];
            tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);
            tBall.physicsBody.categoryBitMask = kBallCategory;
            tBall.physicsBody.contactTestBitMask = kBallCategory;
            [self addChild:tBall];
            [_ballsElement addObject:tBall];
        }
        [self addRandomBalls:5];
        
    }
    return self;
}

#pragma mark SKScene

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (touches.count > 1 || _isBallDragging || _isBallRolling) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode * touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
    
    // 点击自己的球
    if ([[touchedNode name] isEqualToString:@"ball_player"]) {
        
        _isBallDragging = YES;
        _ballShadow = [_ballPlayer copy];
        //_ballShadow.size = CGSizeMake(kBallSize, kBallSize);
        //_ballShadow.position = location;
        _ballShadow.alpha = 0.5f;
        _ballShadow.physicsBody = nil;
        [self addChild:_ballShadow];
    }
    
    // 点击技能按钮
    if ([[touchedNode name] isEqualToString:@"bt_skill"]) {
        _isTrapEnable = YES;
        
        for (PPBall * tBall in _ballsElement) {
            if ([tBall.name isEqualToString:@"ball_plant"]) {
                [tBall runAction:[SKAction animateWithTextures:_trapFrames timePerFrame:0.05f]];
            }
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (touches.count > 1) return;
    
    if (_isBallDragging && !_isBallRolling) {
        UITouch * touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        _ballShadow.position = location;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (touches.count > 1 ) return;
    
    if (_isBallDragging && !_isBallRolling) {
        
        _isBallDragging = NO;
        [_ballPlayer.physicsBody applyImpulse:CGVectorMake(_ballPlayer.position.x - _ballShadow.position.x,
                                                           _ballPlayer.position.y - _ballShadow.position.y)];
        
        [_ballShadow removeFromParent];
        _isBallRolling = YES;
    }
}

// 每帧处理程序
-(void)update:(NSTimeInterval)currentTime{
    
    // 如果球都停止了
    if (_isBallRolling && [self isAllStopRolling]) {
        NSLog(@"Doing Attack and Defend");
        _isBallRolling = NO;
        
        // 添加少了的球
        [self addRandomBalls:(kBallNumberMax - (int)_ballsElement.count)];
        
        // 刷新技能
        _isTrapEnable = NO;
        for (PPBall * tBall in _ballsElement) {
            [tBall setToDefaultTexture];
        }
    }
}

#pragma mark SKPhysicsContactDelegate

// 碰撞事件
- (void)didBeginContact:(SKPhysicsContact *)contact{
    if (!_isBallRolling) return;
    
    SKPhysicsBody * playerBall, * hittedBall;
    
    if (contact.bodyA == _ballPlayer.physicsBody && contact.bodyB != _ballEnemy.physicsBody) {
        // 球A是玩家球 球B不是玩家球
        playerBall = contact.bodyA;
        hittedBall = contact.bodyB;
    } else if (contact.bodyB == _ballPlayer.physicsBody && contact.bodyA != _ballEnemy.physicsBody) {
        // 球B是玩家球 球A不是玩家球
        playerBall = contact.bodyB;
        hittedBall = contact.bodyA;
    } else return;
    
    PPElementType attack = ((PPBall *)playerBall.node).ballElementType;
    PPElementType defend = ((PPBall *)hittedBall.node).ballElementType;
    
    if (kElementInhibition[attack][defend] > 1.0f) {
        [hittedBall.node removeFromParent];
        [_ballsElement removeObject:hittedBall.node];
        NSLog(@"%lu", (unsigned long)_ballsElement.count);
    }
    
    /*
    if (_isTrapEnable && ((PPBall *)hittedBall.node).ballElementType == PPElementTypePlant) {
        CGPoint tPos = _ballPlayer.position;
        [_ballPlayer removeFromParent];
        [self addChild:_ballPlayer];
        _ballPlayer.position = tPos;
    }
    */
    
    NSLog(@"%@ - %@ - %f", [ConstantData elementName:attack], [ConstantData elementName:defend], kElementInhibition[attack][defend]);
}

#pragma mark Custom

// 添加四周的墙
-(void)addWalls:(CGSize)nodeSize atPosition:(CGPoint)nodePosition{
    
    SKSpriteNode * wall = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:nodeSize];

    wall.position = nodePosition;
    wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
    
    wall.physicsBody.affectedByGravity = NO;
    wall.physicsBody.dynamic = NO;
    wall.physicsBody.friction = 0.1;
    wall.physicsBody.categoryBitMask = kGroundCategory;
    //wall.physicsBody.contactTestBitMask = kBallCategory;
    //wall.physicsBody.collisionBitMask = 0;
    
    [self addChild:wall];
}

// 添加随机的球
-(void)addRandomBalls:(int)number{
    for (int i = 0; i < number; i++) {
        PPBall * tBall = [PPBall ballWithElement:arc4random()%5 + 1];
        tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);
        tBall.physicsBody.categoryBitMask = kBallCategory;
        tBall.physicsBody.contactTestBitMask = kBallCategory;
        [self addChild:tBall];
        [_ballsElement addObject:tBall];
    }
}

// 是否所有的球都停止了滚动
-(BOOL)isAllStopRolling{
    
    if (vectorLength(_ballPlayer.physicsBody.velocity) > 0) {
        return NO;
    }
    if (vectorLength(_ballEnemy.physicsBody.velocity) > 0) {
        return NO;
    }
    for (PPBall * tBall in _ballsElement) {
        if (vectorLength(tBall.physicsBody.velocity) > 0) {
            return NO;
        }
    }
    return YES;
}

// 计算两点间距离
CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt( deltaX * deltaX + deltaY * deltaY );
};

// 计算向量长度
CGFloat vectorLength (CGVector vector) {
    return sqrt( vector.dx * vector.dx + vector.dy * vector.dy );
};

@end
