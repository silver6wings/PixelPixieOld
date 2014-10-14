
#import "PPPixie.h"

@interface PPBall ()
@property (nonatomic) SKTexture * defaultTexture;
@end

@implementation PPBall
@synthesize sustainRounds,pixie, ballElementType, pixieEnemy, ballStatus, comboBallTexture, comboBallSprite;

#pragma mark Factory Method

// 创建玩家宠物的球
+(PPBall *)ballWithPixie:(PPPixie *)pixie
{
    if (pixie == nil) return nil;
    NSString * imageName = [NSString stringWithFormat:@"%@%d_ball.png",
                            kPPElementTypeString[pixie.pixieElement],pixie.pixieGeneration];
    PPBall * tBall = [PPBall spriteNodeWithTexture:[SKTexture textureWithImageNamed:imageName]];
    
    if (tBall){
        tBall.ballType = PPBallTypePlayer;
        tBall.ballElementType = pixie.pixieElement;
        tBall.size = CGSizeMake(kBallSizePixie, kBallSizePixie);
        [PPBall defaultBallPhysicsBody:tBall];
        tBall.pixie = pixie;
    }
    
    return tBall;
    
}

// 创建敌人宠物的球
+(PPBall *)ballWithPixieEnemy:(PPPixie *)pixieEnemy;
{
    if (pixieEnemy == nil) return nil;
    NSString * imageName = [NSString stringWithFormat:@"%@%d_ball.png",
                            kPPElementTypeString[pixieEnemy.pixieElement],pixieEnemy.pixieGeneration];
    PPBall * tBall = [PPBall spriteNodeWithTexture:[SKTexture textureWithImageNamed:imageName]];
    
    if (tBall){
        tBall.ballType = PPBallTypeEnemy;
        tBall.ballElementType = pixieEnemy.pixieElement;
        tBall.size = CGSizeMake(kBallSizePixie, kBallSizePixie);
        [PPBall defaultBallPhysicsBody:tBall];
        tBall.pixieEnemy = pixieEnemy;
    }
    return tBall;
}

// 创建元素球
+(PPBall *)ballWithElement:(PPElementType) elementType{
    
    NSString * imageName = [NSString stringWithFormat:@"%@_ball.png", kPPElementTypeString[elementType]];
    SKTexture * tTexture = [SKTexture textureWithImageNamed:imageName];
    PPBall * tBall = [PPBall spriteNodeWithTexture:tTexture];
    
    if (tBall)
    {
        tBall.ballType = PPBallTypeElement;
        tBall.defaultTexture = tTexture;
        tBall.name = [NSString stringWithFormat:@"ball_%@", kPPElementTypeString[elementType]];
        tBall.ballElementType = elementType;
        tBall.size = CGSizeMake(kBallSize, kBallSize);
        [PPBall defaultBallPhysicsBody:tBall];
        tBall.pixie = nil;
    }
    
    PPBasicLabelNode * roundsLabel = [[PPBasicLabelNode alloc] init];
    roundsLabel.name = @"roundsLabel";
    roundsLabel.fontColor = [UIColor redColor];
    roundsLabel.position = CGPointMake(10, 10);
    [roundsLabel setText:@"0"];
    roundsLabel.fontSize = 15;
    
    [tBall addChild:roundsLabel];
    return tBall;
}

// 创建连击球
+(PPBall *)ballWithCombo
{
    NSString * imageName = @"combo_ball.png";
    SKTexture * tTexture = [SKTexture textureWithImageNamed:imageName];
    PPBall * tBall = [PPBall spriteNodeWithTexture:tTexture];
     
    if (tBall)
    {
        tBall.ballType = PPBallTypeCombo;
        tBall.ballElementType = PPElementTypeNone;
        tBall.defaultTexture = tTexture;
        tBall.name = @"combo";
        tBall.size = CGSizeMake(kBallSize, kBallSize);
        [PPBall defaultBallPhysicsBody:tBall];
        tBall.pixie = nil;
    }
    return tBall;
}

// 设置元素球的持续回合
-(void)setRoundsLabel:(int)rounds
{
    PPBasicLabelNode * roundsLabel = (PPBasicLabelNode *)[self childNodeWithName:@"roundsLabel"];
    [roundsLabel setText:[NSString stringWithFormat:@"%d",rounds]];
}

// 改为默认皮肤
-(void)setToDefaultTexture
{
    [self runAction:[SKAction setTexture:_defaultTexture]];
}

#pragma mark Animation  球体各种动画

