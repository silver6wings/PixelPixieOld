

#import "PPBallBattleScene.h"
#import "PPBattleInfoLayer.h"

#define SPACE_BOTTOM 80
#define BALL_RANDOM_X kBallSize / 2 + arc4random() % (int)(320 - kBallSize)
#define BALL_RANDOM_Y kBallSize / 2 + arc4random() % (int)(320 - kBallSize)+SPACE_BOTTOM

// 物理实体类型
typedef NS_OPTIONS (int, EntityCategory)
{
    EntityCategoryBall    =  0x1 << 0,
    EntityCategoryWall    =  0x1 << 1,
};

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

@interface PPBallBattleScene () < SKPhysicsContactDelegate, UIAlertViewDelegate >
{
    long frameFlag;
    BOOL isNotSkillRun;
    NSString *sceneTypeString;
}

@property (nonatomic, retain) PPPixie * pixiePlayer;
@property (nonatomic, retain) PPPixie * pixieEnemy;

@property (nonatomic) BOOL isBallDragging;
@property (nonatomic) BOOL isBallRolling;
@property (nonatomic) PPBall * ballPlayer;
@property (nonatomic) PPBall * ballShadow;
@property (nonatomic) PPBall * ballEnemy;

@property (nonatomic, retain) NSMutableArray * ballsElement;
@property (nonatomic, retain) NSMutableArray * ballsCombos;
@property (nonatomic, retain) NSMutableArray * trapFrames;
@property (nonatomic, retain) PPBattleInfoLayer * playerSkillSide;
@property (nonatomic, retain) PPBattleInfoLayer * playerAndEnemySide;

@property (nonatomic) SKSpriteNode * btSkill;
@property (nonatomic) BOOL isTrapEnable;
@end

@implementation PPBallBattleScene
@synthesize hurdleReady;
@synthesize ballsCombos;

-(id)initWithSize:(CGSize)size
      PixiePlayer:(PPPixie *)pixieA
       PixieEnemy:(PPPixie *)pixieB
     andSceneType:(PPElementType)sceneType{
    
    if (self = [super initWithSize:size]) {
        
        _isTrapEnable = NO;
        
        // 帧数间隔计数
        frameFlag = 0;
        
        // 处理参数
        self.pixiePlayer = pixieA;
        self.pixieEnemy = pixieB;
        sceneTypeString = kPPElementTypeString[sceneType];
        
        // 初始化宠物基础数据
        petCombos = 0;
        petAssimSameEleNum = 0;
        petAssimDiffEleNum = 0;
        enemyCombos = 0;
        enemyAssimDiffEleNum = 0;
        enemyAssimSameEleNum = 0;
        currentPhysicsAttack = 0;
        
        // 设置敌我元素属性
        PPElementType petElement = pixieA.pixieBall.ballElementType;
        PPElementType enemyElement = pixieB.pixieBall.ballElementType;
        interCoefficient = kElementInhibition[petElement][enemyElement];
        
        // 设置场景物理属性
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        // 添加背景图片
        SKSpriteNode * bg = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"%@_wall_back.png",sceneTypeString]];
        bg.size = CGSizeMake(320.0f, 320.0f);
        bg.position = CGPointMake(CGRectGetMidX(self.frame), 160.0f + SPACE_BOTTOM + PP_FIT_TOP_SIZE);
        [self addChild:bg];
        
        // 添加状态条
        self.playerSkillSide = [[PPBattleInfoLayer alloc] init];
        self.playerSkillSide.position= CGPointMake(self.size.width/2.0f, 40 + PP_FIT_TOP_SIZE);
        self.playerSkillSide.size =  CGSizeMake(self.size.width, 80.0f);
        self.playerSkillSide.name = PP_PET_PLAYER_SIDE_NODE_NAME;
        self.playerSkillSide.target = self;
        self.playerSkillSide.skillSelector = @selector(skillPlayerShowBegin:);
        self.playerSkillSide.pauseSelector = @selector(pauseBtnClick:);
        self.playerSkillSide.hpBeenZeroSel = @selector(hpBeenZeroMethod:);
        [self.playerSkillSide setColor:[UIColor grayColor]];
        [self.playerSkillSide setSideSkillsBtn:pixieA andSceneString:sceneTypeString];
        [self addChild:self.playerSkillSide];
        
        // 添加围墙
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        CGFloat tWidth = 320.0f;
        CGFloat tHeight = 320.0f;
        [self addWalls:CGSizeMake(tWidth, kWallThick) atPosition:CGPointMake(tWidth / 2, tHeight + SPACE_BOTTOM + PP_FIT_TOP_SIZE)];
        [self addWalls:CGSizeMake(tWidth, kWallThick) atPosition:CGPointMake(tWidth / 2, 0 + SPACE_BOTTOM + PP_FIT_TOP_SIZE)];
        
        // 添加己方玩家球
        self.ballPlayer = pixieA.pixieBall;
        self.ballPlayer.name = @"ball_player";
        self.ballPlayer.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y + PP_FIT_TOP_SIZE);
        self.ballPlayer.physicsBody.categoryBitMask = EntityCategoryBall;
        self.ballPlayer.physicsBody.contactTestBitMask = EntityCategoryBall;
        [self addChild:self.ballPlayer];
        
        // 添加连击球
        self.ballsElement = [[NSMutableArray alloc] init];
        self.ballsCombos = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 5; i++) {
            PPBall * comboBall = [PPBall ballWithCombo];
            comboBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y + PP_FIT_TOP_SIZE);
            comboBall.name = PP_BALL_TYPE_COMBO_NAME;
            comboBall.physicsBody.contactTestBitMask = EntityCategoryBall;
            comboBall.physicsBody.PPBallPhysicsBodyStatus = [NSNumber numberWithInt:i];
            comboBall.physicsBody.categoryBitMask = EntityCategoryBall;
            [self addChild:comboBall];
            [self.ballsCombos addObject:comboBall];
        }
    }
    return self;
}

#pragma mark SKScene

-(void)didMoveToView:(SKView *)view
{
    [self performSelectorOnMainThread:@selector(roundRotateBegin) withObject:nil afterDelay:1.0f];
}

-(void)willMoveFromView:(SKView *)view
{}

// 每帧处理程序开始
-(void)update:(NSTimeInterval)currentTime
{
    frameFlag++;
    frameFlag %= 60;
}

-(void)didSimulatePhysics
{
    if (frameFlag == 30) [self checkingBallsMove];
}

