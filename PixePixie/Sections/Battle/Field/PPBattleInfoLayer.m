
#import "PPBattleInfoLayer.h"
#import "PPAtlasManager.h"


@interface PPBattleInfoLayer()
{
    SKSpriteNode * ppixiePetBtn;
    SKSpriteNode * ppixieEnemyBtn;
}
@end
@implementation PPBattleInfoLayer

@synthesize target = _target;
@synthesize skillSelector = _skillSelector;
@synthesize currentPPPixie;
@synthesize currentPPPixieEnemy;
@synthesize showInfoSelector;
@synthesize hpBeenZeroSel;
@synthesize pauseSelector;
@synthesize hpChangeEnd;
@synthesize skillInvalidSel;

// 设置技能
-(void)setSideSkillsBtn:(PPPixie *)ppixie andSceneString:(NSString *)sceneString
{
    // 添加下方背景图片
    SKSpriteNode * bgSprite = [SKSpriteNode spriteNodeWithTexture:[[PPAtlasManager ui_fighting] textureNamed:[NSString stringWithFormat:@"%@_footer_back",sceneString]]];
    bgSprite.size = CGSizeMake(320.0f, 80.0f);
    bgSprite.position = CGPointMake(0.0f,0.0f);
    [self addChild:bgSprite];
    
    
    self.currentPPPixie = ppixie;
    NSLog(@"pixieSkills count=%lu", (unsigned long)[ppixie.pixieSkills count]);
    
    // 添加技能槽
    for (int i = 0; i < 4; i++) {
        
        NSDictionary *dictSkill=nil;
        if ([ppixie.pixieSkills count]>i) {
            dictSkill=[ppixie.pixieSkills objectAtIndex:i];
        }
        
        NSString * stringSkillStatus = [dictSkill objectForKey:@"skillstatus"];
        
        NSString * stringSkillBtn = [dictSkill objectForKey:@"skillbtntexture"];
        PPSpriteButton * passButton = nil;
        
        if (![stringSkillStatus isEqualToString:@"valid"]) {
            stringSkillBtn = [NSString stringWithFormat:@"%@_none",kElementTypeString[ppixie.pixieElement]];
            passButton = [PPSpriteButton buttonWithTexture:[[PPAtlasManager skill_icon] textureNamed:stringSkillBtn]
                                                   andSize:CGSizeMake(50.0f, 50.0f)];
            //            [passButton setLabelWithText:@"不可用" andFont:[UIFont boldSystemFontOfSize:14.0f] withColor:[UIColor whiteColor]];
            
            passButton.userInteractionEnabled = NO;
            [passButton addTarget:self selector:@selector(skillInvalidClick:)
                       withObject:passButton forControlEvent:PPButtonControlEventTouchUp];
            
        } else {
            passButton = [PPSpriteButton buttonWithTexture:[[PPAtlasManager skill_icon] textureNamed:stringSkillBtn]
                                                   andSize:CGSizeMake(50.0f, 50.0f)];
            [passButton addTarget:self selector:@selector(skillSideClick:)
                       withObject:passButton forControlEvent:PPButtonControlEventTouchUp];
        }
        
        passButton.name = [NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i];
        passButton.position = CGPointMake(65*i - 112.0f, 0.0f);
        
        [self addChild:passButton];
        
        
        if ([ppixie.pixieSkills count] > i && [stringSkillStatus isEqualToString:@"valid"]) {
            
            SKLabelNode * skillName = [[SKLabelNode alloc] init];
            skillName.fontSize = 12;
            [skillName setText:[[ppixie.pixieSkills objectAtIndex:i] objectForKey:@"skillname"]];
            [skillName setPosition:CGPointMake(passButton.position.x,
                                               passButton.position.y-30.0f-skillName.frame.size.height/2.0f)];
            [self addChild:skillName];
        }
    }
    
    //暂停按钮
    PPSpriteButton *  stopBtn = [PPSpriteButton buttonWithTexture:[[PPAtlasManager ui_fighting] textureNamed:[NSString stringWithFormat:@"%@_footer_pause",sceneString]]
                                                          andSize:CGSizeMake(32.5, 32.5)];
    stopBtn.position = CGPointMake(130.0f, 0.0f);
    stopBtn.name = @"stopBtn";
    [stopBtn addTarget:self selector:@selector(stopBtnClick:)
            withObject:stopBtn.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:stopBtn];
    
}

