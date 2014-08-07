
#import "PPBattleSideNode.h"

@implementation PPBattleSideNode
@synthesize target=_target;
@synthesize skillSelector=_skillSelector;
@synthesize currentPPPixie;
@synthesize currentPPPixieEnemy;
@synthesize showInfoSelector;
@synthesize hpBeenZeroSel;
@synthesize pauseSelector;

-(void)setSideSkillsBtn:(PPPixie *)ppixie
{
    
    NSArray *skillsArray = [NSArray arrayWithArray:ppixie.pixieSkills];
    self.currentPPPixie = ppixie;
    
    for (int i = 0; i < [ppixie.pixieSkills count]; i++) {
        
        PPSpriteButton *  passButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(60, 45)];
        [passButton setLabelWithText:[[skillsArray objectAtIndex:i] objectForKey:@"skillname"] andFont:[UIFont systemFontOfSize:15] withColor:nil];
        passButton.position = CGPointMake((320.0f/[ppixie.pixieSkills count]+10)*i-110, -10.0f);
        passButton.name =[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i];
        [passButton addTarget:self selector:@selector(skillClick:) withObject:passButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:passButton];
        
        
        
        
        PPSpriteButton *  skillCdButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(60, 15)];
        [skillCdButton setLabelWithText:[NSString stringWithFormat:@"cd:%@",[[skillsArray objectAtIndex:i] objectForKey:@"skillcdrounds"]] andFont:[UIFont systemFontOfSize:15] withColor:nil];
        skillCdButton.position = CGPointMake(passButton.position.x, passButton.position.y+15);
        [skillCdButton setColor:[UIColor blackColor]];
        skillCdButton.name =[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i];
        [skillCdButton addTarget:self selector:@selector(skillClick:) withObject:passButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:skillCdButton];
        
        
    }
    
}