#pragma mark UIResponder

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isBallRolling == YES) {
        return;
    }
    
    if (touches.count > 1 || _isBallDragging || _isBallRolling || isNotSkillRun) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode * touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
    
    // 点击自己的球
    if ([[touchedNode name] isEqualToString:@"ball_player"])
    {
        _isBallDragging = YES;
        _ballShadow = [PPBall ballWithPixie:self.pixiePlayer];
        _ballShadow.size = CGSizeMake(kBallSize, kBallSize);
        _ballShadow.position = location;
        _ballShadow.alpha = 0.5f;
        _ballShadow.physicsBody = nil;
        [self addChild:_ballShadow];
    }
    
    // 点击技能按钮
    if ([[touchedNode name] isEqualToString:@"bt_skill"])
    {
        _isTrapEnable = YES;
        for (PPBall * tBall in self.ballsElement) {
            if ([tBall.name isEqualToString:@"ball_plant"]) {
                [tBall runAction:[SKAction animateWithTextures:_trapFrames timePerFrame:0.05f]];
            }
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touches.count > 1) return;
    
    if (_isBallDragging && !_isBallRolling) {
        UITouch * touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        _ballShadow.position = location;
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touches.count > 1 ) return;
    
    if (_isBallDragging && !_isBallRolling) {
        
        _isBallDragging = NO;
        [self.ballPlayer.physicsBody applyImpulse:
         CGVectorMake((self.ballPlayer.position.x - _ballShadow.position.x) * kBounceReduce,
                      (self.ballPlayer.position.y - _ballShadow.position.y) * kBounceReduce)];
        
        NSLog(@"vector x=%f   vector y=%f",
              (self.ballPlayer.position.x - _ballShadow.position.x) * kBounceReduce,
              (self.ballPlayer.position.y - _ballShadow.position.y) * kBounceReduce);
        
        currentPhysicsAttack = 1;
        
        [_ballShadow removeFromParent];
        _isBallRolling = YES;
    }
}

#pragma mark SKPhysicsContactDelegate