-(void)setSideElements:(PPPixie *)petppixie andEnemy:(PPPixie *)enemyppixie andSceneString:(NSString *)sceneString
{
    
    self.currentPPPixie = petppixie;
    self.currentPPPixieEnemy = enemyppixie;
    isHaveDead = NO;
    
    // 添加上方背景图片
    SKSpriteNode * bgSprite = [SKSpriteNode spriteNodeWithTexture:[[PPAtlasManager ui_fighting] textureNamed:[NSString stringWithFormat:@"%@_header_back",sceneString]]];
    bgSprite.size = CGSizeMake(320.0f, 160.0f);
    bgSprite.position = CGPointMake(0.0f,0.0f);
    [self addChild:bgSprite];
    
    // 己方头像
    ppixiePetBtn = [[SKSpriteNode alloc] init];
    ppixiePetBtn.size = CGSizeMake(50.0f, 50.0f);
    [ppixiePetBtn setPosition: CGPointMake(-121.5f, 20.0f)];
    [self addChild:ppixiePetBtn];
    
    
    [ppixiePetBtn runAction:[SKAction repeatActionForever:[[PPAtlasManager ball_action] getAnimation:[NSString stringWithFormat:@"%@3stop",kElementTypeString[enemyppixie.pixieElement]]]]];
    NSLog(@"plantname=%@",[NSString stringWithFormat:@"%@3stop",kElementTypeString[enemyppixie.pixieElement]]);

    
    //[NSString stringWithFormat:@"%@3stop",kElementTypeString[petppixie.pixieElement]
    //    ppixiePetBtn = [PPSpriteButton buttonWithTexture:[[PPAtlasManager pixie_info] textureNamed:[NSString stringWithFormat:@"%@%d_portrait",kElementTypeString[petppixie.pixieElement],petppixie.pixieGeneration]]
    //                                             andSize:CGSizeMake(32.5f, 32.5f)];
    //    [ppixiePetBtn addTarget:self selector:@selector(physicsAttackClick:) withObject:@"" forControlEvent:PPButtonControlEventTouchUp];
    //    ppixiePetBtn.position = CGPointMake(-121.5f, 20.0f);
    //    ppixiePetBtn.xScale = 1.0f;
    //    [self addChild:ppixiePetBtn];
    
    
    
    // 己方连击数
    SKLabelNode *ppixiePetBtnLabel = [[SKLabelNode alloc] init];
    ppixiePetBtnLabel.fontSize = 10;
    ppixiePetBtnLabel.name = PP_PET_COMBOS_NAME;
    [ppixiePetBtnLabel setColor:[SKColor redColor]];
    NSLog(@"pixieName = %@",petppixie.pixieName);
    [ppixiePetBtnLabel setText:@"连击:0"];
    ppixiePetBtnLabel.position = CGPointMake(ppixiePetBtn.position.x,ppixiePetBtn.position.y - 40);
    [self addChild:ppixiePetBtnLabel];
    
    // 己方生命条
    petPlayerHP = [PPValueShowNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(100.0f, 20)];
    [petPlayerHP setMaxValue:petppixie.pixieHPmax andCurrentValue:petppixie.currentHP
                 andShowType:PP_HPTYPE andAnchorPoint:CGPointMake(0.0f, 0.5f)
        andElementTypeString:kElementTypeString[petppixie.pixieElement]];
    petPlayerHP->target = self;
    petPlayerHP->animateEnd = @selector(animatePetHPEnd:);
    petPlayerHP.anchorPoint = CGPointMake(0.5, 0.5);
    petPlayerHP.position = CGPointMake(-52.5,-20.0);
    [self addChild:petPlayerHP];
    
    // 己方能量条
    petPlayerMP = [PPValueShowNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(100, 10)];
    [petPlayerMP setMaxValue:petppixie.pixieMPmax andCurrentValue:petppixie.currentMP
                 andShowType:PP_MPTYPE andAnchorPoint:CGPointMake(0.0f, 0.5f)
        andElementTypeString:kElementTypeString[petppixie.pixieElement]];
    petPlayerMP->target = self;
    petPlayerMP->animateEnd = @selector(animatePetMPEnd:);
    petPlayerMP.anchorPoint = CGPointMake(0.5, 0.5);
    petPlayerMP.position = CGPointMake(petPlayerHP.position.x,ppixiePetBtn.position.y-20);
    [self addChild:petPlayerMP];
    
    // 敌方生命条
    enemyPlayerHP = [PPValueShowNode spriteNodeWithColor:[UIColor clearColor]
                                                    size:CGSizeMake(petPlayerHP.size.width, petPlayerHP.size.height)];
    [enemyPlayerHP setMaxValue:enemyppixie.pixieHPmax andCurrentValue:enemyppixie.currentHP
                   andShowType:PP_HPTYPE andAnchorPoint:CGPointMake(1.0f, 0.5f) andElementTypeString:kElementTypeString[enemyppixie.pixieElement]];
    enemyPlayerHP->target = self;
    enemyPlayerHP->animateEnd = @selector(animateEnemyHPEnd:);
    enemyPlayerHP.anchorPoint = CGPointMake(0.5, 0.5);
    enemyPlayerHP.position = CGPointMake(52.5,petPlayerHP.position.y);
    [self addChild:enemyPlayerHP];
    
    
    // 敌方能量条
    enemyPlayerMP = [PPValueShowNode spriteNodeWithColor:[UIColor clearColor]
                                                    size:CGSizeMake(petPlayerMP.size.width, petPlayerMP.size.height)];
    [enemyPlayerMP setMaxValue:enemyppixie.pixieMPmax andCurrentValue:enemyppixie.currentMP
                   andShowType:PP_MPTYPE andAnchorPoint:CGPointMake(1.0f, 0.5f) andElementTypeString:kElementTypeString[enemyppixie.pixieElement]];
    enemyPlayerMP->target = self;
    enemyPlayerMP->animateEnd = @selector(animateEnemyMPEnd:);
    enemyPlayerMP.anchorPoint = CGPointMake(0.5, 0.5);
    enemyPlayerMP.position = CGPointMake(enemyPlayerHP.position.x,petPlayerMP.position.y);
    [self addChild:enemyPlayerMP];
    
    
    
    // 敌方头像
    ppixieEnemyBtn = [[SKSpriteNode alloc] init];
    ppixieEnemyBtn.size = CGSizeMake(50.0f, 50.0f);
    [ppixieEnemyBtn setPosition:CGPointMake(enemyPlayerHP.position.x + enemyPlayerHP.size.width/2.0f + 20.0f,ppixiePetBtn.position.y)];
    [self addChild:ppixieEnemyBtn];
    [ppixieEnemyBtn runAction:[SKAction repeatActionForever:[[PPAtlasManager ball_action] getAnimation:[NSString stringWithFormat:@"%@3stop",kElementTypeString[enemyppixie.pixieElement]]]]];
    
    
    //    ppixieEnemyBtn = [PPSpriteButton buttonWithTexture:[[PPAtlasManager pixie_info] textureNamed:[NSString stringWithFormat:@"%@%d_portrait",kElementTypeString[enemyppixie.pixieElement],enemyppixie.pixieGeneration]]
    //                                               andSize:CGSizeMake(32.5f, 32.5f)];
    //    [ppixieEnemyBtn addTarget:self selector:@selector(physicsAttackClick:) withObject:@"" forControlEvent:PPButtonControlEventTouchUp];
    //    ppixieEnemyBtn.position = CGPointMake(enemyPlayerHP.position.x + enemyPlayerHP.size.width/2.0f + 20.0f,ppixiePetBtn.position.y);
    //    ppixieEnemyBtn.xScale = -1.0f;
    //    [self addChild:ppixieEnemyBtn];
    
    
    
    
    // 敌方连击数
    SKLabelNode *ppixieBtnLabel = [[SKLabelNode alloc] init];
    ppixieBtnLabel.fontSize = 10;
    ppixieBtnLabel.name = PP_ENEMY_COMBOS_NAME;
    NSLog(@"pixieName=%@",enemyppixie.pixieName);
    [ppixieBtnLabel setText:@"连击:0"];
    ppixieBtnLabel.position = CGPointMake(ppixieEnemyBtn.position.x, ppixiePetBtnLabel.position.y);
    [self addChild:ppixieBtnLabel];
    
    
    
    for (int i = 0; i < [currentPPPixie.pixieBuffs count]; i++)
    {
        // 添加宠物buff槽
        PPSpriteButton * buffButton = [PPSpriteButton buttonWithTexture:[[PPAtlasManager ui_fighting] textureNamed:[NSString stringWithFormat:@"%@_header_buffbar%d",kElementTypeString[currentPPPixie.pixieElement],i+1]]
                                                                andSize:CGSizeMake(25.0f, 25.0f)];
        buffButton.position = CGPointMake(30*i - 90.0f, petPlayerHP.position.y-40.0f);
        buffButton.name =[NSString stringWithFormat:@"%d",PP_BUFF_SHOW_BTN_TAG + i];
        buffButton.PPBallSkillStatus = @"0";
        [buffButton addTarget:self selector:@selector(buffBtnClick:)
                   withObject:buffButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:buffButton];
        
    }
    for (int i = (int)[currentPPPixie.pixieBuffs count]-1; i >= 0; i--)
    {
        // 添加怪物buff槽
        PPSpriteButton * buffButton = [PPSpriteButton buttonWithTexture:[[PPAtlasManager ui_fighting] textureNamed:[NSString stringWithFormat:@"%@_header_buffbar%d",kElementTypeString[currentPPPixieEnemy.pixieElement],i+1]]
                                                                andSize:CGSizeMake(25.0f, 25.0f)];
        buffButton.position = CGPointMake(30*(3-i) -55.0f+enemyPlayerHP.position.x, petPlayerHP.position.y-40.0f);
        buffButton.name =[NSString stringWithFormat:@"%d",PP_BUFF_SHOW_BTN_TAG + i + 10];
        buffButton.PPBallSkillStatus = @"0";
        [buffButton addTarget:self selector:@selector(buffBtnClick:)
                   withObject:buffButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:buffButton];
        
        
    }
    
    //    SKLabelNode *ppixiePetNameLabel=[[SKLabelNode alloc] init];
    //    ppixiePetNameLabel.fontSize=12;
    //    [ppixiePetNameLabel setColor:[SKColor blueColor]];
    //    NSLog(@"pixieName=%@",petppixie.pixieName);
    //    [ppixiePetNameLabel setText:petppixie.pixieName];
    //    ppixiePetNameLabel.position = CGPointMake(ppixiePetBtn.position.x, ppixiePetBtn.position.y+15);
    //    [self addChild:ppixiePetNameLabel];
    
    //    PPSpriteButton *  stopBtn = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(40, 30)];
    //    [stopBtn setLabelWithText:@"暂停" andFont:[UIFont systemFontOfSize:15] withColor:nil];
    //    stopBtn.position = CGPointMake(0.0f, 10.0f);
    //    stopBtn.name =@"stopBtn";
    //    [stopBtn addTarget:self selector:@selector(stopBtnClick:) withObject:stopBtn.name forControlEvent:PPButtonControlEventTouchUpInside];
    //    [self addChild:stopBtn];
    
    //    SKLabelNode *ppixieNameLabel=[[SKLabelNode alloc] init];
    //    ppixieNameLabel.fontSize=12;
    //    [ppixieNameLabel setColor:[SKColor redColor]];
    //    NSLog(@"pixieName=%@",enemyppixie.pixieName);
    //    [ppixieNameLabel setText:enemyppixie.pixieName];
    //    ppixieNameLabel.position = CGPointMake(ppixieEnemyBtn.position.x, ppixieEnemyBtn.position.y+15);
    //    [self addChild:ppixieNameLabel];
}

