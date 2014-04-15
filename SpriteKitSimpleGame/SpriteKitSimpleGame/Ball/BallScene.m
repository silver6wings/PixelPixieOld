//
//  ballScene.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-3-9.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "BallScene.h"

static const uint32_t BallCategory      =  0x1 << 0;
static const uint32_t GroundCategory    =  0x1 << 1;

@interface BallScene () <SKPhysicsContactDelegate>

@property (nonatomic) SKSpriteNode * ballSelf;
@property (nonatomic) SKSpriteNode * ballEnemey;

@property (nonatomic) NSMutableArray * ballElement;

@end

@implementation BallScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor whiteColor];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
//        self.physicsWorld.speed = 1.0f;
        
        self.physicsWorld.contactDelegate = self;
        
        // Add Walls
        
        SKSpriteNode * wallTop = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(self.frame.size.width, 20)];
        wallTop.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 10);
        wallTop.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wallTop.size];
        [self setAsWall:wallTop.physicsBody];
        [self addChild:wallTop];
        
        SKSpriteNode * wallBottom = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(self.frame.size.width, 20)];
        wallBottom.position = CGPointMake(self.frame.size.width / 2, 10);
        wallBottom.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wallBottom.size];
        [self setAsWall:wallBottom.physicsBody];
        [self addChild:wallBottom];
        
        SKSpriteNode * wallLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(20, self.frame.size.height)];
        wallLeft.position = CGPointMake(10, self.frame.size.height / 2);
        wallLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wallLeft.size];
        [self setAsWall:wallLeft.physicsBody];
        [self addChild:wallLeft];
        
        SKSpriteNode * wallRight = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(20, self.frame.size.height)];
        wallRight.position = CGPointMake(self.frame.size.width - 10, self.frame.size.height / 2);
        wallRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wallRight.size];
        [self setAsWall:wallRight.physicsBody];
        [self addChild:wallRight];

        
        // Set Ball of Self
        
        _ballSelf = [SKSpriteNode spriteNodeWithImageNamed:@"ball_self.png"];
        _ballSelf.size = CGSizeMake(40, 40);
        _ballSelf.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 );
        _ballSelf.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_ballSelf.size];
        [self setAsBall:_ballSelf.physicsBody];
        [self addChild:_ballSelf];

        // Set Ball of Enemey
        
        _ballEnemey = [SKSpriteNode spriteNodeWithImageNamed:@"ball_enemey.png"];
        _ballEnemey.size = CGSizeMake(40, 40);
        _ballEnemey.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 );
        _ballEnemey.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_ballEnemey.size];
        [self setAsBall:_ballEnemey.physicsBody];
        [self addChild:_ballEnemey];
        
        // Set Balls of Element
        _ballElement = [NSMutableArray arrayWithObjects:nil];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
//    [_ball.physicsBody applyForce:CGVectorMake(0, 1000)];
    [_ballSelf.physicsBody applyImpulse:CGVectorMake(0, 10)];
    [_ballSelf.physicsBody applyTorque:0.1];
    
    //SKAction * sa = [SKAction moveByX:100.0 y:100.0 duration:1.0];
    //[self.ball runAction:sa];
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact{
    
}

- (void)setAsWall:(SKPhysicsBody *)wallPhysic{
    wallPhysic.affectedByGravity = NO;
    wallPhysic.dynamic = NO;
    wallPhysic.friction = 0.1;
    wallPhysic.categoryBitMask = GroundCategory;
    wallPhysic.contactTestBitMask = BallCategory;
    //wallPhysic.collisionBitMask = 0;
}

- (void)setAsBall:(SKPhysicsBody *)ballPhysic{
    ballPhysic.friction = 0.6;       // 表面摩擦力
    ballPhysic.restitution = 0.7;    // 弹性恢复系数
    ballPhysic.dynamic = YES;        // 说明物体是动态的
    ballPhysic.usesPreciseCollisionDetection = YES; // 使用快速运动检测碰撞
    ballPhysic.categoryBitMask = BallCategory;
    ballPhysic.contactTestBitMask = GroundCategory;
    //ballPhysic.physicsBody.collisionBitMask = 0;
}



-(void)update:(NSTimeInterval)currentTime{
    //NSLog(@"%f", currentTime);
}

@end
