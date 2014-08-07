
#import "PPPixie.h"

@interface PPBall ()
@property (nonatomic) SKTexture * defaultTexture;
@end

@implementation PPBall
@synthesize pixie, ballElementType, pixieEnemy;

#pragma mark Factory Method

// 创建元素球
+(PPBall *)ballWithElement:(PPElementType) elementType{
    
    NSString * imageName = [NSString stringWithFormat:@"%@%@%@",@"ball_",[ConstantData elementName:elementType],@".png"];
    if (imageName == nil) return nil;
    SKTexture * tTexture = [SKTexture textureWithImageNamed:imageName];
    
    PPBall * tBall = [PPBall spriteNodeWithTexture:tTexture];
    tBall.ballType = PPBallTypeElement;
    
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
    tBall.ballType = PPBallTypePlayer;
    
    if (tBall){
        tBall.ballElementType = pixie.pixieElement;
        tBall.size = CGSizeMake(kBallSize, kBallSize);
        [PPBall defaultBallPhysicsBody:tBall];
        
        tBall.pixie = pixie;
    }
    
//    PPBasicLabelNode *additonLabel= [[PPBasicLabelNode alloc] init];
//    additonLabel.position = CGPointMake(0.0f, 10.0f);
//    [additonLabel setText:@"%100"];
//    [tBall addChild:additonLabel];
    
    return tBall;
}

// 创建敌人的球
+(PPBall *)ballWithEnemyPixie:(PPPixie *)pixieEnemy;
{
    
    NSString * imageName = [NSString stringWithFormat:@"ball_pixie_%@%d.png",
                            [ConstantData elementName:PPElementTypePlant],
                            pixieEnemy.pixieGeneration];
    
    if (imageName == nil) return nil;
    SKTexture * tTexture = [SKTexture textureWithImageNamed:imageName];
    
    PPBall * tBall = [PPBall spriteNodeWithTexture:tTexture];
    tBall.ballType = PPBallTypeEnemy;
    
    if (tBall){
        tBall.ballElementType = pixieEnemy.pixieElement;
        tBall.size = CGSizeMake(kBallSize, kBallSize);
        [PPBall defaultBallPhysicsBody:tBall];
    
        tBall.pixieEnemy = pixieEnemy;
    }
    
    return tBall;
}
// 创建敌人的球
+(PPBall *)ballWithCombo
{
    
    NSString * imageName = @"skill_plant.png";
    
    if (imageName == nil) return nil;
    SKTexture * tTexture = [SKTexture textureWithImageNamed:imageName];
    
    PPBall * tBall = [PPBall spriteNodeWithTexture:tTexture];
    tBall.ballType = PPBallTypeElement;
    
    if (tBall){
        
        tBall.defaultTexture = tTexture;
        tBall.name = @"combo";
        tBall.ballElementType = PPElementTypeNone;
        tBall.size = CGSizeMake(kBallSize, kBallSize);
        
        [PPBall defaultBallPhysicsBody:tBall];
        
        tBall.pixie = nil;
    }
    
    return tBall;
}
// 改为默认皮肤
-(void)setToDefaultTexture{
    [self runAction:[SKAction setTexture:_defaultTexture]];
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

@end
