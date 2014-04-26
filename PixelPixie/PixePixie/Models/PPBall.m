
#import "PPBall.h"

@implementation PPBall

+(PPBall *)ballWithElement:(PPElementType) elementType{
    PPBall * tBall = [PPBall spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@%d%@", @"ball_", (int)elementType, @".png"]];
    if (tBall){
        tBall.size = CGSizeMake(kBallSize, kBallSize);
        [PPBall defaultBallPhysicsBody:tBall];
    }
    return tBall;
}

+(PPBall *)ballWithPlayer:(NSString *)player{
    
    PPBall * tBall = [PPBall spriteNodeWithImageNamed:@"ball_player.png"];
    if (tBall){
        tBall.size = CGSizeMake(kBallSize, kBallSize);
        [PPBall defaultBallPhysicsBody:tBall];
    }
    return tBall;
}

+(void)defaultBallPhysicsBody:(SKSpriteNode *)ball{
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:kBallSize / 2];
    
    ball.physicsBody.linearDamping = kBallLinearDamping;    // 线阻尼系数
    ball.physicsBody.angularDamping = kBallAngularDamping;  // 角阻尼系数
    ball.physicsBody.friction = kBallFriction;              // 表面摩擦力
    ball.physicsBody.restitution = kBallRestitution;        // 弹性恢复系数
    
    ball.physicsBody.dynamic = YES;                         // 说明物体是动态的
    ball.physicsBody.usesPreciseCollisionDetection = YES;   // 使用快速运动检测碰撞
}

@end
