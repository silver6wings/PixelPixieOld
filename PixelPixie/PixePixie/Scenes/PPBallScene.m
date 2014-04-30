
#import "PPBallScene.h"

#define BALL_RANDOM_X kBallSize / 2 + arc4random() % (int)(self.frame.size.width - kBallSize)
#define BALL_RANDOM_Y kBallSize / 2 + arc4random() % (int)(self.frame.size.height - kBallSize)

static const uint32_t kBallCategory      =  0x1 << 0;
static const uint32_t kGroundCategory    =  0x1 << 1;

@interface PPBallScene () <SKPhysicsContactDelegate>

@property (nonatomic) BOOL isBallDragging;
@property (nonatomic) BOOL isBallRolling;
@property (nonatomic) PPBall * ballPlayer;
@property (nonatomic) PPBall * ballShadow;
@property (nonatomic) PPBall * ballEnemy;
@property (nonatomic) NSMutableArray * ballElement;

@end

@implementation PPBallScene

-(id)initWithSize:(CGSize)size
           PixieA:(PPPixie *)pixieA
           PixieB:(PPPixie *)pixieB{
    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor whiteColor];
        //self.physicsWorld.speed = 1.0f;
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        // Add Walls
        CGFloat tWidth = self.frame.size.width;
        CGFloat tHeight = self.frame.size.height;
        [self addWalls:CGSizeMake(tWidth, kWallThick*2) atPosition:CGPointMake(tWidth / 2, tHeight)];
        [self addWalls:CGSizeMake(tWidth, kWallThick*2) atPosition:CGPointMake(tWidth / 2, 0)];
        [self addWalls:CGSizeMake(kWallThick*2, tHeight) atPosition:CGPointMake(0, tHeight / 2)];
        [self addWalls:CGSizeMake(kWallThick*2, tHeight) atPosition:CGPointMake(tWidth, tHeight / 2)];
        
        // Add Ball of Self
        _ballPlayer = pixieA.pixieBall;
        _ballPlayer.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);
        _ballPlayer.physicsBody.categoryBitMask = kBallCategory;
        _ballPlayer.physicsBody.contactTestBitMask = kBallCategory;
        [self addChild:_ballPlayer];
        
        // Add Ball of Enemey
        _ballEnemy = pixieB.pixieBall;
        _ballEnemy.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);
        _ballEnemy.physicsBody.categoryBitMask = kBallCategory;
        _ballEnemy.physicsBody.contactTestBitMask = kBallCategory;
        _ballEnemy.alpha = 0.5;
        [self addChild:_ballEnemy];
        
        // Add Balls of Element
        _ballElement = [NSMutableArray arrayWithObjects:nil];
        
        for (int i = 0; i < 5; i++) {
            PPBall * tBall = [PPBall ballWithElement:i + 1];
            tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);
            tBall.physicsBody.categoryBitMask = kBallCategory;
            tBall.physicsBody.contactTestBitMask = kBallCategory;
            [self addChild:tBall];
            [_ballElement addObject:tBall];
        }
        [self addRandomBalls:5];

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (touches.count > 1 || _isBallDragging || _isBallRolling) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if (distanceBetweenPoints(location, _ballPlayer.position) <= kBallSize) {
        _isBallDragging = YES;
        _ballShadow = [PPBall spriteNodeWithImageNamed:@"ball_player.png"];
        _ballShadow.size = CGSizeMake(kBallSize, kBallSize);
        _ballShadow.alpha = 0.5f;
        _ballShadow.position = location;
        [self addChild:_ballShadow];
    }
    
    // SKAction * sa = [SKAction moveByX:100.0 y:100.0 duration:1.0];
    // [self.ball runAction:sa];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (touches.count > 1 || !_isBallDragging || _isBallRolling) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    _ballShadow.position = location;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (touches.count > 1 || !_isBallDragging || _isBallRolling) return;
    _isBallDragging = NO;
    
    [_ballPlayer.physicsBody applyImpulse:CGVectorMake(_ballPlayer.position.x - _ballShadow.position.x,
                                                       _ballPlayer.position.y - _ballShadow.position.y)];
    
    [_ballShadow removeFromParent];
    _isBallRolling = YES;
}

// 每帧处理程序
-(void)update:(NSTimeInterval)currentTime{
    
    if (_isBallRolling && [self isAllStopRolling]) {
        NSLog(@"Stopped");
        _isBallRolling = NO;
        [self addRandomBalls:(kBallNumberMax - (int)_ballElement.count)];
    }
}

#pragma SKPhysicsContactDelegate

// 碰撞事件
- (void)didBeginContact:(SKPhysicsContact *)contact{
    if (!_isBallRolling) return;
    
    SKPhysicsBody * playerBall, * hittedBall;
    
    if (contact.bodyA == _ballPlayer.physicsBody && contact.bodyB != _ballEnemy.physicsBody) {
        // 球A是玩家球 球B不是玩家球
        playerBall = contact.bodyA;
        hittedBall = contact.bodyB;
    } else if (contact.bodyB == _ballPlayer.physicsBody && contact.bodyA != _ballEnemy.physicsBody){
        // 球B是玩家球 球A不是玩家球
        playerBall = contact.bodyB;
        hittedBall = contact.bodyA;
    } else return;
    
    PPElementType attack = ((PPBall *)playerBall.node).ballElementType;
    PPElementType defend = ((PPBall *)hittedBall.node).ballElementType;
    
    if (kElementInhibition[attack][defend] > 1.0f) {
        [hittedBall.node removeFromParent];
        [_ballElement removeObject:hittedBall.node];
        NSLog(@"%lu", _ballElement.count);
    }
    
    NSLog(@"%@ - %@ - %f", [ConstantData elementName:attack], [ConstantData elementName:defend], kElementInhibition[attack][defend]);
}

#pragma Custom

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
        [_ballElement addObject:tBall];
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
    for (PPBall * tBall in _ballElement) {
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
