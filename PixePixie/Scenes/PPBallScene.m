
#import "PPBallScene.h"

#define SPACE_BOTTOM 60
#define BALL_RANDOM_X kBallSize / 2 + arc4random() % (int)(320 - kBallSize)
#define BALL_RANDOM_Y kBallSize / 2 + arc4random() % (int)(362 - kBallSize)+SPACE_BOTTOM
static const CGFloat criticalValue=20.1;  //临界值
static const CGFloat dampingValue =1.5;    //衰减系数

static const uint32_t kBallCategory      =  0x1 << 0;
static const uint32_t kGroundCategory    =  0x1 << 1;

@interface PPBallScene () <SKPhysicsContactDelegate,UIAlertViewDelegate>

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

@implementation PPBallScene
@synthesize choosedEnemys;

-(id)initWithSize:(CGSize)size
           PixieA:(PPPixie *)pixieA
           PixieB:(NSArray *)enemyS{
    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor blackColor];
        self.choosedEnemys=enemyS;
        
      
     
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
        _isTrapEnable = NO;
        
       
        // demo 预加载 动画 frames
        _trapFrames = [[NSMutableArray alloc] init];
        
        for (int i=1; i <= 40; i++) {
            NSString * textureName = [NSString stringWithFormat:@"陷阱%04d.png", i];
            SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
            [_trapFrames addObject:temp];
        }
        
        
        
       self.playerSide=[[PPBattleSideNode alloc] init];
        self.playerSide.position= CGPointMake(self.size.width/2.0f, 30+directFori5);
        self.playerSide.size =  CGSizeMake(self.size.width, 60);
        self.playerSide.name = PP_PET_PLAYER_SIDE_NODE_NAME;
        self.playerSide.target=self;
        self.playerSide.skillSelector=@selector(skillPlayerShowBegain:);
        self.playerSide.physicsAttackSelector=@selector(physicsAttackBegin:);
        self.playerSide.hpBeenZeroSel = @selector(hpBeenZeroMethod:);
        [self.playerSide setColor:[UIColor grayColor]];
        [self.playerSide setSideElementsForPet:pixieA];
        [self addChild:self.playerSide];

        currentEnemyIndex = 0;
        [self addEnemySide:directFori5];
        

        
//        // demo 添加 Skill Button
//        _btSkill = [SKSpriteNode spriteNodeWithImageNamed:@"skill_plant.png"];
//        _btSkill.size = CGSizeMake(30, 30);
//        _btSkill.name = @"bt_skill";
//        _btSkill.position = CGPointMake(280, 45+directFori5);
//        [self addChild:_btSkill];
        
        
        
        // 添加 Walls
        CGFloat tWidth = 320.0f;
        
        CGFloat tHeight = 362.0f;
        
        if (CurrentDeviceRealSize.height>500) {
            
            
            [self addWalls:CGSizeMake(tWidth, kWallThick*2) atPosition:CGPointMake(tWidth / 2, tHeight + SPACE_BOTTOM+directFori5)];
            [self addWalls:CGSizeMake(tWidth, kWallThick*2) atPosition:CGPointMake(tWidth / 2, 0 + SPACE_BOTTOM+directFori5)];
            [self addWalls:CGSizeMake(kWallThick*2, tHeight) atPosition:CGPointMake(0, tHeight / 2 + SPACE_BOTTOM)];
            [self addWalls:CGSizeMake(kWallThick*2, tHeight) atPosition:CGPointMake(tWidth, tHeight / 2 + SPACE_BOTTOM)];
            
            // 添加 Ball of Self
            self.ballPlayer = pixieA.pixieBall;
            self.ballPlayer.name = @"ball_player";
            self.ballPlayer.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y+directFori5);
            self.ballPlayer.physicsBody.categoryBitMask = kBallCategory;
            self.ballPlayer.physicsBody.contactTestBitMask = kBallCategory;
            [self addChild:self.ballPlayer];
            
            
        }else
        {
            
            [self addWalls:CGSizeMake(tWidth, kWallThick*2) atPosition:CGPointMake(tWidth / 2, tHeight + SPACE_BOTTOM)];
            [self addWalls:CGSizeMake(tWidth, kWallThick*2) atPosition:CGPointMake(tWidth / 2, 0 + SPACE_BOTTOM)];
            [self addWalls:CGSizeMake(kWallThick*2, tHeight) atPosition:CGPointMake(0, tHeight / 2 + SPACE_BOTTOM)];
            [self addWalls:CGSizeMake(kWallThick*2, tHeight) atPosition:CGPointMake(tWidth, tHeight / 2 + SPACE_BOTTOM)];
            
            // 添加 Ball of Self
            self.ballPlayer = pixieA.pixieBall;
            self.ballPlayer.name = @"ball_player";
            self.ballPlayer.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);
            self.ballPlayer.physicsBody.categoryBitMask = kBallCategory;
            self.ballPlayer.physicsBody.contactTestBitMask = kBallCategory;
            [self addChild:self.ballPlayer];
            
        }

      
        
        SKEmitterNode *snow = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"ballTest" ofType:@"sks"]];
        snow.name=@"ball_player";
        snow.position = CGPointMake(0.0f, 0.0f);
        [self.ballPlayer addChild:snow];
        snow.targetNode = self;
        
        
       
        // 添加 Balls of Element
        self.ballsElement = [[NSMutableArray alloc] init];
        if (CurrentDeviceRealSize.height>500) {
            for (int i = 0; i < 10; i++) {
                PPBall * tBall = [PPBall ballWithElement:i%5+1];
                tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y+directFori5);
                tBall.physicsBody.categoryBitMask = kBallCategory;
                tBall.physicsBody.contactTestBitMask = kBallCategory;
                [self addChild:tBall];
                [self.ballsElement addObject:tBall];
            }
        }else
        {
            for (int i = 0; i < 10; i++) {
                
                PPBall * tBall = [PPBall ballWithElement:i%5+1];
                tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);
                tBall.physicsBody.categoryBitMask = kBallCategory;
                tBall.physicsBody.contactTestBitMask = kBallCategory;
                [self addChild:tBall];
                [self.ballsElement addObject:tBall];
            }
        }
      
        
        [self addRandomBalls:5];
        
        [self setBackTitleText:@"退出战斗" andPositionY:450.0f];

    }
    return self;
}

