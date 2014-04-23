//
//  PPBall.m
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-4-21.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import "PPBall.h"


@implementation PPBall

+(PPBall *)ballWithElement:(int) element{
    PPBall * tBall = [PPBall spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@%d%@", @"ball_", element, @".png"]];
    if (tBall){
        tBall.size = CGSizeMake(BALL_SIZE, BALL_SIZE);
        [PPBall defaultBallPhysicsBody:tBall];
    }
    return tBall;
}

+(PPBall *)ballWithPlayer:(NSString *)player{
    
    PPBall * tBall = [PPBall spriteNodeWithImageNamed:@"ball_player.png"];
    if (tBall){
        tBall.size = CGSizeMake(BALL_SIZE, BALL_SIZE);
        [PPBall defaultBallPhysicsBody:tBall];
    }
    return tBall;
}

+(void)defaultBallPhysicsBody:(SKSpriteNode *)ball{
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:BALL_SIZE / 2];
    ball.physicsBody.linearDamping = 0.6f;      // 线阻尼系数
    ball.physicsBody.angularDamping = 0.7f;     // 角阻尼系数
    ball.physicsBody.friction = 0.7f;           // 表面摩擦力
    ball.physicsBody.restitution = 0.7f;        // 弹性恢复系数
    ball.physicsBody.dynamic = YES;             // 说明物体是动态的
    ball.physicsBody.usesPreciseCollisionDetection = YES; // 使用快速运动检测碰撞
}

@end