-(void)setComboLabelText:(int)petCombos withEnemy:(int)enemyCombos
{
    NSLog(@"combos:%d,%d",petCombos,enemyCombos);
    
    SKLabelNode *petCombosLabel = (SKLabelNode *)[self childNodeWithName:PP_PET_COMBOS_NAME];
    SKLabelNode *enemyCombosLabel = (SKLabelNode *)[self childNodeWithName:PP_ENEMY_COMBOS_NAME];
    
    [petCombosLabel setText:[NSString stringWithFormat:@"连击:%d", petCombos]];
    [enemyCombosLabel setText:[NSString stringWithFormat:@"连击:%d", enemyCombos]];
}

-(void)stopBtnClick:(NSString *)stringname
{
    if (self.target != nil && self.pauseSelector != nil &&
        [self.target respondsToSelector:self.pauseSelector])
    {
        [self.target performSelectorInBackground:self.pauseSelector withObject:self.name];
    }
}

-(void)physicsAttackClick:(PPCustomButton *)sender
{
    if (self.target != nil && self.showInfoSelector != nil && [self.target respondsToSelector:self.showInfoSelector])
    {
        [self.target performSelectorInBackground:self.showInfoSelector withObject:self.name];
    }
}
-(void)buffBtnClick:(NSString *)senderName
{
    
    
    
    
}
-(void)skillInvalidClick:(PPSpriteButton *)sender
{
    
    NSDictionary *skillChoosed = [self.currentPPPixie.pixieSkills objectAtIndex:[sender.name intValue] - PP_SKILLS_CHOOSE_BTN_TAG];
    
    if (self.target!=nil && self.skillInvalidSel!=nil && [self.target respondsToSelector:self.skillInvalidSel])
    {
        [self.target performSelectorInBackground:self.skillInvalidSel withObject:skillChoosed];
        
    }
    
}
-(void)skillSideClick:(PPSpriteButton *)sender
{
    
    NSDictionary *skillChoosed = [self.currentPPPixie.pixieSkills objectAtIndex:[sender.name intValue] - PP_SKILLS_CHOOSE_BTN_TAG];
    
    
    if (self.target!=nil && self.skillSelector!=nil && [self.target respondsToSelector:self.skillSelector])
    {
        [self.target performSelectorInBackground:self.skillSelector withObject:skillChoosed];
        
    }
    
}