#pragma mark SkillShow
-(void)physicsAttackBegin:(NSString *)nodeName
{
    NSLog(@"nodeName=%@",nodeName);
    if ([nodeName isEqual:PP_PET_PLAYER_SIDE_NODE_NAME]) {
        
        CGFloat hpchangresult = [[PPDamageCaculate getInstance]
                                 bloodChangeForPhysicalAttack:self.playerSide.currentPPPixie.currentAP
                                 andAddition:self.playerSide.currentPPPixie.pixieBuffs.attackAddition
                                 andOppositeDefense:self.enemySide.currentPPPixieEnemy.currentDP
                                 andOppositeDefAddition:self.enemySide.currentPPPixieEnemy.pixieBuffs.defenseAddition
                                 andDexterity:self.enemySide.currentPPPixieEnemy.currentDEX];
        
        [self.enemySide changeHPValue:hpchangresult];
        NSLog(@"currentHP=%f",self.enemySide.currentPPPixieEnemy.currentHP);
        
        if (self.enemySide.currentPPPixieEnemy.currentHP <= 0)
        {
            
        }
    } else {
        CGFloat hpchangresult = [[PPDamageCaculate getInstance]
                                 bloodChangeForPhysicalAttack:self.enemySide.currentPPPixieEnemy.currentAP
                                 andAddition:self.enemySide.currentPPPixieEnemy.pixieBuffs.attackAddition
                                 andOppositeDefense:self.playerSide.currentPPPixie.currentDP
                                 andOppositeDefAddition:self.playerSide.currentPPPixie.pixieBuffs.defenseAddition
                                 andDexterity:self.playerSide.currentPPPixie.currentDEX];
        
        [self.playerSide changeHPValue:hpchangresult];
    }
    
}

