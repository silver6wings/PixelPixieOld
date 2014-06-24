
#import "PPBall.h"
#import "PPPixie.h"

@interface PPBall ()
@property (nonatomic) SKTexture * defaultTexture;
@end

@implementation PPBall
@synthesize pixie, ballElementType,enemypixie;

#pragma mark Factory Method

// 创建元素球
+(PPBall *)ballWithElement:(PPElementType) elementType{
    
    NSString * imageName = [NSString stringWithFormat:@"%@%@%@",@"ball_",[ConstantData elementName:elementType],@".png"];
    if (imageName == nil) return nil;
    SKTexture * tTexture = [SKTexture textureWithImageNamed:imageName];
    PPBall * tBall = [PPBall spriteNodeWithTexture:tTexture];
    
    if (tBall){
        tBall.defaultTexture = tTexture;
        tBall.name = [NSString stringWithFormat:@"ball_%@",[ConstantData elementName:elementType]];
        tBall.ballElementType = elementType;
        tBall.size = CGSizeMake(kBallSize, kBallSize);
        
        [PPBall defaultBallPhysicsBody:tBall];
        
        tBall.pixie = nil;
    }
    return tBall;
}

// 创建宠物的球
+(PPBall *)ballWithPixie:(PPPixie *)pixie{
    
    NSString * imageName = [NSString stringWithFormat:@"ball_pixie_%@%d.png",
                                     [ConstantData elementName:PPElementTypePlant],
                                     pixie.pixieGeneration];
    if (imageName == nil) return nil;
    SKTexture * tTexture = [SKTexture textureWithImageNamed:imageName];
    PPBall * tBall = [PPBall spriteNodeWithTexture:tTexture];
    
    if (tBall){
        tBall.ballElementType = pixie.pixieElement;
        tBall.size = CGSizeMake(kBallSize, kBallSize);
        [PPBall defaultBallPhysicsBody:tBall];
        
        tBall.pixie = pixie;
    }

    
    return tBall;
}
// 创建敌人的球
+(PPBall *)ballWithEnemyPixie:(PPEnemyPixie *)enemypixie;
{
    
    NSString * imageName = [NSString stringWithFormat:@"ball_pixie_%@%d.png",
                            [ConstantData elementName:PPElementTypePlant],
                            enemypixie.pixieGeneration];
    if (imageName == nil) return nil;
    SKTexture * tTexture = [SKTexture textureWithImageNamed:imageName];
    PPBall * tBall = [PPBall spriteNodeWithTexture:tTexture];
    
    if (tBall){
        tBall.ballElementType = enemypixie.pixieElement;
        tBall.size = CGSizeMake(kBallSize, kBallSize);
        [PPBall defaultBallPhysicsBody:tBall];
    
        tBall.enemypixie = enemypixie;
    }
    return tBall;
}
// 默认的球的物理属性
+(void)defaultBallPhysicsBody:(SKSpriteNode *)ball{
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:kBallSize / 2];
    
    ball.physicsBody.linearDamping = kBallLinearDamping;    // 线阻尼系数
    ball.physicsBody.angularDamping = kBallAngularDamping;  // 角阻尼系数
    ball.physicsBody.friction = kBallFriction;              // 表面摩擦力
    ball.physicsBody.restitution = kBallRestitution;        // 弹性恢复系数
    
    ball.physicsBody.dynamic = YES;                         // 说明物体是动态的
    ball.physicsBody.usesPreciseCollisionDetection = YES;   // 使用快速运动检测碰撞
}



// 改为默认皮肤
-(void)setToDefaultTexture{
    [self runAction:[SKAction setTexture:_defaultTexture]];
}

@end
