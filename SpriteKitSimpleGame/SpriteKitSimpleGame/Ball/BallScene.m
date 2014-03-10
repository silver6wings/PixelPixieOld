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
@property (nonatomic) SKSpriteNode * ground;
@end

@implementation BallScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor whiteColor];
        self.physicsWorld.gravity = CGVectorMake(0, -2.0);
//        self.physicsWorld.speed = 1.0f;
        
        self.physicsWorld.contactDelegate = self;
        
        self.ground = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(self.frame.size.width, 100)];
        self.ground.position = CGPointMake(self.frame.size.width / 2, 50);
        
        self.ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.ground.size];
        self.ground.physicsBody.affectedByGravity = NO;
        self.ground.physicsBody.dynamic = NO;
        self.ground.physicsBody.categoryBitMask = GroundCategory;
        self.ground.physicsBody.contactTestBitMask = BallCategory;
        //self.ground.physicsBody.collisionBitMask = 0;
        
        [self addChild:self.ground];
        
        self.ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball.png"];
        self.ball.color = [SKColor whiteColor];
        self.ball.size = CGSizeMake(40, 40);
        self.ball.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 );
        
        self.ball.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.ball.size];
        self.ball.physicsBody.friction = 0.0;       // 表面摩擦力
        self.ball.physicsBody.restitution = 1.0;    // 弹性恢复系数
        self.ball.physicsBody.dynamic = YES;        // 说明物体是动态的
        self.ball.physicsBody.usesPreciseCollisionDetection = YES; // 使用快速运动检测碰撞
        self.ball.physicsBody.categoryBitMask = BallCategory;
        self.ball.physicsBody.contactTestBitMask = GroundCategory;
        
        //self.ball.physicsBody.collisionBitMask = 0;
        
        [self addChild:self.ball];
        
        //SKAction * sa = [SKAction moveByX:100.0 y:100.0 duration:1.0];
        //[self.ball runAction:sa];
        
        [self.ball.physicsBody applyForce:CGVectorMake(0, 100)];
        [self.ball.physicsBody applyTorque:0.01];
   
    }
    return self;
}

- (void)didBeginContact:(SKPhysicsContact *)contact{
    
}

@end
