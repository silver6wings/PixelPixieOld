

#import "PPBallBattleScene.h"

#define SPACE_BOTTOM 60
#define BALL_RANDOM_X kBallSize / 2 + arc4random() % (int)(320 - kBallSize)
#define BALL_RANDOM_Y kBallSize / 2 + arc4random() % (int)(362 - kBallSize)+SPACE_BOTTOM

static CGFloat sizeFitFor5;     // 适配Retina4英寸屏幕的上界值

static const uint32_t kBallCategory      =  0x1 << 0;
static const uint32_t kGroundCategory    =  0x1 << 1;

/*
 static const CGFloat criticalValue = 20.1;  // 临界值
 static const CGFloat dampingValue  = 1.5;   // 衰减系数
*/

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
    BOOL isNotSkillRun;
}
@property (nonatomic, retain) PPPixie * pixiePlayer;
@property (nonatomic, retain) PPPixie * pixieEnemy;

@property (nonatomic) BOOL isBallDragging;
@property (nonatomic) BOOL isBallRolling;
@property (nonatomic) PPBall * ballPlayer;
@property (nonatomic) PPBall * ballShadow;
@property (nonatomic) PPBall * ballEnemy;

@property (nonatomic, retain) NSMutableArray * ballsElement;
@property (nonatomic, retain) NSMutableArray * trapFrames;
@property (nonatomic, retain) PPBattleSideNode * playerSkillSide;
@property (nonatomic, retain) PPBattleSideNode * playerAndEnemySide;

@property (nonatomic) SKSpriteNode * btSkill;
@property (nonatomic) BOOL isTrapEnable;
@end

@implementation PPBallBattleScene
@synthesize hurdleReady;
-(id)initWithSize:(CGSize)size
      PixiePlayer:(PPPixie *)pixieA
       PixieEnemy:(PPPixie *)pixieB
{
    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor blackColor];
        
        self.pixiePlayer = pixieA;
        self.pixieEnemy = pixieB;
        
        // 设置场景物理属性
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        // 添加背景图片
        SKSpriteNode * bg;
        if (CurrentDeviceRealSize.height > 500) {
            sizeFitFor5 = 44.0f;
            bg = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(320.0f, 450.0f)];
        } else {
            sizeFitFor5 = 0.0f;
            bg = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(320.0f, 362.0f)];
        }
        
        
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [bg setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"bg_02.jpg"]]];
        [self addChild:bg];
        
        // demo 初始化 skill parameter Hack
        _isTrapEnable = NO;
        
        // demo 预加载 动画 frames
        _trapFrames = [[NSMutableArray alloc] init];
        
        for (int i=1; i <= 40; i++) {
            NSString * textureName = [NSString stringWithFormat:@"陷阱%04d.png", i];
            SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
            [_trapFrames addObject:temp];
        }
        
        
        self.playerSkillSide = [[PPBattleSideNode alloc] init];
        self.playerSkillSide.position= CGPointMake(self.size.width/2.0f, 30 + sizeFitFor5);
        self.playerSkillSide.size =  CGSizeMake(self.size.width, 60);
        self.playerSkillSide.name = PP_PET_PLAYER_SIDE_NODE_NAME;
        self.playerSkillSide.target = self;
        self.playerSkillSide.skillSelector = @selector(skillPlayerShowBegin:);
        self.playerSkillSide.showInfoSelector = @selector(showCurrentPlayerPetInfo:);
        self.playerSkillSide.hpBeenZeroSel = @selector(hpBeenZeroMethod:);
        [self.playerSkillSide setColor:[UIColor grayColor]];
        [self.playerSkillSide setSideSkillsBtn:pixieA];
        [self addChild:self.playerSkillSide];
     
        
        
        // 添加 Walls
        CGFloat tWidth = 320.0f;
        CGFloat tHeight = 362.0f;
        
        [self addWalls:CGSizeMake(tWidth, kWallThick*2) atPosition:CGPointMake(tWidth / 2, tHeight + SPACE_BOTTOM + sizeFitFor5)];
        [self addWalls:CGSizeMake(tWidth, kWallThick*2) atPosition:CGPointMake(tWidth / 2, 0 + SPACE_BOTTOM + sizeFitFor5)];
        [self addWalls:CGSizeMake(kWallThick*2, tHeight) atPosition:CGPointMake(0, tHeight / 2 + SPACE_BOTTOM + sizeFitFor5)];
        [self addWalls:CGSizeMake(kWallThick*2, tHeight) atPosition:CGPointMake(tWidth, tHeight / 2 + SPACE_BOTTOM + sizeFitFor5)];
        
        
        // 添加己方玩家球
        self.ballPlayer = pixieA.pixieBall;
        self.ballPlayer.name = @"ball_player";
        self.ballPlayer.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y + sizeFitFor5);
        self.ballPlayer.physicsBody.categoryBitMask = kBallCategory;
        self.ballPlayer.physicsBody.contactTestBitMask = kBallCategory;
        [self addChild:self.ballPlayer];
        
        
        // 添加粒子效果
        /*
         SKEmitterNode * snow = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"ballTest"
         ofType:@"sks"]];
         snow.name = @"ball_player";
         snow.position = CGPointMake(0.0f, 0.0f);
         [self.ballPlayer addChild:snow];
         snow.targetNode = self;
         */
        
        // demo 添加 Skill Button
        /*
         _btSkill = [SKSpriteNode spriteNodeWithImageNamed:@"skill_plant.png"];
         _btSkill.size = CGSizeMake(30, 30);
         _btSkill.name = @"bt_skill";
         _btSkill.position = CGPointMake(280, 45+sizeFitFor5);
         [self addChild:_btSkill];
         */
        
        // 添加元素球
        self.ballsElement = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 10; i++) {
            PPBall * tBall = [PPBall ballWithElement:i%5+1];
            tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y + sizeFitFor5);
            tBall.physicsBody.categoryBitMask = kBallCategory;
            tBall.physicsBody.contactTestBitMask = kBallCategory;
            [self addChild:tBall];
            [self.ballsElement addObject:tBall];
        }
        [self addRandomBalls:5];
        
        PPBall * comboBall = [PPBall ballWithCombo];
        comboBall.physicsBody.categoryBitMask = kBallCategory;
        comboBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y + sizeFitFor5);
        [comboBall setColor:[UIColor orangeColor]];
        comboBall.physicsBody.contactTestBitMask = kBallCategory;
        [self addChild:comboBall];
        [self.ballsElement addObject:comboBall];
     
    }
    return self;
}
-(void)setEnemyAtIndex:(int)index
{
    
    currentEnemyIndex = index;
    [self addEnemySide:sizeFitFor5];
    
//    if (CurrentDeviceRealSize.height>500) {
//        [self setBackTitleText:nil andPositionY:490.0f];
//    }else
//    {
//        [self setBackTitleText:nil andPositionY:450.0f];
//        
//    }
    
}