-(void)ballAttackEnd:(NSInteger)ballsCount
{
    CGFloat ballAttackHpChange = [[PPDamageCaculate getInstance]
                                  bloodChangeForBallAttack:YES
                                  andPet:self.playerSide.currentPPPixie
                                  andEnemy:self.enemySide.currentPPPixieEnemy];
    
    [self.enemySide changeHPValue:ballAttackHpChange];
    
    PPSkillNode *skillNode = [PPSkillNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(self.size.width, 300)];
    skillNode.delegate = self;
    skillNode.name = PP_PET_SKILL_SHOW_NODE_NAME;
    skillNode.position = CGPointMake(self.size.width/2.0f, 250.0f);
    [self addChild:skillNode];
    
    
    SKLabelNode *skillNameLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [skillNameLabel setFontSize:20];
    skillNameLabel.fontColor = [UIColor whiteColor];
    skillNameLabel.text = @"弹球攻击";
    skillNameLabel.position = CGPointMake(100.0f,221);
    [self addChild:skillNameLabel];
    
    
    SKLabelNode *ballsLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    [ballsLabel setFontSize:20];
    ballsLabel.fontColor = [UIColor whiteColor];
    ballsLabel.text = [NSString stringWithFormat:@"吸收球数:%d",(int)ballsCount];
    ballsLabel.position = CGPointMake(200.0f,221);
    [self addChild:ballsLabel];
    
    SKAction *action = [SKAction fadeAlphaTo:0.0f duration:5];

    [skillNameLabel runAction:action];
    [ballsLabel runAction:action];
    
    [skillNode showSkillAnimate:nil];

//
//        // 添加少了的球
//        [self addRandomBalls:(kBallNumberMax - (int)self.ballsElement.count)];
//        // 刷新技能

}
-(void)setAdditionLabel:(CGFloat)addition
{
    PPBasicLabelNode *labelNode=(PPBasicLabelNode *)[self childNodeWithName:@"additonLabel"];
    if (labelNode) {
        [labelNode removeFromParent];
    }
    
    PPBasicLabelNode *additonLabel= [[PPBasicLabelNode alloc] init];
    additonLabel.name  = @"additonLabel";
    additonLabel.position = CGPointMake(160.0f, 200.0f);
    [additonLabel setText:[NSString stringWithFormat:@"%f",addition*100]];
    [self addChild:additonLabel];
    
    SKAction *actionScale=[SKAction scaleBy:2.0 duration:0.5];
    [additonLabel runAction:actionScale completion:^{
    

        [additonLabel removeFromParent];
        
    }];
    
}

-(void)skillPlayerShowBegain:(NSDictionary *)skillInfo
{
    NSLog(@"skillInfo=%@",skillInfo);
    
    if ([[skillInfo objectForKey:@"skilltype"] intValue]==1) {
        if ([[skillInfo objectForKey:@"skillname"] isEqualToString:@"森林瞬起"]) {
            
            for (PPBall * tBall in self.ballsElement) {
                if ([tBall.name isEqualToString:@"ball_plant"]) {
                    [tBall runAction:[SKAction animateWithTextures:_trapFrames timePerFrame:0.05f]];
                }
                
            }
            return;
            
        }
        if ([[skillInfo objectForKey:@"skillname"] isEqualToString:@"木系掌控"]) {
            
            for (PPBall * tBall in self.ballsElement) {
                if ([tBall.name isEqualToString:@"ball_plant"]) {
                    
//                    [tBall runAction:[SKAction moveTo:CGPointMake(tBall.position.x-10, tBall.position.y-20) duration:2]];
                    [tBall runAction:[SKAction moveBy:CGVectorMake((self.ballPlayer.position.x-tBall.position.x)/2.0f, (self.ballPlayer.position.y-tBall.position.y)/2.0f) duration:2]];
                }
                
            }
            
            
            return;
            
        }
        
        
    }else
    {
        
        [self showSkillEventBegain:skillInfo];

    }
    
}

-(void)skllEnemyBegain:(NSDictionary *)skillInfo
{
    NSLog(@"skillInfo=%@",skillInfo);
    
    [self showEnemySkillEventBegain:skillInfo];

}
-(void)hpBeenZeroMethod:(PPBattleSideNode *)battleside
{
    NSLog(@"NAME 123=%@",battleside.name);
    
    if ([battleside.name isEqualToString:PP_ENEMY_SIDE_NODE_NAME])
    {
        if ([self.choosedEnemys count]<=currentEnemyIndex)
        {
            NSLog(@"战斗结束，结算奖励");

            NSDictionary *dict=@{@"title":[NSString stringWithFormat:@"怪物%d号 死了",currentEnemyIndex],@"context":@"副本结束"};
            PPCustomAlertNode *alertCustom=[[PPCustomAlertNode alloc] initWithFrame:CustomAlertFrame];
            [alertCustom showCustomAlertWithInfo:dict];
            [self addChild:alertCustom];
            
            return;

        }else
        {
        
            if (CurrentDeviceRealSize.height<500) {
                [self addEnemySide:0.0];
            } else {
                [self addEnemySide:44.0];
            }

            
            NSDictionary *dict=@{@"title":[NSString stringWithFormat:@"怪物%d号 死了",currentEnemyIndex],@"context":@"请干下一个怪物"};
            PPCustomAlertNode *alertCustom=[[PPCustomAlertNode alloc] initWithFrame:CustomAlertFrame];
            [alertCustom showCustomAlertWithInfo:dict];
            [self addChild:alertCustom];
        
        }
    }else
    {
        NSDictionary *dict=@{@"title":@"宠物死了",@"context":@"你太厉害了"};
        PPCustomAlertNode *alertCustom=[[PPCustomAlertNode alloc] initWithFrame:CustomAlertFrame];
        [alertCustom showCustomAlertWithInfo:dict];
        [self addChild:alertCustom];
        
        [self.playerSide removeFromParent];
    }
}

