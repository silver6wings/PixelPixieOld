//
//  PPWorldBossScene.m
//  PixelPixie
//
//  Created by xiefei on 7/14/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPWorldBossScene.h"
#define SPACE_BOTTOM 60
#define BALL_RANDOM_X kBallSize / 2 + arc4random() % (int)(320 - kBallSize)
#define BALL_RANDOM_Y kBallSize / 2 + arc4random() % (int)(362 - kBallSize)+SPACE_BOTTOM

//static const uint32_t kBallCategory      =  0x1 << 0;
//
//static const uint32_t kGroundCategory    =  0x1 << 1;

@interface PPWorldBossScene()<SKPhysicsContactDelegate>

@property (nonatomic) BOOL isBallDragging;
@property (nonatomic) BOOL isBallRolling;
@property (nonatomic) PPBall * ballPlayer;
@property (nonatomic) PPBall * ballShadow;
@property (nonatomic) PPBall * ballEnemy;
@property (nonatomic,retain) NSMutableArray * ballsElement;
@property (nonatomic,retain) NSMutableArray * trapFrames;
@property (nonatomic,retain) PPBattleSideNode * playerSide;
@property (nonatomic,retain) PPBattleSideNode * enemySide;

@property (nonatomic) SKSpriteNode * btSkill;
@property (nonatomic) BOOL isTrapEnable;

@end

@implementation PPWorldBossScene
@synthesize choosedEnemys;
- (id)initWithSize:(CGSize)size
{
    
    if (self=[super initWithSize:size]) {
        self.backgroundColor = [UIColor redColor];
        [self setBackTitleText:@"World Boss" andPositionY:360.0f];
        
        self.backgroundColor = [SKColor blackColor];
        
        if (CurrentDeviceRealSize.height>500) {
            directFori5=44.0f;
            SKSpriteNode * bg = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(320, 450.0)];
            bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
            [bg setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"bg_01.png"]]];
            [self addChild:bg];
            
            
        }else
        {
            directFori5=0.0f;
            SKSpriteNode * bg = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(320, 362.0f)];
            bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
            [bg setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"bg_01.png"]]];
            [self addChild:bg];
            
        }
        
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        // demo 初始化 skill parameter
//        _isTrapEnable = NO;

        
        
    }
    return self;
}
-(void)backButtonClick:(NSString *)backName
{
    
    [self.view presentScene:previousScene transition:[SKTransition doorwayWithDuration:1.0]];
    
    
}
@end