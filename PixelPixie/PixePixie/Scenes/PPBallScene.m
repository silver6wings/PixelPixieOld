
#import "PPBallScene.h"

#define BALL_RANDOM_X kBallSize / 2 + arc4random() % (int)(self.frame.size.width - kBallSize)
#define BALL_RANDOM_Y kBallSize / 2 + arc4random() % (int)(self.frame.size.height - kBallSize)

static const uint32_t kBallCategory      =  0x1 << 0;
static const uint32_t kGroundCategory    =  0x1 << 1;

@interface PPBallScene () <SKPhysicsContactDelegate>

@property (nonatomic) BOOL isBallDragging;
@property (nonatomic) BOOL isBallRolling;
@property (nonatomic) PPBall * ballSelf;
@property (nonatomic) PPBall * ballShadow;
@property (nonatomic) PPBall * ballEnemy;
@property (nonatomic) NSMutableArray * ballElement;

@end

@implementation PPBallScene

-(id)initWithSize:(CGSize)size {
    
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
        _ballSelf = [PPBall ballWithPlayer:@""];
        _ballSelf.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);
        _ballSelf.physicsBody.categoryBitMask = kBallCategory;
        _ballSelf.physicsBody.contactTestBitMask = kGroundCategory;
        [self addChild:_ballSelf];
        
        // Add Ball of Enemey
        _ballEnemy = [PPBall ballWithPlayer:@""];
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
        }
        
        for (int i = 0; i < 5; i++) {
            PPBall * tBall = [PPBall ballWithElement:arc4random()%5 + 1];
            tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);
            tBall.physicsBody.categoryBitMask = kBallCategory;
            tBall.physicsBody.contactTestBitMask = kBallCategory;
            [self addChild:tBall];
        }
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (touches.count > 1 || _isBallDragging || _isBallRolling) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if (distanceBetweenPoints(location, _ballSelf.position) <= kBallSize) {
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
    
    [_ballSelf.physicsBody applyImpulse:CGVectorMake(_ballSelf.position.x - _ballShadow.position.x,
                                                     _ballSelf.position.y - _ballShadow.position.y)];
    
    [_ballShadow removeFromParent];
    _isBallRolling = YES;
}

-(void)update:(NSTimeInterval)currentTime{
    
    // NSLog(@"%f", _ballSelf.physicsBody.velocity.dx);
    // NSLog(@"%f", _ballSelf.physicsBody.velocity.dy);
    
    if ([self isAllStopRolling] && _isBallRolling) {
        NSLog(@"Stopped");
        _isBallRolling = NO;
    }
}

#pragma SKPhysicsContactDelegate

// 碰撞事件
- (void)didBeginContact:(SKPhysicsContact *)contact{
    if (!_isBallRolling) return;
    
}

#pragma Custom

-(void)addWalls:(CGSize)nodeSize atPosition:(CGPoint)nodePosition{
    
    SKSpriteNode * wall = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:nodeSize];
    wall.position = nodePosition;
    wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
    
    wall.physicsBody.affectedByGravity = NO;
    wall.physicsBody.dynamic = NO;
    wall.physicsBody.friction = 0.1;
    wall.physicsBody.categoryBitMask = kGroundCategory;
    wall.physicsBody.contactTestBitMask = kBallCategory;
    //wall.physicsBody.collisionBitMask = 0;
    
    [self addChild:wall];
}

-(BOOL)isAllStopRolling{
    
    if (vectorLength(_ballSelf.physicsBody.velocity) > 0) {
        return NO;
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
