
#import "PPBattleInfoLayer.h"

@implementation PPBattleInfoLayer

@synthesize target=_target;
@synthesize skillSelector=_skillSelector;
@synthesize currentPPPixie;
@synthesize currentPPPixieEnemy;
@synthesize showInfoSelector;
@synthesize hpBeenZeroSel;
@synthesize pauseSelector;
@synthesize hpChangeEnd;

// 设置技能
-(void)setSideSkillsBtn:(PPPixie *)ppixie
{
    // 添加下方背景图片
    SKSpriteNode * bgSprite = [SKSpriteNode spriteNodeWithTexture:[[TextureManager ui_fighting] textureNamed:@"footer_back"]];
    bgSprite.size = CGSizeMake(320.0f, 80.0f);
    bgSprite.position = CGPointMake(0.0f,0.0f);
    [self addChild:bgSprite];
    
    self.currentPPPixie = ppixie;
    NSLog(@"pixieSkills count=%lu", (unsigned long)[ppixie.pixieSkills count]);
    
    // 添加技能槽
    for (int i = 0; i < 4; i++) {
        PPSpriteButton * passButton = [PPSpriteButton buttonWithTexture:[[TextureManager ui_fighting] textureNamed:@"header_buffbar1"]
                                                                andSize:CGSizeMake(50.0f, 50.0f)];
        passButton.position = CGPointMake(65*i - 112.0f, 0.0f);
        passButton.name =[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG + i];
        [passButton addTarget:self selector:@selector(skillClick:)
                   withObject:passButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:passButton];
        
        /*
        PPSpriteButton *  passButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(50.0f, 50.0f)];
        PPSpriteButton *  skillCdButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(60, 15)];
        [skillCdButton setLabelWithText:[NSString stringWithFormat:@"cd:%@",[[skillsArray objectAtIndex:i] objectForKey:@"skillcdrounds"]] andFont:[UIFont systemFontOfSize:15] withColor:nil];
        skillCdButton.position = CGPointMake(passButton.position.x, passButton.position.y+15);
        [skillCdButton setColor:[UIColor blackColor]];
        skillCdButton.name =[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i];
        [skillCdButton addTarget:self selector:@selector(skillClick:) withObject:passButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:skillCdButton];
        */
    }
    
    //暂停按钮
    PPSpriteButton *  stopBtn = [PPSpriteButton buttonWithTexture:[[TextureManager ui_fighting] textureNamed:@"footer_play"]
                                                          andSize:CGSizeMake(32.5, 32.5)];
    stopBtn.position = CGPointMake(130.0f, 0.0f);
    stopBtn.name = @"stopBtn";
    [stopBtn addTarget:self selector:@selector(stopBtnClick:)
            withObject:stopBtn.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:stopBtn];
}