-(void)startElementBallHitAnimation
{
    // 创建元素撞击动画
    NSMutableArray * textureArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        SKTexture * textureCombo = [[TextureManager ball_elements] textureNamed:[NSString stringWithFormat:@"%@_hit_00%02d",kPPElementTypeString[self.ballElementType],i]];
        NSLog(@"textureName=%@",[NSString stringWithFormat:@"%@_hit_00%02d",kPPElementTypeString[self.ballElementType],i]);

        [textureArray addObject:textureCombo];
    }
    self.comboBallTexture = textureArray;
    
    
    if (self.comboBallSprite != nil) {
        [self.comboBallSprite removeFromParent];
        self.comboBallSprite = nil;
    }
    
    self.comboBallSprite =[[PPBasicSpriteNode alloc] init];
    self.comboBallSprite.size = CGSizeMake(50.0f, 50.0f);
    [self.comboBallSprite setPosition:CGPointMake(0.0f, 0.0f)];
    [self addChild:self.comboBallSprite];
    
    [self.comboBallSprite runAction:[SKAction animateWithTextures:self.comboBallTexture timePerFrame:kFrameInterval]
                         completion:^{
                             [self.comboBallSprite removeFromParent];
    }];
}

// 治疗动画
-(void)startPixieHealAnimation
{
    NSMutableArray * textureArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 15; i++) {
        SKTexture * textureCombo = [[TextureManager ball_table] textureNamed:[NSString stringWithFormat:@"pixie_heal_00%02d",i]];
        [textureArray addObject:textureCombo];
    }
    self.comboBallTexture = textureArray;
    
    
    if (self.comboBallSprite != nil) {
        [self.comboBallSprite removeFromParent];
        self.comboBallSprite = nil;
    }
    
    self.comboBallSprite =[[PPBasicSpriteNode alloc] init];
    self.comboBallSprite.size = CGSizeMake(50.0f, 50.0f);
    [self.comboBallSprite setPosition:CGPointMake(0.0f, 0.0f)];
    [self addChild:self.comboBallSprite];
    
    [self.comboBallSprite runAction:[SKAction animateWithTextures:self.comboBallTexture timePerFrame:kFrameInterval]
                         completion:^{
                             [self.comboBallSprite removeFromParent];
                         }];
}

// 连击能量动画
-(void)startComboAnimation
{
    
    if (self.comboBallSprite != nil) {
        [self.comboBallSprite removeFromParent];
        self.comboBallSprite = nil;
    }
    
    self.comboBallSprite =[[PPBasicSpriteNode alloc] init];
    self.comboBallSprite.size = CGSizeMake(50.0f, 50.0f);
    [self.comboBallSprite setPosition:CGPointMake(0.0f, 0.0f)];
    [self addChild:self.comboBallSprite];
    
    [self.comboBallSprite runAction:[[TextureManager ball_table] getAnimation:@"combo_ball"]
                         completion:^{[self.comboBallSprite removeFromParent];}];
}


// 变身陷阱动画
-(void)startMagicballAnimation
{
    if (self.comboBallSprite != nil) {
        [self.comboBallSprite removeFromParent];
        self.comboBallSprite = nil;
    }
    
    self.comboBallSprite =[[PPBasicSpriteNode alloc] init];
    self.comboBallSprite.size = CGSizeMake(50.0f, 50.0f);
    [self.comboBallSprite setPosition:CGPointMake(0.0f, 0.0f)];
    [self addChild:self.comboBallSprite];
    
    [self.comboBallSprite runAction:[[TextureManager ball_magic] getAnimation:@"magic_ball"]
                         completion:^{[self.comboBallSprite removeFromParent];}];
}

// 创建被缠绕动画
-(void)startPlantrootAnimation
{
    NSMutableArray * textureArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 22; i++) {
        SKTexture * textureCombo = [[TextureManager ball_buffer] textureNamed:[NSString stringWithFormat:@"plant_root_ball_00%02d",i]];
        [textureArray addObject:textureCombo];
    }
    self.comboBallTexture = textureArray;
    
    
    if (self.comboBallSprite != nil) {
        [self.comboBallSprite removeFromParent];
        self.comboBallSprite = nil;
    }
    
    self.comboBallSprite =[[PPBasicSpriteNode alloc] init];
    self.comboBallSprite.size = CGSizeMake(50.0f, 50.0f);
    [self.comboBallSprite setPosition:CGPointMake(0.0f, 0.0f)];
    [self addChild:self.comboBallSprite];
    
    [self.comboBallSprite runAction:[SKAction animateWithTextures:self.comboBallTexture timePerFrame:kFrameInterval]
                         completion:^{
                             [self.comboBallSprite removeFromParent];
                         }];
}


// 默认的球的物理属性
+(void)defaultBallPhysicsBody:(PPBall *)ball{
    
    if (ball.ballType == PPBallTypePlayer || ball.ballType == PPBallTypeEnemy){
        ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:kBallSizePixie / 2];
    } else {
        ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:kBallSize / 2];
    }
    
    ball.physicsBody.linearDamping = kBallLinearDamping;    // 线阻尼系数
    ball.physicsBody.angularDamping = kBallAngularDamping;  // 角阻尼系数
    ball.physicsBody.friction = kBallFriction;              // 表面摩擦力
    ball.physicsBody.restitution = kBallRestitution;        // 弹性恢复系数
    
    ball.physicsBody.dynamic = YES;                         // 说明物体是动态的
    ball.physicsBody.usesPreciseCollisionDetection = YES;   // 使用快速运动检测碰撞
}

@end