// 碰撞事件
-(void)didBeginContact:(SKPhysicsContact *)contact
{
    if (!_isBallRolling) return;
    
    SKPhysicsBody * sholdToRemoveBody;
    
    //    NSLog(@"contact point.x=%f y=%f",contact.contactPoint.x,contact.contactPoint.y);
    //
    //    NSArray *nodeArray = [self nodesAtPoint:contact.contactPoint];
    //    NSLog(@"nodeArray count=%d",[nodeArray count]);
    //
    //    if ([nodeArray count]) {
    //        NSLog(@"node name=%@",((SKNode *)[nodeArray objectAtIndex:0]).name);
    //    }
    
    if((contact.bodyA == self.ballPlayer.physicsBody || contact.bodyB == self.ballPlayer.physicsBody))
        //如果我方人物球撞击到物体
    {
        
        if ((contact.bodyA == self.ballEnemy.physicsBody || contact.bodyB == self.ballEnemy.physicsBody)){
            
            if (currentPhysicsAttack == 1) {
                self.ballPlayer.physicsBody.velocity = CGVectorMake(self.ballPlayer.physicsBody.velocity.dx * kVelocityAddition,
                                                                    self.ballPlayer.physicsBody.velocity.dy * kVelocityAddition);
                
            }else if(currentPhysicsAttack == 2)
            {
                self.ballEnemy.physicsBody.velocity = CGVectorMake(self.ballEnemy.physicsBody.velocity.dx * kVelocityAddition,
                                                                   self.ballEnemy.physicsBody.velocity.dy * kVelocityAddition);
            }
            return;
        }
        
        if ((contact.bodyA == self.ballPlayer.physicsBody && [contact.bodyB.node.name isEqualToString:PP_BALL_TYPE_COMBO_NAME]) ||
            (contact.bodyB == self.ballPlayer.physicsBody && [contact.bodyA.node.name isEqualToString:PP_BALL_TYPE_COMBO_NAME]))
            //我方碰到连击球
        {
            
            if (contact.bodyA == self.ballPlayer.physicsBody) {
                [[self.ballsCombos objectAtIndex:[contact.bodyB.PPBallPhysicsBodyStatus intValue]] startComboAnimation];
            }else
            {
                [[self.ballsCombos objectAtIndex:[contact.bodyA.PPBallPhysicsBodyStatus intValue]] startComboAnimation];

            }
            
            petCombos++;
            [self.playerAndEnemySide setComboLabelText:petCombos withEnemy:enemyCombos];
            [self.playerAndEnemySide changePetMPValue:200];
            
            return;
            
        } else if ((contact.bodyA == self.ballPlayer.physicsBody &&[contact.bodyB.node.name isEqualToString:PP_BALL_TYPE_ENEMY_ELEMENT_NAME]) ||
                   (contact.bodyB == self.ballPlayer.physicsBody &&
                    [contact.bodyA.node.name isEqualToString:PP_BALL_TYPE_ENEMY_ELEMENT_NAME]))
            //我方碰到敌方属性元素球
        {
            
            
            NSNumber * emlementBodyStatus;
            
            if (contact.bodyA == self.ballPlayer.physicsBody) {
                emlementBodyStatus = contact.bodyB.PPBallPhysicsBodyStatus;
                
                if ([emlementBodyStatus intValue] >= PP_ELEMENT_NAME_TAG) {
                    
                     NSLog(@"element bodyStatus=%d",[emlementBodyStatus intValue]);
                    
                    [[self.ballsElement objectAtIndex:[emlementBodyStatus intValue]-PP_ELEMENT_NAME_TAG] startElementBallHitAnimation];
                    return;
                }

            }else
            {
                
                  NSLog(@"element bodyStatus=%d",[emlementBodyStatus intValue]);
                
                emlementBodyStatus = contact.bodyA.PPBallPhysicsBodyStatus;
               
                if ([emlementBodyStatus intValue] >= PP_ELEMENT_NAME_TAG) {
                      [[self.ballsElement objectAtIndex:[emlementBodyStatus intValue]-PP_ELEMENT_NAME_TAG] startElementBallHitAnimation];
                    return;
                }
                
            }
            
           
            
            
            
//            switch ([emlementBodyStatus intValue]) {
//                case 1:
//                {
//                    petAssimDiffEleNum ++;
//                    
//                    [self.playerAndEnemySide changePetHPValue:-100];
//                    [self addHPValueChangeLabel:-100 position:self.ballPlayer.position];
//                    
//                    //确定需要remove的元素球
//                    if (contact.bodyA == self.ballPlayer.physicsBody)
//                    {
//                        sholdToRemoveBody = contact.bodyB;
//                    }else{
//                        sholdToRemoveBody = contact.bodyA;
//                    }
//                    
//                    
//                }
//                    break;
//                    
//                default:
//                {
//                    
//                    petAssimDiffEleNum ++;
//                    
//                    [self.playerAndEnemySide changePetHPValue:-100];
//                    [self addHPValueChangeLabel:-100 position:self.ballPlayer.position];
//                    
//                    //确定需要remove的元素球
//                    if (contact.bodyA == self.ballPlayer.physicsBody)
//                    {
//                        sholdToRemoveBody = contact.bodyB;
//                    }else{
//                        sholdToRemoveBody = contact.bodyA;
//                    }
//                    
//                    
//                }
//                    break;
//            }
//            
            
            
        } else if ((contact.bodyA == self.ballPlayer.physicsBody &&
                    [contact.bodyB.node.name isEqualToString:PP_BALL_TYPE_PET_ELEMENT_NAME]) ||
                   (contact.bodyB == self.ballPlayer.physicsBody &&
                    [contact.bodyA.node.name isEqualToString:PP_BALL_TYPE_PET_ELEMENT_NAME]))
            //我方碰到我方属性元素球
        {
            
            
            NSNumber * emlementBodyStatus;
            
            if (contact.bodyA == self.ballPlayer.physicsBody) {
                emlementBodyStatus = contact.bodyB.PPBallPhysicsBodyStatus;
                
                if ([emlementBodyStatus intValue] >= PP_ELEMENT_NAME_TAG) {
                    [[self.ballsElement objectAtIndex:[emlementBodyStatus intValue]-PP_ELEMENT_NAME_TAG] startElementBallHitAnimation];
                    return;
                }
                
            }else
            {
                
                emlementBodyStatus = contact.bodyA.PPBallPhysicsBodyStatus;
                
                if ([emlementBodyStatus intValue] >= PP_ELEMENT_NAME_TAG) {
                    [[self.ballsElement objectAtIndex:[emlementBodyStatus intValue]-PP_ELEMENT_NAME_TAG] startElementBallHitAnimation];
                    return;
                }
                
            }
            
            NSLog(@"element bodyStatus=%d",[emlementBodyStatus intValue]);
            
            
            petAssimSameEleNum ++;
            [self.playerAndEnemySide changePetHPValue:100];
            [self addHPValueChangeLabel:100 position:self.ballPlayer.position];
            [self.ballPlayer startPixieHealAnimation];
            //确定需要remove的元素球
            if (contact.bodyA == self.ballPlayer.physicsBody)
            {
                sholdToRemoveBody = contact.bodyB;
            }else
            {
                sholdToRemoveBody = contact.bodyA;
            }
            
     

        }
        
        //判断当前我方是否满血
        if (self.pixiePlayer.currentHP != self.pixiePlayer.pixieHPmax)
        {
            [sholdToRemoveBody.node removeFromParent];
            [self.ballsElement removeObject:sholdToRemoveBody.node];
        }
        
    } else if ((contact.bodyA == self.ballEnemy.physicsBody || contact.bodyB == self.ballEnemy.physicsBody))
        //如果敌方人物球撞击到物体
    {
        
        if ((contact.bodyA == self.ballPlayer.physicsBody || contact.bodyB == self.ballPlayer.physicsBody)){
            
            if (currentPhysicsAttack == 1) {
                self.ballPlayer.physicsBody.velocity = CGVectorMake(self.ballPlayer.physicsBody.velocity.dx * kVelocityAddition,
                                                                    self.ballPlayer.physicsBody.velocity.dy * kVelocityAddition);
            }else if(currentPhysicsAttack == 2)
            {
                self.ballEnemy.physicsBody.velocity = CGVectorMake(self.ballEnemy.physicsBody.velocity.dx * kVelocityAddition,
                                                                   self.ballEnemy.physicsBody.velocity.dy * kVelocityAddition);
            }
            return;
        }
        
        if ((contact.bodyA == self.ballEnemy.physicsBody && [contact.bodyB.node.name isEqualToString:PP_BALL_TYPE_COMBO_NAME]) ||
            (contact.bodyB == self.ballEnemy.physicsBody && [contact.bodyA.node.name isEqualToString:PP_BALL_TYPE_COMBO_NAME]))
            //敌方碰到连击球
        {
              NSLog(@"bodyStatus=%d",[contact.bodyB.PPBallPhysicsBodyStatus intValue]);
            
            
            if (contact.bodyA == self.ballEnemy.physicsBody) {
                
                [[self.ballsCombos objectAtIndex:[contact.bodyB.PPBallPhysicsBodyStatus intValue]] startComboAnimation];
                
            }else
            {
                
                [[self.ballsCombos objectAtIndex:[contact.bodyA.PPBallPhysicsBodyStatus intValue]] startComboAnimation];
                
            }
            
            enemyCombos++;
            [self.playerAndEnemySide setComboLabelText:petCombos withEnemy:enemyCombos];
            [self.playerAndEnemySide changeEnemyMPValue:500];
            return;
        }
        else if((contact.bodyA == self.ballEnemy.physicsBody &&
                 [contact.bodyB.node.name isEqualToString:PP_BALL_TYPE_ENEMY_ELEMENT_NAME]) ||
                (contact.bodyB == self.ballEnemy.physicsBody &&
                 [contact.bodyA.node.name isEqualToString:PP_BALL_TYPE_ENEMY_ELEMENT_NAME]))
            //敌方碰到敌方属性元素球
        {
            
            
            
            NSNumber * emlementBodyStatus;
            
            if (contact.bodyA == self.ballEnemy.physicsBody) {
                emlementBodyStatus = contact.bodyB.PPBallPhysicsBodyStatus;
                
                if ([emlementBodyStatus intValue] >= PP_ELEMENT_NAME_TAG) {
                    
                    NSLog(@"element bodyStatus=%d",[emlementBodyStatus intValue]);
                    
                    [[self.ballsElement objectAtIndex:[emlementBodyStatus intValue]-PP_ELEMENT_NAME_TAG] startElementBallHitAnimation];
                    return;
                }
                
            }else
            {
                
                NSLog(@"element bodyStatus=%d",[emlementBodyStatus intValue]);
                
                emlementBodyStatus = contact.bodyA.PPBallPhysicsBodyStatus;
                
                if ([emlementBodyStatus intValue] >= PP_ELEMENT_NAME_TAG) {
                    [[self.ballsElement objectAtIndex:[emlementBodyStatus intValue]-PP_ELEMENT_NAME_TAG] startElementBallHitAnimation];
                    return;
                }
                
            }
            
            
            
            enemyAssimSameEleNum++;
            [self.playerAndEnemySide changeEnemyHPValue:100];
            [self addHPValueChangeLabel:100 position:self.ballEnemy.position];
            
            if (contact.bodyA == self.ballEnemy.physicsBody)
            {
                sholdToRemoveBody = contact.bodyB;
                
            }else
            {
                sholdToRemoveBody = contact.bodyA;
                
            }
            
        }
        else if((contact.bodyA == self.ballEnemy.physicsBody &&
                 [contact.bodyB.node.name isEqualToString:PP_BALL_TYPE_PET_ELEMENT_NAME]) ||
                (contact.bodyB == self.ballEnemy.physicsBody &&
                 [contact.bodyA.node.name isEqualToString:PP_BALL_TYPE_PET_ELEMENT_NAME]))
        {
            
            //敌方碰到我方属性元素球

            
            NSNumber * emlementBodyStatus;
            
            if (contact.bodyA == self.ballEnemy.physicsBody) {
                emlementBodyStatus = contact.bodyB.PPBallPhysicsBodyStatus;
                
                if ([emlementBodyStatus intValue] >= PP_ELEMENT_NAME_TAG) {
                    
                    NSLog(@"element bodyStatus=%d",[emlementBodyStatus intValue]);
                    
                    [[self.ballsElement objectAtIndex:[emlementBodyStatus intValue]-PP_ELEMENT_NAME_TAG] startElementBallHitAnimation];
                    return;
                }
                
            }else
            {
                
                
                emlementBodyStatus = contact.bodyA.PPBallPhysicsBodyStatus;
                NSLog(@"element bodyStatus=%d",[emlementBodyStatus intValue]);

                if ([emlementBodyStatus intValue] >= PP_ELEMENT_NAME_TAG) {
                    [[self.ballsElement objectAtIndex:[emlementBodyStatus intValue]-PP_ELEMENT_NAME_TAG] startElementBallHitAnimation];
                    return;
                }
                
            }
            
            
            switch ([emlementBodyStatus intValue]) {
                case 1:
                {
                    //森林瞬起
                    enemyAssimDiffEleNum++;
                    
                    [self.ballEnemy startPlantrootAnimation];
                    self.ballEnemy.physicsBody.velocity = CGVectorMake(0.0f, 0.0f);
                
//                    [self.playerAndEnemySide changeEnemyHPValue:-100];
//                    [self addHPValueChangeLabel:-100 position:self.ballEnemy.position];
//                    
//                    if (contact.bodyA == self.ballEnemy.physicsBody)
//                    {
//                        sholdToRemoveBody = contact.bodyB;
//                        
//                    }else
//                    {
//                        sholdToRemoveBody = contact.bodyA;
//                    }
                    
                    
                }
                    break;
                    
                default:
                {
                    
                    enemyAssimDiffEleNum++;
                    [self.playerAndEnemySide changeEnemyHPValue:-100];
                    [self addHPValueChangeLabel:-100 position:self.ballEnemy.position];
                    
                    if (contact.bodyA == self.ballEnemy.physicsBody)
                    {
                        sholdToRemoveBody = contact.bodyB;
                        
                    }else
                    {
                        sholdToRemoveBody = contact.bodyA;
                    }
                    
                    
                }
                    break;
            }
            

            
            
         
        }
        
        NSLog(@"currentHP=%f max=%f",self.pixiePlayer.currentHP,self.pixiePlayer.pixieHPmax);
        
        if (self.pixiePlayer.currentHP != self.pixiePlayer.pixieHPmax)
            //当前己方不满血
        {
            [sholdToRemoveBody.node removeFromParent];
            [self.ballsElement removeObject:sholdToRemoveBody.node];
        }
        
    } else return;
    
    
}