-(void)addEnemySide:(CGFloat)direct
{
    if(self.enemySide != nil){
        [self.enemySide removeFromParent];
        self.enemySide = nil;
    }
    
    if(self.ballEnemy != nil){
        [self.ballEnemy removeFromParent];
        self.ballEnemy = nil;
    }
    
    NSDictionary * dictEnemy = [NSDictionary dictionaryWithContentsOfFile:
                                [[NSBundle mainBundle]pathForResource:@"EnemyInfo" ofType:@"plist"]];
    
    NSArray *enemys = [[NSArray alloc] initWithArray:[dictEnemy objectForKey:@"EnemysInfo"]];
    NSDictionary *chooseEnemyDict = [NSDictionary dictionaryWithDictionary:[enemys objectAtIndex:currentEnemyIndex]];
    PPPixie *eneplayerPixie = [PPPixie birthEnemyPixieWithPetsInfo:chooseEnemyDict];
    
    // 添加 Ball of Enemey
    self.ballEnemy = eneplayerPixie.pixieBall;
    if (CurrentDeviceRealSize.height>500) {
        self.ballEnemy.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y+44);

    }else{
        self.ballEnemy.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);

    }
    
    self.ballEnemy.physicsBody.categoryBitMask = kBallCategory;
    self.ballEnemy.physicsBody.contactTestBitMask = kBallCategory;
    [self addChild:self.ballEnemy];
    
    
    self.enemySide=[[PPBattleSideNode alloc] init];
    [self.enemySide setColor:[UIColor purpleColor]];
    self.enemySide.position= CGPointMake(CGRectGetMidX(self.frame), self.size.height-27-direct);
    self.enemySide.name = PP_ENEMY_SIDE_NODE_NAME;
    self.enemySide.size = CGSizeMake(self.size.width, 60);
    self.enemySide.target=self;
    self.enemySide.hpBeenZeroSel = @selector(hpBeenZeroMethod:);
    self.enemySide.skillSelector = @selector(skllEnemyBegain:);
    self.enemySide.physicsAttackSelector = @selector(physicsAttackBegin:);
    [self.enemySide setSideElementsForEnemy:eneplayerPixie];
    [self addChild:self.enemySide];
    
    currentEnemyIndex += 1;
}

#pragma mark BackAlert
-(void)backButtonClick:(NSString *)backName
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"注意"
                                                      message:@"退出战斗会导致体力损失。确认退出战斗吗？"
                                                     delegate:self
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:@"取消", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
           [(PPFightingMainView *)self.view changeToPassScene];
            [[NSNotificationCenter defaultCenter] postNotificationName:PP_BACK_TO_MAIN_VIEW object:PP_BACK_TO_MAIN_VIEW_FIGHTING];
        
    } else {
        
    }
}

#pragma mark SKScene