-(void)setSideElements:(PPPixie *)playerpixie andEnemy:(PPPixie *)enemyppixie;{
    
    self.currentPPPixie = playerpixie;
    self.currentPPPixieEnemy = enemyppixie;
    
    // 添加上方背景图片
    SKSpriteNode * bgSprite = [SKSpriteNode spriteNodeWithTexture:[[TextureManager ui_fighting] textureNamed:@"header_back"]];
    bgSprite.size = CGSizeMake(320.0f, 80.0f);
    bgSprite.position = CGPointMake(0.0f,0.0f);
    [self addChild:bgSprite];
    
    // 己方头像
    PPSpriteButton *ppixiePetBtn = [PPSpriteButton buttonWithTexture:[[TextureManager ui_fighting] textureNamed:@"header_portrait"]
                                                             andSize:CGSizeMake(32.5f, 32.5f)];
    [ppixiePetBtn addTarget:self selector:@selector(physicsAttackClick:) withObject:@"" forControlEvent:PPButtonControlEventTouchUp];
    ppixiePetBtn.position = CGPointMake(-121.5f, 20.0f);
    ppixiePetBtn.xScale = -1.0f;
    [self addChild:ppixiePetBtn];
    
    // 己方连击数
    PPBasicLabelNode *ppixiePetBtnLabel = [[PPBasicLabelNode alloc] init];
    ppixiePetBtnLabel.fontSize = 10;
    ppixiePetBtnLabel.name = PP_PET_COMBOS_NAME;
    [ppixiePetBtnLabel setColor:[SKColor redColor]];
    NSLog(@"pixieName = %@",playerpixie.pixieName);
    [ppixiePetBtnLabel setText:@"连击:0"];
    ppixiePetBtnLabel.position = CGPointMake(ppixiePetBtn.position.x,ppixiePetBtn.position.y - 40);
    [self addChild:ppixiePetBtnLabel];
    
    // 己方生命条
    petPlayerHP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(100.0f, 20)];
    [petPlayerHP setMaxValue:playerpixie.pixieHPmax andCurrentValue:playerpixie.currentHP
                 andShowType:PP_HPTYPE andAnchorPoint:CGPointMake(0.0f, 0.5f)];
    petPlayerHP->target = self;
    petPlayerHP->animateEnd = @selector(animatePetHPEnd:);
    petPlayerHP.anchorPoint = CGPointMake(0.5, 0.5);
    petPlayerHP.position = CGPointMake(-52.5,20.0f);
    [self addChild:petPlayerHP];
    
    // 己方能量条
    petPlayerMP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(100, 10)];
    [petPlayerMP setMaxValue:playerpixie.pixieMPmax andCurrentValue:playerpixie.currentMP
                 andShowType:PP_MPTYPE andAnchorPoint:CGPointMake(0.0f, 0.5f)];
    petPlayerMP->target = self;
    petPlayerMP->animateEnd = @selector(animatePetMPEnd:);
    petPlayerMP.anchorPoint = CGPointMake(0.5, 0.5);
    petPlayerMP.position = CGPointMake(petPlayerHP.position.x,ppixiePetBtn.position.y-20);
    [self addChild:petPlayerMP];
    
    // 敌方生命条
    enemyPlayerHP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor]
                                                    size:CGSizeMake(petPlayerHP.size.width, petPlayerHP.size.height)];
    [enemyPlayerHP setMaxValue:enemyppixie.pixieHPmax andCurrentValue:enemyppixie.currentHP
                   andShowType:PP_HPTYPE andAnchorPoint:CGPointMake(1.0f, 0.5f)];
    enemyPlayerHP->target = self;
    enemyPlayerHP->animateEnd = @selector(animateEnemyHPEnd:);
    enemyPlayerHP.anchorPoint = CGPointMake(0.5, 0.5);
    enemyPlayerHP.position = CGPointMake(52.5,petPlayerHP.position.y);
    [self addChild:enemyPlayerHP];
    
    // 敌方能量条
    enemyPlayerMP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor]
                                                    size:CGSizeMake(petPlayerMP.size.width, petPlayerMP.size.height)];
    [enemyPlayerMP setMaxValue:enemyppixie.pixieMPmax andCurrentValue:enemyppixie.currentMP
                   andShowType:PP_MPTYPE andAnchorPoint:CGPointMake(1.0f, 0.5f)];
    enemyPlayerMP->target = self;
    enemyPlayerMP->animateEnd = @selector(animateEnemyMPEnd:);
    enemyPlayerMP.anchorPoint = CGPointMake(0.5, 0.5);
    enemyPlayerMP.position = CGPointMake(enemyPlayerHP.position.x,petPlayerMP.position.y);
    [self addChild:enemyPlayerMP];

    // 敌方头像
    PPSpriteButton * ppixieEnemyBtn = [PPSpriteButton buttonWithTexture:[[TextureManager ui_fighting] textureNamed:@"header_portrait"]
                                                               andSize:CGSizeMake(32.5f, 32.5f)];
    [ppixieEnemyBtn addTarget:self selector:@selector(physicsAttackClick:) withObject:@"" forControlEvent:PPButtonControlEventTouchUp];
    ppixieEnemyBtn.position = CGPointMake(enemyPlayerHP.position.x + enemyPlayerHP.size.width/2.0f + 20.0f,ppixiePetBtn.position.y);
    [self addChild:ppixieEnemyBtn];
    
    // 敌方连击数
    PPBasicLabelNode *ppixieBtnLabel = [[PPBasicLabelNode alloc] init];
    ppixieBtnLabel.fontSize = 10;
    ppixieBtnLabel.name = PP_ENEMY_COMBOS_NAME;
    NSLog(@"pixieName=%@",enemyppixie.pixieName);
    [ppixieBtnLabel setText:@"连击:0"];
    ppixieBtnLabel.position = CGPointMake(ppixieEnemyBtn.position.x, ppixiePetBtnLabel.position.y);
    [self addChild:ppixieBtnLabel];
    
    //    PPBasicLabelNode *ppixiePetNameLabel=[[PPBasicLabelNode alloc] init];
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
    
    //    PPBasicLabelNode *ppixieNameLabel=[[PPBasicLabelNode alloc] init];
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
    
    PPBasicLabelNode *petCombosLabel = (PPBasicLabelNode *)[self childNodeWithName:PP_PET_COMBOS_NAME];
    PPBasicLabelNode *enemyCombosLabel = (PPBasicLabelNode *)[self childNodeWithName:PP_ENEMY_COMBOS_NAME];
    
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