- (void)didEndContact:(SKPhysicsContact *)contact
{
    
}
#pragma mark BackAlert

-(void)backButtonClick:(NSString *)backName
{
    
    [self.view presentScene:self.hurdleReady transition:[SKTransition doorsOpenVerticalWithDuration:1]];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [(PPFightingMainView *)self.view changeToPassScene];
        [[NSNotificationCenter defaultCenter] postNotificationName:PP_BACK_TO_MAIN_VIEW object:PP_BACK_TO_MAIN_VIEW_FIGHTING];
    }
}

#pragma mark PauseButton

-(void)pauseBtnClick:(NSString *)stringName
{
    
    PPCustomAlertNode *alertNode = [[PPCustomAlertNode alloc] initWithFrame:CGRectMake(self.size.width/2.0f,
                                                                                       self.size.height/2.0f,
                                                                                       self.size.width, self.size.height)];
    alertNode->target = self;
    alertNode->btnClickSel = @selector(pauseMenuBtnClick:);
    [alertNode setColor:[UIColor yellowColor]];
    [alertNode showPauseMenuAlertWithTitle:@"游戏暂停了" andMessage:nil];
    [self addChild:alertNode];
    
    
}

-(void)pauseMenuBtnClick:(NSString *)btnStr
{
    NSLog(@"btnStr= %@",btnStr);
    
    if ([btnStr isEqualToString:@"button2"]) {
        [self backButtonClick:nil];
    }
    
}

#pragma mark Custom Method

// 是否所有的球都停止了滚动
-(BOOL)isAllStopRolling{
    
    if (vectorLength(self.ballPlayer.physicsBody.velocity) > kStopThreshold ) {
        return NO;
    } else {
        
        self.ballPlayer.physicsBody.velocity = CGVectorMake(0.0f, 0.0f);
        self.ballPlayer.physicsBody.resting = YES;
        
    }
    
    if (vectorLength(self.ballEnemy.physicsBody.velocity) > kStopThreshold) {
        return NO;
    } else {
        self.ballEnemy.physicsBody.velocity = CGVectorMake(0.0f, 0.0f);
        self.ballEnemy.physicsBody.resting = YES;
    }
    
    for (PPBall * tBall in self.ballsElement) {
        if (vectorLength(tBall.physicsBody.velocity) > kStopThreshold) {
            return NO;
        } else {
            tBall.physicsBody.velocity = CGVectorMake(0.0f, 0.0f);
            tBall.physicsBody.resting = YES;
        }
    }
    
    for (PPBall * tBall in self.ballsCombos) {
        if (vectorLength(tBall.physicsBody.velocity) > kStopThreshold) {
            return NO;
        } else {
            tBall.physicsBody.velocity = CGVectorMake(0.0f, 0.0f);
            tBall.physicsBody.resting = YES;
        }
    }
    
    return YES;
    
}

-(void)checkingBallsMove
{
    
    // 如果球都停止了
    if ([self isAllStopRolling] && _isBallRolling) {
        
        NSLog(@"Doing Attack and Defend");
        _isBallRolling = NO;
        
        // 刷新技能
        _isTrapEnable = NO;
        for (PPBall * tBall in self.ballsElement) [tBall setToDefaultTexture];
        
        if(currentPhysicsAttack == 1)
        {
            
            [self  showPhysicsAttackAnimation:PP_PET_PLAYER_SIDE_NODE_NAME];
            
        }else
        {
            [self  showPhysicsAttackAnimation:PP_ENEMY_SIDE_NODE_NAME];
            
        }
        
        
    }
    
}

-(void)setEnemyAtIndex:(int)index
{
    currentEnemyIndex = index;
    [self addEnemySide:PP_FIT_TOP_SIZE];
}

// 战斗结束过程
-(void)hpBeenZeroMethod:(NSString *)battlesideName
{
    if ([battlesideName isEqualToString:PP_ENEMY_SIDE_NODE_NAME])
    {
        PPBasicSpriteNode *enemyDeadContent=[[PPBasicSpriteNode alloc] initWithColor:[UIColor orangeColor] size:CGSizeMake(320, 240)];
        [enemyDeadContent setPosition:CGPointMake(160.0f, 300)];
        [self addChild:enemyDeadContent];
        
        NSDictionary *alertInfo = @{@"title":[NSString stringWithFormat:@"怪物%d号 死了",currentEnemyIndex],@"context":@"请干下一个怪物"};
        
        SKLabelNode * titleNameLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        titleNameLabel.fontSize = 13;
        titleNameLabel.fontColor = [UIColor blueColor];
        titleNameLabel.text = [alertInfo objectForKey:@"title"];
        titleNameLabel.position = CGPointMake(0.0f,50);
        [enemyDeadContent addChild:titleNameLabel];
        
        
        SKLabelNode * textContentLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        textContentLabel.fontColor = [UIColor blueColor];
        textContentLabel.text = [alertInfo objectForKey:@"context"];
        textContentLabel.fontSize = 13;
        textContentLabel.position = CGPointMake(0.0f,-50);
        [enemyDeadContent addChild:textContentLabel];
        
        [self performSelectorOnMainThread:@selector(goNextEnemy) withObject:nil afterDelay:2];
        
    } else {
        
        NSDictionary * dict = @{@"title":@"宠物死了",@"context":@"你太sb了"};
        PPCustomAlertNode * alertCustom=[[PPCustomAlertNode alloc] initWithFrame:CustomAlertFrame];
        [alertCustom showCustomAlertWithInfo:dict];
        [self addChild:alertCustom];
        
    }
}