-(void)enemyskillClick:(PPCustomButton *)sender
{
    NSDictionary * skillChoosed = [self.currentPPPixieEnemy.pixieSkills objectAtIndex:[sender.name intValue] - PP_SKILLS_CHOOSE_BTN_TAG];
    
    if (self.target != nil && self.skillSelector != nil && [self.target respondsToSelector:self.skillSelector])
    {
        [self.target performSelectorInBackground:self.skillSelector withObject:skillChoosed];
    }
}

-(void)setSideSkillButtonDisable
{
    
    for (int i = 0; i < [currentPPPixie.pixieSkills count]; i++) {
        PPSpriteButton * ppixieSkillBtn  = (PPSpriteButton *)[self childNodeWithName:[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i]];
        
        //        ppixieSkillBtn.alpha = 0.5;
        ppixieSkillBtn.color = [UIColor blackColor];
        ppixieSkillBtn.colorBlendFactor = 0.6;
        ppixieSkillBtn.userInteractionEnabled = NO;
    }
}

-(void)setSideSkillButtonEnable
{
    for (int i = 0; i < [currentPPPixie.pixieSkills count]; i++)
    {
        PPSpriteButton * ppixieSkillBtn  = (PPSpriteButton *)[self childNodeWithName:[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i]];
        
        //        ppixieSkillBtn.alpha = 1.0;
        ppixieSkillBtn.color = [UIColor orangeColor];
        ppixieSkillBtn.colorBlendFactor = 0.0;
        ppixieSkillBtn.userInteractionEnabled = YES;
    }
}

