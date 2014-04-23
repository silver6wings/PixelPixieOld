//
//  ballScene.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-3-9.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "PPBallScene.h"
#import "PPBall.h"

#define randomX BALL_SIZE / 2 + arc4random() % (int)(self.frame.size.width - BALL_SIZE)
#define randomY BALL_SIZE / 2 + arc4random() % (int)(self.frame.size.height - BALL_SIZE)

static const uint32_t BallCategory      =  0x1 << 0;
static const uint32_t GroundCategory    =  0x1 << 1;
static const int kWallThick = 2;

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
        [self addWalls:CGSizeMake(tWidth, kWallThick) atPosition:CGPointMake(tWidth / 2, tHeight - kWallThick / 2)];
        [self addWalls:CGSizeMake(tWidth, kWallThick) atPosition:CGPointMake(tWidth / 2, kWallThick / 2)];
        [self addWalls:CGSizeMake(kWallThick, tHeight) atPosition:CGPointMake(kWallThick / 2, tHeight / 2)];
        [self addWalls:CGSizeMake(kWallThick, tHeight) atPosition:CGPointMake(tWidth - kWallThick / 2, tHeight / 2)];
        
        // Add Ball of Self
        _ballSelf = [PPBall ballWithPlayer:@""];
        _ballSelf.position = CGPointMake(randomX, randomY);
        _ballSelf.physicsBody.categoryBitMask = BallCategory;
        _ballSelf.physicsBody.contactTestBitMask = GroundCategory;
        [self addChild:_ballSelf];
        
        // Add Ball of Enemey
        _ballEnemy = [PPBall ballWithPlayer:@""];
        _ballEnemy.position = CGPointMake(randomX, randomY);
        _ballEnemy.physicsBody.categoryBitMask = BallCategory;
        _ballEnemy.physicsBody.contactTestBitMask = BallCategory;
        _ballEnemy.alpha = 0.5;
        [self addChild:_ballEnemy];
        
        // Add Balls of Element
        _ballElement = [NSMutableArray arrayWithObjects:nil];
        
        for (int i = 0; i < 5; i++) {
            PPBall * tBall = [PPBall ballWithElement:i + 1];
            tBall.position = CGPointMake(randomX, randomY);
            tBall.physicsBody.categoryBitMask = BallCategory;
            tBall.physicsBody.contactTestBitMask = BallCategory;
            [self addChild:tBall];
        }
        
        for (int i = 0; i < 5; i++) {
            PPBall * tBall = [PPBall ballWithElement:arc4random()%5 + 1];
            tBall.position = CGPointMake(randomX, randomY);
            tBall.physicsBody.categoryBitMask = BallCategory;
            tBall.physicsBody.contactTestBitMask = BallCategory;
            [self addChild:tBall];
        }
    }
    return self;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (touches.count > 1 || _isBallDragging || _isBallRolling) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if (distanceBetweenPoints(location, _ballSelf.position) <= BALL_SIZE) {
        _isBallDragging = YES;
        _ballShadow = [PPBall spriteNodeWithImageNamed:@"ball_player.png"];
        _ballShadow.size = CGSizeMake(BALL_SIZE, BALL_SIZE);
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
}

#pragma Custom

-(void)addWalls:(CGSize)nodeSize atPosition:(CGPoint)nodePosition{
    
    SKSpriteNode * wall = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:nodeSize];
    wall.position = nodePosition;
    wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
    
    wall.physicsBody.affectedByGravity = NO;
    wall.physicsBody.dynamic = NO;
    wall.physicsBody.friction = 0.1;
    wall.physicsBody.categoryBitMask = GroundCategory;
    wall.physicsBody.contactTestBitMask = BallCategory;
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