-(void)goNextEnemy
{
    [self.hurdleReady setCurrentHurdle:currentEnemyIndex];
    [self.view presentScene:self.hurdleReady transition:[SKTransition doorwayWithDuration:1]];
}

// 添加敌方单位各个元素
-(void)addEnemySide:(CGFloat)direct
{
    if(self.playerAndEnemySide != nil){
        [self.playerAndEnemySide removeFromParent];
        self.playerAndEnemySide = nil;
    }
    
    if(self.ballEnemy != nil){
        [self.ballEnemy removeFromParent];
        self.ballEnemy = nil;
    }
    
    //    NSDictionary * dictEnemy = [NSDictionary dictionaryWithContentsOfFile:
    //                                [[NSBundle mainBundle]pathForResource:@"EnemyInfo" ofType:@"plist"]];
    //
    //    NSArray *enemys = [[NSArray alloc] initWithArray:[dictEnemy objectForKey:@"EnemysInfo"]];
    //    NSDictionary *chooseEnemyDict = [NSDictionary dictionaryWithDictionary:[enemys objectAtIndex:currentEnemyIndex]];
    //    PPPixie *eneplayerPixie = [PPPixie birthEnemyPixieWithPetsInfo:chooseEnemyDict];
    
    
    // 添加 Ball of Enemey
    self.ballEnemy = self.pixieEnemy.pixieBall;
    self.ballEnemy.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y + PP_FIT_TOP_SIZE);
    self.ballEnemy.physicsBody.categoryBitMask = EntityCategoryBall;
    self.ballEnemy.physicsBody.contactTestBitMask = EntityCategoryBall;
    [self addChild:self.ballEnemy];
    
    self.playerAndEnemySide = [[PPBattleInfoLayer alloc] init];
    [self.playerAndEnemySide setColor:[UIColor purpleColor]];
    self.playerAndEnemySide.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height-40-direct);
    self.playerAndEnemySide.name = PP_ENEMY_SIDE_NODE_NAME;
    self.playerAndEnemySide.size = CGSizeMake(self.size.width, 80.0f);
    self.playerAndEnemySide.target = self;
    self.playerAndEnemySide.hpBeenZeroSel = @selector(hpBeenZeroMethod:);
    self.playerAndEnemySide.hpChangeEnd = @selector(hpChangeEndAnimate:);
    self.playerAndEnemySide.skillSelector = @selector(skillPlayerShowBegin:);
    self.playerAndEnemySide.pauseSelector = @selector(pauseBtnClick:);
    //    self.playerAndEnemySide.showInfoSelector = @selector(showCurrentEnemyInfo:);
    [self.playerAndEnemySide setSideElements:self.pixiePlayer andEnemy:self.pixieEnemy andSceneString:sceneTypeString];
    [self addChild:self.playerAndEnemySide];
    
    
    currentEnemyIndex += 1;
    
}


// 添加四周的墙
-(void)addWalls:(CGSize)nodeSize atPosition:(CGPoint)nodePosition
{
    SKSpriteNode * wall = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:nodeSize];
    wall.position = nodePosition;
    wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
    wall.physicsBody.affectedByGravity = NO;
    wall.physicsBody.dynamic = NO;
    wall.physicsBody.friction = 0.1;
    wall.physicsBody.categoryBitMask = EntityCategoryWall;
    //wall.physicsBody.contactTestBitMask = EntityCategoryBall;
    //wall.physicsBody.collisionBitMask = 0;
    
    [self addChild:wall];
}

// 结算combo添加元素球
-(void)creatCombosTotal
{
    [self addRandomBalls:petCombos
             withElement:self.pixiePlayer.pixieBall.ballElementType
             andNodeName:PP_BALL_TYPE_PET_ELEMENT_NAME];
    
    /*
     NSLog(@"pet element=%ld combos=%d  enemy element=%ld combos=%d",
     self.pixiePlayer.pixieBall.ballElementType,
     petCombos,
     self.pixieEnemy.pixieBall.ballElementType,
     enemyCombos);
     */
    
    [self addRandomBalls:enemyCombos withElement:self.pixieEnemy.pixieBall.ballElementType andNodeName:PP_BALL_TYPE_ENEMY_ELEMENT_NAME];
    
    enemyCombos = 0;
    petCombos = 0;
    
    [self.playerAndEnemySide setComboLabelText:petCombos withEnemy:enemyCombos];
}

// 添加随机的元素球
-(void)addRandomBalls:(int)number withElement:(PPElementType)element andNodeName:(NSString *)nodeName
{
    if (number <= 0) return;
    
    int countToGenerate=number/kBallSustainRounds;
    int lastBallSustainRounds = number%kBallSustainRounds;
    
    if (countToGenerate == 0) {
        
        PPBall * tBall = [PPBall ballWithElement:element];
        tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y+PP_FIT_TOP_SIZE);
        tBall.ballElementType = element;
        tBall.physicsBody.node.name = nodeName;
        tBall.name =nodeName;
        tBall.physicsBody.categoryBitMask = EntityCategoryBall;
        tBall.sustainRounds = lastBallSustainRounds;
        tBall.physicsBody.contactTestBitMask = EntityCategoryBall;
        [tBall setRoundsLabel:tBall.sustainRounds];
        
        
        [self addChild:tBall];
        [self.ballsElement addObject:tBall];
        return;
        
    }
    
    if (lastBallSustainRounds != 0) {
        countToGenerate++;
    }
    
    if (countToGenerate > 5) {
        countToGenerate = 5;
        lastBallSustainRounds = kBallSustainRounds;
    }
    
    for (int i = 0; i < countToGenerate; i++) {
        
        if (i != countToGenerate-1) {
            
            PPBall * tBall = [PPBall ballWithElement:element];
            tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y+PP_FIT_TOP_SIZE);
            tBall.ballElementType = element;
            tBall.physicsBody.node.name = nodeName;
            tBall.name = nodeName;
            tBall.physicsBody.categoryBitMask = EntityCategoryBall;
            tBall.sustainRounds = kBallSustainRounds;
            NSLog(@"kBallSustainRounds = %d",kBallSustainRounds);
            
            [tBall setRoundsLabel:tBall.sustainRounds];
            
            tBall.physicsBody.contactTestBitMask = EntityCategoryBall;
            [self addChild:tBall];
            
            [self.ballsElement addObject:tBall];
            
        }else
        {
            if (lastBallSustainRounds!=0) {
                PPBall * tBall = [PPBall ballWithElement:element];
                tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y+PP_FIT_TOP_SIZE);
                tBall.ballElementType = element;
                tBall.physicsBody.node.name = nodeName;
                tBall.name = nodeName;
                tBall.physicsBody.categoryBitMask = EntityCategoryBall;
                tBall.sustainRounds = lastBallSustainRounds;
                tBall.physicsBody.contactTestBitMask = EntityCategoryBall;
                NSLog(@"lastBallSustainRounds = %d",lastBallSustainRounds);
                
                [tBall setRoundsLabel:tBall.sustainRounds];
                [self addChild:tBall];
                
                [self.ballsElement addObject:tBall];
                
            }
        }
    }
}