-(void)setBufferBar:(NSArray *)buffs
{
    
}

-(void)animatePetMPEnd:(NSNumber *)currentMp
{
}

-(void)animateEnemyMPEnd:(NSNumber *)currentMp
{
}

-(void)animatePetHPEnd:(NSNumber *)currentHp
{
    
    if (petPlayerHP->currentValue <= 0.0f) {
        if (!isHaveDead) {
            if (self.target != nil && self.hpBeenZeroSel != nil && [self.target respondsToSelector:self.hpBeenZeroSel]) {
                isHaveDead = YES;
                [self.target performSelectorInBackground:self.hpBeenZeroSel withObject:PP_PET_PLAYER_SIDE_NODE_NAME];
            }
        }
        
    }else{
        isHaveDead = NO;
        
        if (self.target != nil && self.hpChangeEnd != nil && [self.target respondsToSelector:self.hpChangeEnd]) {
            [self.target performSelectorInBackground:self.hpChangeEnd withObject:PP_PET_PLAYER_SIDE_NODE_NAME];
        }
    }
}

-(void)animateEnemyHPEnd:(NSNumber *)currentHp
{
    if (enemyPlayerHP->currentValue <= 0.0f) {
        if (!isHaveDead) {
            
            if (self.target != nil && self.hpBeenZeroSel != nil && [self.target respondsToSelector:self.hpBeenZeroSel]) {
                isHaveDead = YES;
                [self.target performSelectorInBackground:self.hpBeenZeroSel withObject:PP_ENEMY_SIDE_NODE_NAME];
            }
        }
    } else {
        isHaveDead = NO;
        
        if (self.target != nil && self.hpChangeEnd != nil && [self.target respondsToSelector:self.hpChangeEnd]) {
            [self.target performSelectorInBackground:self.hpChangeEnd withObject:PP_ENEMY_SIDE_NODE_NAME];
        }
    }
}