-(void)skillClick:(NSString *)senderName
{
    NSDictionary *skillChoosed = [self.currentPPPixie.pixieSkills objectAtIndex:[senderName intValue] - PP_SKILLS_CHOOSE_BTN_TAG];
    
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
       PPSpriteButton *ppixieSkillBtn  =(PPSpriteButton *)[self childNodeWithName:[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i]];
        [ppixieSkillBtn setColor:[UIColor redColor]];
        ppixieSkillBtn.userInteractionEnabled = NO;
    }
}

-(void)setSideSkillButtonEnable
{
    for (int i = 0; i < [currentPPPixie.pixieSkills count]; i++)
    {
        PPSpriteButton * ppixieSkillBtn  = (PPSpriteButton *)[self childNodeWithName:[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i]];
        [ppixieSkillBtn setColor:[UIColor orangeColor]];
        ppixieSkillBtn.userInteractionEnabled = YES;
    }
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
        if (self.target != nil && self.hpBeenZeroSel != nil && [self.target respondsToSelector:self.hpBeenZeroSel]) {
            [self.target performSelectorInBackground:self.hpBeenZeroSel withObject:PP_PET_PLAYER_SIDE_NODE_NAME];
        }
    }else{
        if (self.target != nil && self.hpChangeEnd != nil && [self.target respondsToSelector:self.hpChangeEnd]) {
            [self.target performSelectorInBackground:self.hpChangeEnd withObject:PP_PET_PLAYER_SIDE_NODE_NAME];
        }
    }
}

-(void)animateEnemyHPEnd:(NSNumber *)currentHp
{
    if (enemyPlayerHP->currentValue <= 0.0f) {
        if (self.target != nil && self.hpBeenZeroSel != nil && [self.target respondsToSelector:self.hpBeenZeroSel]) {
            [self.target performSelectorInBackground:self.hpBeenZeroSel withObject:PP_ENEMY_SIDE_NODE_NAME];
        }
    } else {
        if (self.target != nil && self.hpChangeEnd != nil && [self.target respondsToSelector:self.hpChangeEnd]) {
            [self.target performSelectorInBackground:self.hpChangeEnd withObject:PP_ENEMY_SIDE_NODE_NAME];
        }
    }
}

-(void)changePetHPValue:(CGFloat)HPValue
{
    self.currentPPPixie.currentHP = [petPlayerHP valueShowChangeMaxValue:0 andCurrentValue:HPValue];
}
-(void)changeEnemyHPValue:(CGFloat)HPValue
{
    self.currentPPPixieEnemy.currentHP =  [enemyPlayerHP valueShowChangeMaxValue:0 andCurrentValue:HPValue];
}

-(void)changePetMPValue:(CGFloat)HPValue
{
    self.currentPPPixie.currentMP = [petPlayerMP valueShowChangeMaxValue:0 andCurrentValue:HPValue];
}

-(void)changeEnemyMPValue:(CGFloat)HPValue
{
    self.currentPPPixieEnemy.currentMP =  [enemyPlayerMP valueShowChangeMaxValue:0 andCurrentValue:HPValue];
}

-(void)changeHPValue:(CGFloat)HPValue
{
}

@end