-(void)changeBallsRoundsEnd
{
    for (int i = 0; i < [self.ballsElement count]; i++) {
        
        PPBall * tBall = [self.ballsElement objectAtIndex:i];
        tBall.sustainRounds--;
        [tBall setRoundsLabel:tBall.sustainRounds];
        
        if (tBall.sustainRounds <= 0) {
            [tBall removeFromParent];
            [self.ballsElement removeObject:tBall];
        }
        
    }
}

-(void)setPhysicsTagValue
{
    
    for (int i = 0; i < [self.ballsElement count]; i++) {
        
        PPBall * tBall = [self.ballsElement objectAtIndex:i];
        
        tBall.physicsBody.PPBallPhysicsBodyStatus=[NSNumber numberWithInt:PP_ELEMENT_NAME_TAG+i];
        
    }
    
}

//-(void)removeBallsForRoundsEnd
//{
//    for (int i = 0; i < [self.ballsElement count]; i++) {
//        PPBall * tBall = [self.ballsElement objectAtIndex:i];
//        if (tBall.sustainRounds <= 0) {
//            [tBall removeFromParent];
//            [self.ballsElement removeObject:tBall];
//        }
//    }
//}


#pragma mark Rounds and Turns

-(void)roundRotateBegin
{
    roundActionNum = 0;
    [self setPlayerSideRoundRunState];
    [self startBattle:@"回合开始"];
}

-(void)roundRotateMoved:(NSString *)nodeName
{
    [self setPlayerSideRoundRunState];
    
    roundActionNum += 1;
    
    //如果回合的一半
    if(roundActionNum==1)
    {
        if ([nodeName isEqualToString:PP_PET_PLAYER_SIDE_NODE_NAME]) {
            
            //            [self physicsAttackBegin:PP_ENEMY_SIDE_NODE_NAME];
            [self enemyAttackDecision];
        }else
        {
            [self setPlayerSideRoundEndState];
        }
    }else
    {
        [self roundRotateEnd];
    }
}

-(void)roundRotateEnd
{
    roundActionNum = 0;
    roundIndex += 1;
    
    [self setRoundEndNumberLabel:[NSString stringWithFormat:@"%d回合结束",roundIndex]];
    [self setPlayerSideRoundRunState];
    [self performSelectorOnMainThread:@selector(roundRotateBegin) withObject:nil afterDelay:3];
}

#pragma mark Battle Procceed

-(void)startBattle:(NSString *)text
{
    PPBasicLabelNode *labelNode = (PPBasicLabelNode *)[self childNodeWithName:@"RoundLabel"];
    if (labelNode) {
        [labelNode removeFromParent];
    }
    
    PPBasicLabelNode * additonLabel= [[PPBasicLabelNode alloc] init];
    additonLabel.name  = @"RoundLabel";
    additonLabel.fontColor = [UIColor yellowColor];
    additonLabel.position = CGPointMake(160.0f, 200.0f);
    [additonLabel setText:text];
    [self addChild:additonLabel];
    
    SKAction * actionScale = [SKAction scaleBy:2.0 duration:1];
    [additonLabel runAction:actionScale completion:^{
        [additonLabel removeFromParent];
        
        //判断敌方和我方谁先发动攻击
        //        if (arc4random()%200==0) {
        //
        //            [self setPlayerSideRoundEndState];
        //
        //        }else
        //        {
        
        [self enemyAttackDecision];
        
        
        //                 [self physicsAttackBegin:PP_ENEMY_SIDE_NODE_NAME];
        //                    if (arc4random()%2==0) {
        //                                    [self physicsAttackBegin:PP_ENEMY_SIDE_NODE_NAME];
        //                    }else
        //                    {
        //
        //                    }
        //        }
    }];
    [self changeBallsRoundsEnd];
    [self creatCombosTotal];
    [self setPhysicsTagValue];
}

-(void)enemyAttackDecision
{
    int decision = arc4random() % 2;
    
    switch (decision) {
        case 0:
        {
            [self physicsAttackBegin:PP_ENEMY_SIDE_NODE_NAME];
        }
            break;
        case 1:
        {
            [self skllEnemyBegain:[self.playerAndEnemySide.currentPPPixieEnemy.pixieSkills objectAtIndex:0]];
        }
            break;
        default:
        {
        }
            break;
    }
}

-(void)enemyDoPhysicsAttack
{
    _isBallRolling = YES;
    currentPhysicsAttack = 2;
    
    float randomX = arc4random() % (int)(kAutoAttackMax * 2) - kAutoAttackMax;
    float randomY = arc4random() % (int)(kAutoAttackMax * 2) - kAutoAttackMax;
    [self.ballEnemy.physicsBody applyImpulse:CGVectorMake(randomX, randomY)];
    [self setPlayerSideRoundRunState];
    _isBallRolling = YES;
}
-(void)addHPValueChangeLabel:(int)value position:(CGPoint)labelPosition
{
    
    PPBasicLabelNode *additonLabel= [[PPBasicLabelNode alloc] init];
    additonLabel.name  = @"hpchange";
    additonLabel.fontColor = [UIColor redColor];
    additonLabel.position = labelPosition;
    if (value>0) {
        
        [additonLabel setText:[NSString stringWithFormat:@"+%d",value]];
        
    }else
    {
        [additonLabel setText:[NSString stringWithFormat:@"%d",value]];
        
    }
    [self addChild:additonLabel];
    
    
    SKAction *actionScale = [SKAction scaleBy:2.0 duration:1];
    [additonLabel runAction:actionScale completion:^{
        [additonLabel removeFromParent];
    }];
    
    
}
-(void)setRoundEndNumberLabel:(NSString *)text
{
    PPBasicLabelNode *additonLabel= [[PPBasicLabelNode alloc] init];
    additonLabel.name  = @"RoundLabel";
    additonLabel.fontColor = [UIColor redColor];
    additonLabel.position = CGPointMake(160.0f, 200.0f);
    [additonLabel setText:text];
    [self addChild:additonLabel];
    
    SKAction *actionScale = [SKAction scaleBy:2.0 duration:1];
    [additonLabel runAction:actionScale completion:^{
        [additonLabel removeFromParent];
    }];
    
}

-(void)setPlayerSideRoundRunState
{
    isNotSkillRun = YES;
    [self.playerSkillSide setSideSkillButtonDisable];
}