-(void)changePetHPValue:(CGFloat)HPValue
{
    
    if (HPValue<0.0f) {
        SKSpriteNode * additonLabel = [self getNumber:fabsf(HPValue) AndColor:@"white"];
        //    additonLabel.name  = @"hpchange";
        //    additonLabel.fontColor = [UIColor redColor];
        additonLabel.position = ppixiePetBtn.position;
        
        [self addChild:additonLabel];
        
        SKAction *actionScale = [SKAction scaleBy:1.5 duration:0.2];
        SKAction *actionFade = [SKAction fadeAlphaTo:0.0f duration:0.3];
        SKAction *showAction = [SKAction sequence:[NSArray arrayWithObjects:actionScale, actionFade, nil]];
        
        [additonLabel runAction:showAction completion:^{
            [additonLabel removeFromParent];
        }];
    }
    
    
    
    self.currentPPPixie.currentHP = [petPlayerHP valueShowChangeMaxValue:0 andCurrentValue:HPValue];
}

-(void)changeEnemyHPValue:(CGFloat)HPValue
{
    if (HPValue<0.0f) {
        SKSpriteNode * additonLabel = [self getNumber:fabsf(HPValue) AndColor:@"white"];
        //    additonLabel.name  = @"hpchange";
        //    additonLabel.fontColor = [UIColor redColor];
        additonLabel.position = ppixieEnemyBtn.position;
        [self addChild:additonLabel];
        
        SKAction * actionScale = [SKAction scaleBy:1.5 duration:0.2];
        SKAction * actionFade = [SKAction fadeAlphaTo:0.0f duration:0.3];
        SKAction * showAction = [SKAction sequence:[NSArray arrayWithObjects:actionScale, actionFade, nil]];
        
        [additonLabel runAction:showAction completion:^{
            [additonLabel removeFromParent];
        }];
    }
    
    
    self.currentPPPixieEnemy.currentHP =  [enemyPlayerHP valueShowChangeMaxValue:0 andCurrentValue:HPValue];
}

-(void)shakeHeadPortrait:(NSString *)stringSide andCompletion:(PPBallBattleScene *)sceneBattle
{
    if ([stringSide isEqualToString:PP_PET_PLAYER_SIDE_NODE_NAME]) {
        
        SKAction * actionLeft = [SKAction moveByX:-10 y:0.0f duration:0.1];
        SKAction * actionRight = [SKAction moveByX:20 y:0.0f duration:0.1];
        SKAction * actionOrigin = [SKAction moveTo:ppixieEnemyBtn.position duration:0.1];
        SKAction * actionTotal = [SKAction sequence:[NSArray arrayWithObjects:actionLeft,actionRight,actionOrigin,nil]];
        
        [ppixieEnemyBtn runAction:actionTotal completion:^{
            
            [sceneBattle physicsAttackAnimationEnd:stringSide];
            
        }];
    } else {
        SKAction * actionLeft = [SKAction moveByX:-10 y:0.0f duration:0.1];
        SKAction * actionRight = [SKAction moveByX:20 y:0.0f duration:0.1];
        SKAction * actionOrigin = [SKAction moveTo:ppixiePetBtn.position duration:0.1];
        SKAction * actionTotal = [SKAction sequence:[NSArray arrayWithObjects:actionLeft,actionRight,actionOrigin,nil]];
        
        [ppixiePetBtn runAction:actionTotal completion:^{
            [sceneBattle physicsAttackAnimationEnd:stringSide];
            
        }];
    }
}
-(int)physicsAttackHPChangeValueCalculate
{
    return 300;
}
-(void)changePetMPValue:(CGFloat)MPValue
{
    self.currentPPPixie.currentMP = [petPlayerMP valueShowChangeMaxValue:0 andCurrentValue:MPValue];
}