-(void)didMoveToView:(SKView *)view
{
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];


}
-(void)willMoveFromView:(SKView *)view
{
    
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (touches.count > 1 || _isBallDragging || _isBallRolling) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode * touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
    
    // 点击自己的球
    if ([[touchedNode name] isEqualToString:@"ball_player"]) {
        
        _isBallDragging = YES;
        _ballShadow = [PPBall ballWithPixie:self.playerSide.currentPPPixie];
        _ballShadow.size = CGSizeMake(kBallSize, kBallSize);
        _ballShadow.position = location;
        _ballShadow.alpha = 0.5f;
        _ballShadow.physicsBody = nil;
        [self addChild:_ballShadow];
        
        
        SKEmitterNode *snow = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"ballTest" ofType:@"sks"]];
        snow.name=@"ball_player";
        snow.position = CGPointMake(0.0f, 0.0f);
        [_ballShadow addChild:snow];
        snow.targetNode = self;
    }
    
    // 点击技能按钮
    if ([[touchedNode name] isEqualToString:@"bt_skill"]) {
        _isTrapEnable = YES;
        
        for (PPBall * tBall in self.ballsElement) {
            if ([tBall.name isEqualToString:@"ball_plant"]) {
                [tBall runAction:[SKAction animateWithTextures:_trapFrames timePerFrame:0.05f]];
            }
            
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (touches.count > 1) return;
    
    if (_isBallDragging && !_isBallRolling) {
        UITouch * touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        _ballShadow.position = location;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (touches.count > 1 ) return;
    
    if (_isBallDragging && !_isBallRolling) {
        
        _isBallDragging = NO;
        [self.ballPlayer.physicsBody applyImpulse:
         CGVectorMake((self.ballPlayer.position.x - _ballShadow.position.x) * kBounceReduce,
                      (self.ballPlayer.position.y - _ballShadow.position.y) * kBounceReduce)];
        
        [_ballShadow removeFromParent];
        _isBallRolling = YES;
    }
    
}

// 每帧处理程序
-(void)update:(NSTimeInterval)currentTime{

    // 如果球都停止了
    if (_isBallRolling && [self isAllStopRolling]) {
        NSLog(@"Doing Attack and Defend");
        _isBallRolling = NO;
        
        // 添加少了的球
        [self addRandomBalls:(kBallNumberMax - (int)self.ballsElement.count)];
        
        [self ballAttackEnd:(kBallNumberMax - (int)self.ballsElement.count)];
        

//        // 刷新技能
        _isTrapEnable = NO;
        for (PPBall * tBall in self.ballsElement) {
            [tBall setToDefaultTexture];
        }
        
    }
}

-(void)ballStopAssimilateCount:(NSInteger)balls
{
}

#pragma mark SKPhysicsContactDelegate

// 碰撞事件
- (void)didBeginContact:(SKPhysicsContact *)contact{
    
    if (!_isBallRolling) return;
    
    SKPhysicsBody * playerBall, * hittedBall;
    

    
    if (contact.bodyA == self.ballPlayer.physicsBody && contact.bodyB != self.ballEnemy.physicsBody) {
        // 球A是玩家球 球B不是玩家球
        playerBall = contact.bodyA;
        hittedBall = contact.bodyB;
        
    } else if (contact.bodyB == self.ballPlayer.physicsBody && contact.bodyA != self.ballEnemy.physicsBody) {
        
        // 球B是玩家球 球A不是玩家球
        playerBall = contact.bodyB;
        hittedBall = contact.bodyA;
        
    } else return;
    
    PPElementType attack = ((PPBall *)playerBall.node).ballElementType;
    PPElementType defend = ((PPBall *)hittedBall.node).ballElementType;
    [self  setAdditionLabel:kElementInhibition[attack][defend]] ;
    if (kElementInhibition[attack][defend] >= 1.0f)
    {
        [hittedBall.node removeFromParent];
        [self.ballsElement removeObject:hittedBall.node];
    }
    
    /*
    if (_isTrapEnable && ((PPBall *)hittedBall.node).ballElementType == PPElementTypePlant) {
        CGPoint tPos = _ballPlayer.position;
        [_ballPlayer removeFromParent];
        [self addChild:_ballPlayer];
        _ballPlayer.position = tPos;
    }
    */
    
    NSLog(@"%@ - %@ - %f", [ConstantData elementName:attack], [ConstantData elementName:defend], kElementInhibition[attack][defend]);
    
}

#pragma mark Custom

// 添加四周的墙
-(void)addWalls:(CGSize)nodeSize atPosition:(CGPoint)nodePosition{
    
    SKSpriteNode * wall = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:nodeSize];

    wall.position = nodePosition;
    wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
    
    wall.physicsBody.affectedByGravity = NO;
    wall.physicsBody.dynamic = NO;
    wall.physicsBody.friction = 0.1;
    wall.physicsBody.categoryBitMask = kGroundCategory;
    //wall.physicsBody.contactTestBitMask = kBallCategory;
    //wall.physicsBody.collisionBitMask = 0;
    
    [self addChild:wall];
}

// 添加随机的球
-(void)addRandomBalls:(int)number{
    
    if (CurrentDeviceRealSize.height > 500) {
        for (int i = 0; i < number; i++) {
            
            PPBall * tBall = [PPBall ballWithElement:arc4random()%5 + 1];
            tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y+44.0f);
            tBall.physicsBody.categoryBitMask = kBallCategory;
            tBall.physicsBody.contactTestBitMask = kBallCategory;
            [self addChild:tBall];
            
            [self.ballsElement addObject:tBall];
            
        }
    } else {
        
        for (int i = 0; i < number; i++) {
            
            PPBall * tBall = [PPBall ballWithElement:arc4random()%5 + 1];
            tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y);
            tBall.physicsBody.categoryBitMask = kBallCategory;
            tBall.physicsBody.contactTestBitMask = kBallCategory;
            [self addChild:tBall];
            
            [self.ballsElement addObject:tBall];
            
        }
    }

    
}