-(void)setPlayerSideRoundEndState
{
    isNotSkillRun = NO;
    [self.playerSkillSide setSideSkillButtonEnable];
}

-(void)physicsAttackBegin:(NSString *)nodeName
{
    NSLog(@"nodeName=%@",nodeName);
    
    if ([nodeName isEqual:PP_PET_PLAYER_SIDE_NODE_NAME]) {
        /*
         CGFloat hpchangresult = [PPDamageCaculate
         bloodChangeForPhysicalAttack:self.playerSide.currentPPPixie.currentAP
         andAddition:self.playerSide.currentPPPixie.pixieBuffs.attackAddition
         andOppositeDefense:self.playerAndEnemySide.currentPPPixieEnemy.currentDP
         andOppositeDefAddition:self.playerAndEnemySide.currentPPPixieEnemy.pixieBuffs.defenseAddition
         andDexterity:self.playerAndEnemySide.currentPPPixieEnemy.currentDEX];
         */
    } else {
        /*
         CGFloat hpchangresult = [PPDamageCaculate
         bloodChangeForPhysicalAttack:self.playerAndEnemySide.currentPPPixieEnemy.currentAP
         andAddition:self.playerAndEnemySide.currentPPPixieEnemy.pixieBuffs.attackAddition
         andOppositeDefense:self.playerSide.currentPPPixie.currentDP
         andOppositeDefAddition:self.playerSide.currentPPPixie.pixieBuffs.defenseAddition
         andDexterity:self.playerSide.currentPPPixie.currentDEX];
         */
        
        [self setPlayerSideRoundRunState];
        
        PPBasicLabelNode * labelNode=(PPBasicLabelNode *)[self childNodeWithName:@"EnemyPhysics"];
        if (labelNode) [labelNode removeFromParent];
        
        
        PPBasicLabelNode * additonLabel= [[PPBasicLabelNode alloc] init];
        additonLabel.name  = @"EnemyPhysics";
        additonLabel.position = CGPointMake(160.0f, 200.0f);
        [additonLabel setText:@"怪物弹球攻击"];
        [self addChild:additonLabel];
        
        SKAction * actionScale = [SKAction scaleBy:2.0 duration:1];
        [additonLabel runAction:actionScale completion:^{
            [additonLabel removeFromParent];
            [self enemyDoPhysicsAttack];
        }];
        
    }
    
}

-(void)ballAttackEnd:(NSInteger)ballsCount
{
    
    [self physicsAttackBegin:PP_PET_PLAYER_SIDE_NODE_NAME];
    
    SKLabelNode *skillNameLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [skillNameLabel setFontSize:20];
    skillNameLabel.fontColor = [UIColor whiteColor];
    skillNameLabel.text = @"弹球攻击";
    skillNameLabel.position = CGPointMake(100.0f,221);
    [self addChild:skillNameLabel];
    
    
    SKLabelNode *ballsLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [ballsLabel setFontSize:20];
    ballsLabel.fontColor = [UIColor whiteColor];
    ballsLabel.text = [NSString stringWithFormat:@"吸收球数:%d",(int)ballsCount];
    ballsLabel.position = CGPointMake(200.0f,221);
    [self addChild:ballsLabel];
    
    
    SKAction *action = [SKAction fadeAlphaTo:0.0f duration:5];
    [skillNameLabel runAction:action];
    [ballsLabel runAction:action];
    
}


-(void)skillPlayerShowBegin:(NSDictionary *)skillInfo
{
    
    CGFloat mpToConsume = [[skillInfo objectForKey:@"skillmpchange"] floatValue];
    NSLog(@"currentMP=%f mptoConsume=%f",self.playerAndEnemySide.currentPPPixie.currentMP,mpToConsume);
    NSLog(@"skillInfo=%@",skillInfo);
    
    
    if (self.playerAndEnemySide.currentPPPixie.currentMP<fabsf(mpToConsume)) {
        
        PPBasicLabelNode *labelNode=(PPBasicLabelNode *)[self childNodeWithName:@"mpisnotenough"];
        if (labelNode) {
            [labelNode removeFromParent];
        }
        
        
        PPBasicLabelNode *additonLabel= [[PPBasicLabelNode alloc] init];
        additonLabel.name  = @"mpisnotenough";
        additonLabel.fontColor = [UIColor redColor];
        additonLabel.position = CGPointMake(160.0f, 200.0f);
        [additonLabel setText:@"能量不足。"];
        [self addChild:additonLabel];
        
        
        SKAction *actionScale = [SKAction scaleBy:2.0 duration:1];
        [additonLabel runAction:actionScale completion:^{
            [additonLabel removeFromParent];
            
        }];
        
        return ;
    }else
    {
        
        [self.playerAndEnemySide changePetMPValue:mpToConsume];
        
    }
    
    
    
    NSLog(@"skillInfo=%@",skillInfo);
    
    switch ([[skillInfo objectForKey:@"skilltype"] intValue]) {
            
        case 0:
        {
            [self showSkillEventBegin:skillInfo];
        }
            break;
            
        case 1:
        {
            
            if ([[skillInfo objectForKey:@"skillname"] isEqualToString:@"森林瞬起"]) {
                
//                NSMutableArray *animanArryay = [[NSMutableArray alloc] init];
//                
//                for (int i=0; i <10; i++) {
//                    SKTexture * temp = [[TextureManager ball_magic] textureNamed:[NSString stringWithFormat:@"magic_ball_00%02d",i]];
//                    [animanArryay addObject:temp];
//                }
                
                
                for (PPBall * tBall in self.ballsElement) {
                    if (tBall.ballElementType == PPElementTypePlant) {
                        tBall.physicsBody.PPBallPhysicsBodyStatus = @1;
//                        [tBall runAction:[SKAction animateWithTextures:animanArryay timePerFrame:0.05f]];
                        [tBall startMagicballAnimation];
                    }
                }
            }
            
            
            if ([[skillInfo objectForKey:@"skillname"] isEqualToString:@"木系掌控"]) {
                for (PPBall * tBall in self.ballsElement) {
                    if ([tBall.name isEqualToString:@"ball_plant"]) {
                        
                        //                    [tBall runAction:[SKAction moveTo:CGPointMake(tBall.position.x-10, tBall.position.y-20) duration:2]];
                        
                        [tBall runAction:[SKAction moveBy:CGVectorMake((self.ballPlayer.position.x - tBall.position.x)/2.0f,
                                                                       (self.ballPlayer.position.y - tBall.position.y)/2.0f)
                                                 duration:2]];
                    }
                }
                
            }
            
            [self roundRotateMoved:PP_PET_PLAYER_SIDE_NODE_NAME];
            
        }
            break;
            
        case 2:
        {
            [self showSkillEventBegin:skillInfo];
        }
            break;
            
        case 3:
        {
            [self showSkillEventBegin:skillInfo];
        }
            break;
            
        default:
            break;
    }
    
    
}

-(void)skllEnemyBegain:(NSDictionary *)skillInfo
{
    
    NSLog(@"skillInfo=%@",skillInfo);
    [self showEnemySkillEventBegin:skillInfo];
    
}