-(void)showCurrentPlayerPetInfo:(PPPixie *) pet
{
    
    
    
}
-(void)showCurrentEnemyInfo:(PPPixie *)enemy
{
    
    
}

#pragma mark SkillShow

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
        
        CGFloat damageCount = [_pixiePlayer countPhysicalDamageTo:_pixieEnemy];
        [self.playerAndEnemySide changeEnemyHPValue:-damageCount];
        NSLog(@"currentHP=%f",self.playerAndEnemySide.currentPPPixieEnemy.currentHP);
        
        
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
        
        PPBasicLabelNode *labelNode=(PPBasicLabelNode *)[self childNodeWithName:@"EnemyPhysics"];
        if (labelNode) {
            [labelNode removeFromParent];
        }
        
        
        PPBasicLabelNode *additonLabel= [[PPBasicLabelNode alloc] init];
        additonLabel.name  = @"EnemyPhysics";
        additonLabel.position = CGPointMake(160.0f, 200.0f);
        [additonLabel setText:@"怪物物理攻击"];
        [self addChild:additonLabel];
        
        
        SKAction *actionScale = [SKAction scaleBy:2.0 duration:1];
        [additonLabel runAction:actionScale completion:^{
            [additonLabel removeFromParent];
        }];
        
        
        CGFloat damageCount = [_pixiePlayer countPhysicalDamageTo:_pixieEnemy];
        
        [self.playerAndEnemySide changePetHPValue:-damageCount];
        
    }
    
    [self performSelectorOnMainThread:@selector(roundRotateMoved:) withObject:nodeName afterDelay:1];

    
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
  
    
    [self setPlayerSideRoundRunState];

    
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
                for (PPBall * tBall in self.ballsElement) {
                    if ([tBall.name isEqualToString:@"ball_plant"]) {
                        [tBall runAction:[SKAction animateWithTextures:_trapFrames timePerFrame:0.05f]];
                       
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
            
            [self performSelectorOnMainThread:@selector(roundRotateMoved:) withObject:PP_PET_PLAYER_SIDE_NODE_NAME afterDelay:2];
            
            
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
    [self roundRotateMoved:PP_ENEMY_SIDE_NODE_NAME];
    
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
        
        
        NSDictionary *dict = @{@"title":@"宠物死了",@"context":@"你太sb了"};
        PPCustomAlertNode *alertCustom=[[PPCustomAlertNode alloc] initWithFrame:CustomAlertFrame];
        [alertCustom showCustomAlertWithInfo:dict];
        [self addChild:alertCustom];
        
//        [self.playerSide removeFromParent];
        
    }

}
-(void)goNextEnemy
{
    
    [self.hurdleReady setCurrentHurdle:currentEnemyIndex];
    [self.view presentScene:self.hurdleReady transition:[SKTransition doorwayWithDuration:1]];
    
}
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
    self.ballEnemy.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y + sizeFitFor5);
    self.ballEnemy.physicsBody.categoryBitMask = kBallCategory;
    self.ballEnemy.physicsBody.contactTestBitMask = kBallCategory;
    [self addChild:self.ballEnemy];
    
    self.playerAndEnemySide = [[PPBattleSideNode alloc] init];
    [self.playerAndEnemySide setColor:[UIColor purpleColor]];
    self.playerAndEnemySide.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height-27-direct);
    self.playerAndEnemySide.name = PP_ENEMY_SIDE_NODE_NAME;
    self.playerAndEnemySide.size = CGSizeMake(self.size.width, 60);
    self.playerAndEnemySide.target = self;
    self.playerAndEnemySide.hpBeenZeroSel = @selector(hpBeenZeroMethod:);
    self.playerAndEnemySide.skillSelector = @selector(skllEnemyBegain:);
    self.playerAndEnemySide.pauseSelector = @selector(pauseBtnClick:);
    self.playerAndEnemySide.showInfoSelector = @selector(showCurrentEnemyInfo:);
    [self.playerAndEnemySide setSideElements:self.pixiePlayer andEnemy:self.pixieEnemy];
    [self addChild:self.playerAndEnemySide];
    
    currentEnemyIndex += 1;
    
}