-(void)changeEnemyMPValue:(CGFloat)MPValue
{
    self.currentPPPixieEnemy.currentMP =  [enemyPlayerMP valueShowChangeMaxValue:0 andCurrentValue:MPValue];
}

-(void)changeHPValue:(CGFloat)HPValue
{
}

-(SKSpriteNode *)getNumber:(int)number AndColor:(NSString *)color {
    
    NSLog(@"color=%@ number=%d",color,number);
    
    SKSpriteNode * tNode = [[SKSpriteNode alloc] init];
    if (number < 1 || color == nil) return tNode;
    
    float width = 13.0f;
    
    // 拼接数字图片
    int i = 0;
    while (number > 0) {
        i++;
        int tNum = number % 10;
        number /= 10;
        
        NSString * tNumName = [NSString stringWithFormat:@"%@_%d.png", color, tNum];
        SKSpriteNode * tNumNode = [SKSpriteNode spriteNodeWithTexture:[[PPAtlasManager ui_number] textureNamed:tNumName]];
        tNumNode.position = CGPointMake(-width * i, 0);
        tNumNode.xScale = 0.5;
        tNumNode.yScale = 0.5;
        [tNode addChild:tNumNode];
    }
    
    // 调整位置居中
    for (SKSpriteNode * numNode in [tNode children]) {
        numNode.position = CGPointMake(numNode.position.x + (i+1) * width / 2, numNode.position.y);
    }
    return tNode;
}

-(void)addBuffShow:(PPBuff *)buffShow andSide:(NSString *)stringSide
{
    
    if ([stringSide isEqualToString:PP_PET_PLAYER_SIDE_NODE_NAME]) {
        PPSpriteButton *buffBtnFirstEmpty=nil;
        
        for (int i=0; i<3; i++) {
            PPSpriteButton *petBuffBtn=(PPSpriteButton *)[self childNodeWithName:[NSString stringWithFormat:@"%d",PP_BUFF_SHOW_BTN_TAG + i]];
            if ([petBuffBtn.PPBallSkillStatus isEqualToString:buffShow.buffId]) {
                return;
            }else if([petBuffBtn.PPBallSkillStatus isEqualToString:@"0"])
            {
                
                if (buffBtnFirstEmpty==nil) {
                    buffBtnFirstEmpty = petBuffBtn;
                    
                }
                break;
            }else
            {
                continue;
            }
            
        }
        
        [buffBtnFirstEmpty runAction:[SKAction setTexture:[[PPAtlasManager skill_buff] textureNamed:kBuffNameList[[buffShow.buffId intValue]]]]];
        buffBtnFirstEmpty.PPBallSkillStatus = buffShow.buffId;
        
    }else
    {
        PPSpriteButton *buffBtnFirstEmpty=nil;
        for (int i=0; i<3; i++) {
            
            PPSpriteButton *enemyBuffBtn=(PPSpriteButton *)[self childNodeWithName:[NSString stringWithFormat:@"%d",PP_BUFF_SHOW_BTN_TAG + i +10]];
            if ([enemyBuffBtn.PPBallSkillStatus isEqualToString:buffShow.buffId]) {
                return;
            }else if([enemyBuffBtn.PPBallSkillStatus isEqualToString:@"0"])
            {
                
                if (buffBtnFirstEmpty==nil) {
                    buffBtnFirstEmpty = enemyBuffBtn;
                    
                }
                break;
            }else
            {
                continue;
            }
        }
        
        //        [buffBtnFirstEmpty addChild:[SKSpriteNode spriteNodeWithTexture:[[PPAtlasManager skill_buff] textureNamed:kBuffNameList[[buffShow.buffId intValue]]]]];
        
        [buffBtnFirstEmpty runAction:[SKAction setTexture:[[PPAtlasManager skill_buff] textureNamed:kBuffNameList[[buffShow.buffId intValue]]]]];
        buffBtnFirstEmpty.PPBallSkillStatus = buffShow.buffId;
        
    }
    
    
}