-(void)hpChangeEndAnimate:(NSString *)battlesideName
{
    
    NSLog(@"battlesideName=%@",battlesideName);
    
    
}

#pragma mark Physics Attack show
-(int)physicsAttackHPChangeValueCalculate
{
    
    return 300;
    
}
-(void)showPhysicsAttackAnimation:(NSString *)attackSide
{
    
    
    if ([attackSide isEqualToString:PP_PET_PLAYER_SIDE_NODE_NAME]) {
        
        SKSpriteNode *skillAnimate = [SKSpriteNode spriteNodeWithImageNamed:@"变身效果01000"];
        skillAnimate.size = CGSizeMake(self.frame.size.width, 242);
        skillAnimate.position = CGPointMake(160.0f,self.size.height/2.0f);
        [self addChild:skillAnimate];
        
        
        SKLabelNode *skillNameLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        skillNameLabel.fontColor = [UIColor blueColor];
        skillNameLabel.text = @"宠物物理攻击";
        skillNameLabel.position = CGPointMake(0.0f,100.0f);
        [skillAnimate addChild:skillNameLabel];
        
        
        SKLabelNode *valueChangeLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        valueChangeLabel.fontColor = [UIColor blueColor];
        valueChangeLabel.text = [NSString stringWithFormat:@"造成伤害：%d",[self physicsAttackHPChangeValueCalculate]];
        valueChangeLabel.position = CGPointMake(0.0f,70.0f);
        [skillAnimate addChild:valueChangeLabel];
        
        
        
        NSMutableArray *textureNameArray=[[NSMutableArray alloc] init];
        @synchronized(textureNameArray)
        {
            for (int i=1; i <= 43; i++) {
                NSString *textureName = [NSString stringWithFormat:@"变身效果01%03d.png", i];
                SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
                [textureNameArray addObject:temp];
                
            }
        }
        SKAction *action1=[SKAction animateWithTextures:textureNameArray timePerFrame:0.03f];
        SKAction *action2=[SKAction scaleTo:1.5 duration:1];
        
        NSArray *actionArray = [NSArray arrayWithObjects:action1,action2, nil];
        SKAction *actionQueue=[SKAction sequence:actionArray];
        [skillAnimate runAction:actionQueue
                     completion:^{
                         
                         [skillAnimate removeFromParent];
                         
                         [self.playerAndEnemySide changeEnemyHPValue:-[self physicsAttackHPChangeValueCalculate]];
                         
                         [self roundRotateMoved:attackSide];
                         
                         
                         
                     }];
        
        
        
    }else
    {
        
        
        SKSpriteNode *skillAnimate = [SKSpriteNode spriteNodeWithImageNamed:@"变身效果01000"];
        skillAnimate.size = CGSizeMake(self.frame.size.width, 242);
        skillAnimate.position = CGPointMake(160.0f,self.size.height/2.0f);
        [self addChild:skillAnimate];
        
        
        
        SKLabelNode *skillNameLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        skillNameLabel.fontColor = [UIColor blueColor];
        skillNameLabel.text = @"怪物物理攻击";
        skillNameLabel.position = CGPointMake(0.0f,100.0f);
        [skillAnimate addChild:skillNameLabel];
        
        
        
        SKLabelNode *valueChangeLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        valueChangeLabel.fontColor = [UIColor blueColor];
        valueChangeLabel.text = [NSString stringWithFormat:@"造成伤害：%d",[self physicsAttackHPChangeValueCalculate]];
        valueChangeLabel.position = CGPointMake(0.0f,70.0f);
        [skillAnimate addChild:valueChangeLabel];
        
        
        
        NSMutableArray *textureNameArray=[[NSMutableArray alloc] init];
        @synchronized(textureNameArray)
        {
            for (int i=1; i <= 43; i++) {
                NSString *textureName = [NSString stringWithFormat:@"变身效果01%03d.png", i];
                SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
                [textureNameArray addObject:temp];
                
            }
        }
        SKAction *action1=[SKAction animateWithTextures:textureNameArray timePerFrame:0.03f];
        SKAction *action2=[SKAction scaleTo:1.5 duration:1];
        
        NSArray *actionArray = [NSArray arrayWithObjects:action1,action2, nil];
        SKAction *actionQueue=[SKAction sequence:actionArray];
        [skillAnimate runAction:actionQueue
                     completion:^{
                         
                         [skillAnimate removeFromParent];
                         [self.playerAndEnemySide changePetHPValue:-[self physicsAttackHPChangeValueCalculate]];
                         
                         [self roundRotateMoved:attackSide];
                         
                     }];
        
    }
    
}



#pragma mark SkillBeginAnimateDelegate

-(void)showEnemySkillEventBegin:(NSDictionary *)skillInfo
{
    [self setPlayerSideRoundRunState];
    
    PPSkillNode *skillNode = [PPSkillNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(self.size.width, 300)];
    skillNode.name = PP_ENEMY_SKILL_SHOW_NODE_NAME;
    skillNode.delegate = self;
    skillNode.position = CGPointMake(self.size.width/2.0f, 250.0f+PP_FIT_TOP_SIZE);
    [self addChild:skillNode];
    
    NSLog(@"skillInfo=%@",skillInfo);
    [skillNode showSkillAnimate:skillInfo];
}

-(void)showSkillEventBegin:(NSDictionary *)skillInfo
{
    PPSkillNode * skillNode = [PPSkillNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(self.size.width, 300.0f)];
    skillNode.delegate = self;
    skillNode.name = PP_PET_SKILL_SHOW_NODE_NAME;
    skillNode.position = CGPointMake(self.size.width/2.0f, 250.0f+PP_FIT_TOP_SIZE);
    [self addChild:skillNode];
    NSLog(@"skillInfo=%@",skillInfo);
    
    [skillNode showSkillAnimate:skillInfo];
}

#pragma mark SkillEndAnimateDelegate

-(void)skillEndEvent:(PPSkill *)skillInfo withSelfName:(NSString *)nodeName
{
    
    NSLog(@"skillInfo=%@ HP:%f MP:%f",skillInfo,skillInfo.HPChangeValue,skillInfo.MPChangeValue);
    
    if ([nodeName isEqualToString:PP_ENEMY_SKILL_SHOW_NODE_NAME])
    {
        if (skillInfo.skillObject ==1) {
            [self.playerAndEnemySide changePetHPValue:skillInfo.HPChangeValue];
        } else {
            [self.playerAndEnemySide changeEnemyHPValue:skillInfo.HPChangeValue];
        }
        [self roundRotateMoved:PP_ENEMY_SIDE_NODE_NAME];
        
    }else {
        
        if (skillInfo.skillObject ==1) {
            [self.playerAndEnemySide changeEnemyHPValue:skillInfo.HPChangeValue];
        } else {
            [self.playerAndEnemySide changePetHPValue:skillInfo.HPChangeValue];
        }
        
        [self roundRotateMoved:PP_PET_PLAYER_SIDE_NODE_NAME];
        
    }
}

@end
