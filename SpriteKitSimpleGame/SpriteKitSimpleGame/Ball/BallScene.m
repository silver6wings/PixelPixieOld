//
//  ballScene.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-3-9.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "BallScene.h"

static const uint32_t BallCategory     =  0x1 << 0;
static const uint32_t GroundCategory     =  0x1 << 1;

@interface BallScene () <SKPhysicsContactDelegate>
@property (nonatomic) SKSpriteNode * ball;
@end

@implementation BallScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor whiteColor];
        self.physicsWorld.gravity = CGVectorMake(0, -2.0);
//        self.physicsWorld.speed = 1.0f;
        
        self.physicsWorld.contactDelegate = self;
        
        SKSpriteNode * ground = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor]
                                                             size:CGSizeMake(self.frame.size.width, 20)];
        ground.position = CGPointMake(self.frame.size.width / 2, 10);
        ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
        [self setAsGround:ground.physicsBody];
        [self addChild:ground];
        
        SKSpriteNode * groundLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor]
                                                                 size:CGSizeMake(20, self.frame.size.height)];
        groundLeft.position = CGPointMake(10, self.frame.size.height / 2);
        groundLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:groundLeft.size];
        [self setAsGround:groundLeft.physicsBody];
        [self addChild:groundLeft];
        
        SKSpriteNode * groundRight = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor]
                                                                  size:CGSizeMake(20, self.frame.size.height)];
        groundRight.position = CGPointMake(self.frame.size.width - 10, self.frame.size.height / 2);
        groundRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:groundRight.size];
        [self setAsGround:groundRight.physicsBody];
        [self addChild:groundRight];
        
        self.ball = [SKSpriteNode spriteNodeWithImageNamed:@"crystalball.png"];
        self.ball.color = [SKColor whiteColor];
        self.ball.size = CGSizeMake(40, 40);
        self.ball.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 );
        
        self.ball.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.ball.size];
        self.ball.physicsBody.friction = 0.0;       // 表面摩擦力
        self.ball.physicsBody.restitution = 0.7;    // 弹性恢复系数
        self.ball.physicsBody.dynamic = YES;        // 说明物体是动态的
        self.ball.physicsBody.usesPreciseCollisionDetection = YES; // 使用快速运动检测碰撞
        self.ball.physicsBody.categoryBitMask = BallCategory;
        self.ball.physicsBody.contactTestBitMask = GroundCategory;
        //self.ball.physicsBody.collisionBitMask = 0;
        [self addChild:self.ball];

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self.ball.physicsBody applyForce:CGVectorMake(0, 1000)];
    [self.ball.physicsBody applyImpulse:CGVectorMake(0, 10)];
    [self.ball.physicsBody applyTorque:0.1];
    
    //SKAction * sa = [SKAction moveByX:100.0 y:100.0 duration:1.0];
    //[self.ball runAction:sa];
}

- (void)didBeginContact:(SKPhysicsContact *)contact{
    
}

- (void)setAsGround:(SKPhysicsBody *)pb{
    pb.affectedByGravity = NO;
    pb.dynamic = NO;
    pb.friction = 0.0;
    pb.categoryBitMask = GroundCategory;
    pb.contactTestBitMask = BallCategory;
    //pb.collisionBitMask = 0;
}

@end