-(void)setSideElements:(PPPixie *)petppixie andEnemy:(PPPixie *)enemyppixie;{
    
    
    PPCustomButton*ppixiePetBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f)
                                                     andImage:@"ball_pixie_plant2.png"
                                                   withTarget:self
                                                 withSelecter:@selector(physicsAttackClick:)];
    ppixiePetBtn.position = CGPointMake(-self.size.width/2.0f+ppixiePetBtn.frame.size.width/2.0f+10.0f, -10.0f);
    [self addChild:ppixiePetBtn];
    
    
    
    PPBasicLabelNode *ppixiePetBtnLabel=[[PPBasicLabelNode alloc] init];
    ppixiePetBtnLabel.fontSize=10;
    [ppixiePetBtnLabel setColor:[SKColor redColor]];
    NSLog(@"pixieName=%@",petppixie.pixieName);
    [ppixiePetBtnLabel setText:@"信息查看"];
    ppixiePetBtnLabel.position = CGPointMake(0.0F, 0);
    [ppixiePetBtn addChild:ppixiePetBtnLabel];
    
   
    
    
    self.currentPPPixie = petppixie;
    self.currentPPPixieEnemy = enemyppixie;
    
    
    PPBasicLabelNode *ppixiePetNameLabel=[[PPBasicLabelNode alloc] init];
    ppixiePetNameLabel.fontSize=12;
    [ppixiePetNameLabel setColor:[SKColor blueColor]];
    NSLog(@"pixieName=%@",petppixie.pixieName);
    [ppixiePetNameLabel setText:petppixie.pixieName];
    ppixiePetNameLabel.position = CGPointMake(ppixiePetBtn.position.x, ppixiePetBtn.position.y+15);
    [self addChild:ppixiePetNameLabel];
    
    
    

    PPSpriteButton *  stopBtn = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(40, 30)];
    [stopBtn setLabelWithText:@"暂停" andFont:[UIFont systemFontOfSize:15] withColor:nil];
    stopBtn.position = CGPointMake(0.0f, 10.0f);
    stopBtn.name =@"stopBtn";
    [stopBtn addTarget:self selector:@selector(stopBtnClick:) withObject:stopBtn.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:stopBtn];
    
    
    // 添加 HP bar
    petPlayerHP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(90, 6)];
    [petPlayerHP setMaxValue:petppixie.pixieHPmax andCurrentValue:petppixie.currentHP andShowType:PP_HPTYPE andAnchorPoint:CGPointMake(0.0f, 0.5f)];
    petPlayerHP->target = self;
    petPlayerHP->animateEnd = @selector(animatePetEnd:);
    petPlayerHP.anchorPoint = CGPointMake(0.5, 0.5);
    petPlayerHP.position = CGPointMake(-stopBtn.size.width/2.0f-petPlayerHP.size.width/2.0f,ppixiePetBtn.position.y+5.0f);
    [self addChild:petPlayerHP];
    
    
    //能量条
    petPlayerMP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(90, 6)];
    [petPlayerMP setMaxValue:petppixie.pixieMPmax andCurrentValue:petppixie.currentMP andShowType:PP_MPTYPE andAnchorPoint:CGPointMake(0.0f, 0.5f)];
    petPlayerMP->target = self;
    petPlayerMP->animateEnd = @selector(animatePetEnd:);
    petPlayerMP.anchorPoint = CGPointMake(0.5, 0.5);
    petPlayerMP.position = CGPointMake(-stopBtn.size.width/2.0f-petPlayerHP.size.width/2.0f,ppixiePetBtn.position.y-15);
    [self addChild:petPlayerMP];
    
    
    // 添加 HP bar
    enemyPlayerHP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(90, 6)];
    [enemyPlayerHP setMaxValue:enemyppixie.pixieHPmax andCurrentValue:enemyppixie.currentHP andShowType:PP_HPTYPE andAnchorPoint:CGPointMake(1.0f, 0.5f)];
    enemyPlayerHP->target=self;
    enemyPlayerHP->animateEnd=@selector(animateEnemyEnd:);
    enemyPlayerHP.anchorPoint = CGPointMake(0.5, 0.5);
    enemyPlayerHP.position = CGPointMake(stopBtn.size.width/2.0f+enemyPlayerHP.size.width/2.0f,ppixiePetBtn.position.y+5.0f);
    [self addChild:enemyPlayerHP];
    
    
    enemyPlayerMP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(90, 6)];
    [enemyPlayerMP setMaxValue:enemyppixie.pixieMPmax andCurrentValue:enemyppixie.currentMP andShowType:PP_MPTYPE andAnchorPoint:CGPointMake(1.0f, 0.5f)];
    enemyPlayerMP->target = self;
    enemyPlayerMP->animateEnd = @selector(animatePetEnd:);
    enemyPlayerMP.anchorPoint = CGPointMake(0.5, 0.5);
    enemyPlayerMP.position = CGPointMake(stopBtn.size.width/2.0f+enemyPlayerHP.size.width/2.0f,ppixiePetBtn.position.y-15);
    [self addChild:enemyPlayerMP];
    
    
    PPCustomButton *ppixieEnemyBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f)
                                                           andImage:@"ball_pixie_plant2.png"
                                                         withTarget:self
                                                       withSelecter:@selector(physicsAttackClick:)];
    ppixieEnemyBtn.position = CGPointMake(enemyPlayerHP.position.x+enemyPlayerHP.size.width/2.0f+20.0f,-10.0f);
    
    [self addChild:ppixieEnemyBtn];
    
    
    
    PPBasicLabelNode *ppixieBtnLabel = [[PPBasicLabelNode alloc] init];
    ppixieBtnLabel.fontSize = 10;
    NSLog(@"pixieName=%@",enemyppixie.pixieName);
    [ppixieBtnLabel setText:@"信息查看"];
    ppixieBtnLabel.position = CGPointMake(0, 0);
    [ppixieEnemyBtn addChild:ppixieBtnLabel];
    
    
    self.currentPPPixieEnemy = enemyppixie;
    
    
    PPBasicLabelNode *ppixieNameLabel=[[PPBasicLabelNode alloc] init];
    ppixieNameLabel.fontSize=12;
    [ppixieNameLabel setColor:[SKColor redColor]];
    NSLog(@"pixieName=%@",enemyppixie.pixieName);
    [ppixieNameLabel setText:enemyppixie.pixieName];
    ppixieNameLabel.position = CGPointMake(ppixieEnemyBtn.position.x, ppixieEnemyBtn.position.y+15);
    [self addChild:ppixieNameLabel];
    
    
    
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
    if (self.target != nil && self.showInfoSelector != nil &&
        [self.target respondsToSelector:self.showInfoSelector])
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
    
    for (int i = 0; i < [currentPPPixie.pixieSkills count]; i++) {
        PPSpriteButton *ppixieSkillBtn  =(PPSpriteButton *)[self childNodeWithName:[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i]];
        [ppixieSkillBtn setColor:[UIColor orangeColor]];
        ppixieSkillBtn.userInteractionEnabled = YES;
    }
    
}

-(void)animatePetEnd:(NSNumber *)currentHp
{
    
    if (petPlayerHP->currentValue <= 0.0f) {
        if (self.target != nil && self.hpBeenZeroSel != nil && [self.target respondsToSelector:self.hpBeenZeroSel]) {
            [self.target performSelectorInBackground:self.hpBeenZeroSel withObject:PP_PET_PLAYER_SIDE_NODE_NAME];
        }
    }
    
}
-(void)animateEnemyEnd:(NSNumber *)currentHp
{
    
    if (enemyPlayerHP->currentValue <= 0.0f) {
        if (self.target != nil && self.hpBeenZeroSel != nil && [self.target respondsToSelector:self.hpBeenZeroSel]) {
            [self.target performSelectorInBackground:self.hpBeenZeroSel withObject:PP_ENEMY_SIDE_NODE_NAME];
        }
    }
    
}
-(void)changePetHPValue:(CGFloat)HPValue
{
    [petPlayerHP valueShowChangeMaxValue:0 andCurrentValue:HPValue];
}
-(void)changeEnemyHPValue:(CGFloat)HPValue
{
    [enemyPlayerHP valueShowChangeMaxValue:0 andCurrentValue:HPValue];
}
-(void)changeHPValue:(CGFloat)HPValue
{

}

@end