-(void)pauseBtnClick:(NSString *)stringName
{
    
    PPCustomAlertNode *alertNode=[[PPCustomAlertNode alloc] initWithFrame:CGRectMake(self.size.width/2.0f, self.size.height/2.0f, self.size.width, self.size.height)];
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
#pragma mark round take turns
-(void)roundRotateBegin
{
    
    roundActionNum = 0;
    //随机怪物先攻击还是人物先开始攻击
    [self startBattle:@"战斗开始"];

    
}

-(void)roundRotateMoved:(NSString *)nodeName
{
    
    [self setPlayerSideRoundRunState];
    
    roundActionNum+=1;
    
    if(roundActionNum==1)
    {
        if ([nodeName isEqualToString:PP_PET_PLAYER_SIDE_NODE_NAME]) {
            
            [self physicsAttackBegin:PP_ENEMY_SIDE_NODE_NAME];

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

    [self setPlayerSideRoundEndState];
    
}
-(void)startBattle:(NSString *)text
{
    
        PPBasicLabelNode *labelNode=(PPBasicLabelNode *)[self childNodeWithName:@"RoundLabel"];
        if (labelNode) {
            [labelNode removeFromParent];
        }

    
        PPBasicLabelNode *additonLabel= [[PPBasicLabelNode alloc] init];
        additonLabel.name  = @"RoundLabel";
        additonLabel.fontColor = [UIColor yellowColor];
        additonLabel.position = CGPointMake(160.0f, 200.0f);
        [additonLabel setText:text];
        [self addChild:additonLabel];
    

        SKAction *actionScale = [SKAction scaleBy:2.0 duration:1];
        [additonLabel runAction:actionScale completion:^{
            [additonLabel removeFromParent];
            
        
            if (arc4random()%2==0) {
                
                [self setPlayerSideRoundEndState];
                
            }else
            {
                
                 [self physicsAttackBegin:PP_ENEMY_SIDE_NODE_NAME];
//                    if (arc4random()%2==0) {
//                                    [self physicsAttackBegin:PP_ENEMY_SIDE_NODE_NAME];
//                    }else
//                    {
//                        
//                    }
            }
            
            
        }];
    
    
}
-(void)setRoundEndNumberLabel:(NSString *)text
{
    
    PPBasicLabelNode *labelNode=(PPBasicLabelNode *)[self childNodeWithName:@"RoundLabel"];
    if (labelNode) {
        [labelNode removeFromParent];
    }
    
    
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
#pragma mark BackAlert

-(void)backButtonClick:(NSString *)backName
{
    [self.view presentScene:self.hurdleReady transition:[SKTransition doorsOpenVerticalWithDuration:1]];

//    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"注意"
//                                                      message:@"退出战斗会导致体力损失。确认退出战斗吗？"
//                                                     delegate:self
//                                            cancelButtonTitle:@"确定"
//                                            otherButtonTitles:@"取消", nil];
//    [alertView show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [(PPFightingMainView *)self.view changeToPassScene];
        [[NSNotificationCenter defaultCenter] postNotificationName:PP_BACK_TO_MAIN_VIEW object:PP_BACK_TO_MAIN_VIEW_FIGHTING];
    }
}

#pragma mark SKScene

-(void)didMoveToView:(SKView *)view
{
    [self performSelectorOnMainThread:@selector(roundRotateBegin) withObject:nil afterDelay:2];
    [self setPlayerSideRoundRunState];
}

-(void)willMoveFromView:(SKView *)view
{
    //    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touches.count > 1 || _isBallDragging || _isBallRolling || isNotSkillRun) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode * touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
    
    // 点击自己的球
    if ([[touchedNode name] isEqualToString:@"ball_player"]) {
        
        _isBallDragging = YES;
        _ballShadow = [PPBall ballWithPixie:self.pixiePlayer];
        _ballShadow.size = CGSizeMake(kBallSize, kBallSize);
        _ballShadow.position = location;
        _ballShadow.alpha = 0.5f;
        _ballShadow.physicsBody = nil;
        [self addChild:_ballShadow];
        
        //粒子效果
        /*
         SKEmitterNode *snow = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"ballTest"
         ofType:@"sks"]];
         snow.name=@"ball_player";
         snow.position = CGPointMake(0.0f, 0.0f);
         [_ballShadow addChild:snow];
         snow.targetNode = self;
         */
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
        
        
        [_ballShadow removeFromParent];
        _isBallRolling = YES;
    }
}

// 每帧处理程序
-(void)update:(NSTimeInterval)currentTime
{
    // 如果球都停止了
    if (_isBallRolling && [self isAllStopRolling]) {
        NSLog(@"Doing Attack and Defend");
        _isBallRolling = NO;
        
        // 添加少了的球
        [self addRandomBalls:(kBallNumberMax - (int)self.ballsElement.count)];
        [self ballAttackEnd:(kBallNumberMax - (int)self.ballsElement.count)];
        
        // 刷新技能
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
-(void)didBeginContact:(SKPhysicsContact *)contact{
    
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
//    [self  setAdditionLabel:kElementInhibition[attack][defend]] ;
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

#pragma mark Custom Method

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
    
    for (int i = 0; i < number; i++) {
        
        PPBall * tBall = [PPBall ballWithElement:arc4random()%5 + 1];
        tBall.position = CGPointMake(BALL_RANDOM_X, BALL_RANDOM_Y+sizeFitFor5);
        tBall.physicsBody.categoryBitMask = kBallCategory;
        tBall.physicsBody.contactTestBitMask = kBallCategory;
        [self addChild:tBall];
        
        [self.ballsElement addObject:tBall];
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
    
    CGFloat vectorBallVelocity = vectorLength(self.ballEnemy.physicsBody.velocity);
    
    if (vectorBallVelocity > 0) {
        
        //        if (vectorBallVelocity<criticalValue) {
        //
        //            self.ballEnemy.physicsBody.velocity=CGVectorMake(self.ballEnemy.physicsBody.velocity.dx/dampingValue, self.ballEnemy.physicsBody.velocity.dy/dampingValue);
        //        }
        //
        if (vectorLengthVelocity < 5.0f) {
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
    
    if (vectorLengthVelocity == 0 && vectorBallVelocity == 0 && isAllOtherBallStop) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark SkillBeginAnimateDelegate

-(void)showEnemySkillEventBegin:(NSDictionary *)skillInfo
{
    
    [self setPlayerSideRoundRunState];
    
    
    PPSkillNode *skillNode = [PPSkillNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(self.size.width, 300)];
    skillNode.name = PP_ENEMY_SKILL_SHOW_NODE_NAME;
    skillNode.delegate = self;
    skillNode.position = CGPointMake(self.size.width/2.0f, 250.0f+sizeFitFor5);
    [self addChild:skillNode];
    
    NSLog(@"skillInfo=%@",skillInfo);
    [skillNode showSkillAnimate:skillInfo];
    
}

-(void)showSkillEventBegin:(NSDictionary *)skillInfo
{
    
    PPSkillNode *skillNode = [PPSkillNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(self.size.width, 300.0f)];
    skillNode.delegate = self;
    skillNode.name = PP_PET_SKILL_SHOW_NODE_NAME;
    skillNode.position = CGPointMake(self.size.width/2.0f, 250.0f+sizeFitFor5);
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
    } else {
        if (skillInfo.skillObject ==1) {
            [self.playerAndEnemySide changeEnemyHPValue:skillInfo.HPChangeValue];
        } else {
            [self.playerAndEnemySide changePetHPValue:skillInfo.HPChangeValue];
        }
    }
    
    [self roundRotateMoved:PP_PET_PLAYER_SIDE_NODE_NAME];

}

@end