// 是否所有的球都停止了滚动
-(BOOL)isAllStopRolling{

    CGFloat vectorLengthVelocity=vectorLength(self.ballPlayer.physicsBody.velocity);
    
    if (vectorLengthVelocity > 0) {
        NSLog(@"value = %f",vectorLengthVelocity);
        
        
//        if (vectorLengthVelocity<criticalValue) {
//            
//            self.ballPlayer.physicsBody.velocity=CGVectorMake(self.ballPlayer.physicsBody.velocity.dx/dampingValue, self.ballPlayer.physicsBody.velocity.dy/dampingValue);
//        }
//        if (vectorLengthVelocity<5.0f) {
//             self.ballPlayer.physicsBody.velocity=CGVectorMake(0.0f, 0.0f);
//        }
        
        
        return NO;
    }
    
    CGFloat vectorBallVelocity=vectorLength(self.ballEnemy.physicsBody.velocity);

    if (vectorBallVelocity > 0) {
        
//        if (vectorBallVelocity<criticalValue) {
//            
//            self.ballEnemy.physicsBody.velocity=CGVectorMake(self.ballEnemy.physicsBody.velocity.dx/dampingValue, self.ballEnemy.physicsBody.velocity.dy/dampingValue);
//        }
//        
        if (vectorLengthVelocity<5.0f) {
            self.ballEnemy.physicsBody.velocity=CGVectorMake(0.0f, 0.0f);
        }
        
        return NO;
    }

    BOOL isAllOtherBallStop = YES;
    for (PPBall * tBall in self.ballsElement) {
        if (vectorLength(tBall.physicsBody.velocity) > 0) {
//            if (vectorLength(tBall.physicsBody.velocity) <criticalValue) {
//                
//               tBall.physicsBody.velocity=CGVectorMake(tBall.physicsBody.velocity.dx/dampingValue, tBall.physicsBody.velocity.dy/dampingValue);
//                
//                if (vectorLength(tBall.physicsBody.velocity)<10.0f) {
//                    
//                    self.ballEnemy.physicsBody.velocity=CGVectorMake(0.0f, 0.0f);
//                }
           isAllOtherBallStop = NO;

            break;
        }
    }
    
    if (vectorLengthVelocity == 0&&vectorBallVelocity==0&&isAllOtherBallStop) {
        return YES;
    }else
    {
        return NO;

    }
    
    
}

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

#pragma mark SkillBeginAnimateDelegate

-(void)showEnemySkillEventBegain:(NSDictionary *)skillInfo
{
    
    PPSkillNode *skillNode=[PPSkillNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(self.size.width, 300)];
    skillNode.name = PP_ENEMY_SKILL_SHOW_NODE_NAME;
    skillNode.delegate=self;
    skillNode.position=CGPointMake(self.size.width/2.0f, 250.0f+directFori5);
    [self addChild:skillNode];
    
    NSLog(@"skillInfo=%@",skillInfo);
    [skillNode showSkillAnimate:skillInfo];
    
}

-(void)showSkillEventBegain:(NSDictionary *)skillInfo
{
    
    PPSkillNode *skillNode=[PPSkillNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(self.size.width, 300.0f)];
    skillNode.delegate=self;
    skillNode.name = PP_PET_SKILL_SHOW_NODE_NAME;
    skillNode.position=CGPointMake(self.size.width/2.0f, 250.0f+directFori5);
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
            
            [self.playerSide changeHPValue:skillInfo.HPChangeValue];
            
        }else
        {
            [self.enemySide changeHPValue:skillInfo.HPChangeValue];
        
        }

        
    }else
    {
        
        if (skillInfo.skillObject ==1) {
            
            [self.enemySide changeHPValue:skillInfo.HPChangeValue];
            
        }else
        {
            [self.playerSide changeHPValue:skillInfo.HPChangeValue];
            
        }
        
    }
    
}

@end