-(void)removeBuffShow:(PPBuff *)buffShow andSide:(NSString *)stringSide
{
    
    
    if ([stringSide isEqualToString:PP_PET_PLAYER_SIDE_NODE_NAME]) {
        PPSpriteButton *buffBtnFirstEmpty=nil;
        
        for (int i=0; i<3; i++) {
            PPSpriteButton *petBuffBtn=(PPSpriteButton *)[self childNodeWithName:[NSString stringWithFormat:@"%d",PP_BUFF_SHOW_BTN_TAG + i]];
            
            SKTexture *defaultTexture=[[PPAtlasManager ui_fighting] textureNamed:[NSString stringWithFormat:@"%@_header_buffbar%d",kElementTypeString[currentPPPixie.pixieElement],i+1]];
            
            if (defaultTexture) {
                
                [petBuffBtn runAction:[SKAction setTexture:defaultTexture]];
                petBuffBtn.PPBallSkillStatus = @"0";
            }
        }
        
        [buffBtnFirstEmpty runAction:[SKAction setTexture:[[PPAtlasManager skill_buff] textureNamed:kBuffNameList[[buffShow.buffId intValue]]]]];
        buffBtnFirstEmpty.PPBallSkillStatus = buffShow.buffId;
        
    }else
    {
        
        for (int i=0; i<3; i++) {
            
            PPSpriteButton *enemyBuffBtn=(PPSpriteButton *)[self childNodeWithName:[NSString stringWithFormat:@"%d",PP_BUFF_SHOW_BTN_TAG + i +10]];
            if ([enemyBuffBtn.PPBallSkillStatus isEqualToString:buffShow.buffId]) {
                SKTexture *defaultTexture=[[PPAtlasManager ui_fighting] textureNamed:[NSString stringWithFormat:@"%@_header_buffbar%d",kElementTypeString[currentPPPixieEnemy.pixieElement],i+1]];
                
                if (defaultTexture) {
                    
                    [enemyBuffBtn runAction:[SKAction setTexture:defaultTexture]];
                    enemyBuffBtn.PPBallSkillStatus = @"0";
                }
                
                
                return;
            }
        }
    }    
}
-(void)startAttackAnimation:(BOOL)isPetAttack
{
    if (isPetAttack) {
        SKAction *action1=[SKAction moveByX:200 y:0.0f duration:1];
//        SKAction *action11=[[PPAtlasManager ball_action] getAnimation:[NSString stringWithFormat:@"%@3attack",kElementTypeString[currentPPPixie.pixieElement]]];
        SKAction *action111=[SKAction moveByX:-200 y:0.0f duration:1];
        SKAction *action1Result=[SKAction sequence:[NSArray arrayWithObjects:action1,action111, nil]];
        
        
//        SKAction *action2=[[PPAtlasManager  ball_action] getAnimation:[NSString stringWithFormat:@"%@3move",kElementTypeString[currentPPPixie.pixieElement]]];
//        SKAction *action3=[SKAction repeatActionForever:action2];
        
//        SKAction *result=[SKAction group:[NSArray arrayWithObjects:action1Result,action2, nil]];
        
        [ppixiePetBtn runAction:action1Result];
        
        
    }else
    {
//        SKAction *action1=[SKAction moveToX:200.0f duration:3];
//        SKAction *action2=[[PPAtlasManager  ball_action] getAnimation:[NSString stringWithFormat:@"%@3move",kElementTypeString[currentPPPixieEnemy.pixieElement]]];
//        SKAction *action3=[SKAction repeatActionForever:action2];
//        SKAction *result=[SKAction group:[NSArray arrayWithObjects:action1,action3, nil]];
//        [ppixieEnemyBtn runAction:result];
    }
}

@end
