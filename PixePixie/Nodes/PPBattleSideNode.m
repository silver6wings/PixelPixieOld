
#import "PPBattleSideNode.h"

@implementation PPBattleSideNode
@synthesize target=_target;
@synthesize skillSelector=_skillSelector;
@synthesize currentPPPixie;
@synthesize currentPPPixieEnemy;
@synthesize showInfoSelector;
@synthesize hpBeenZeroSel;

-(void)setSideElementsForPet:(PPPixie *)ppixie
{
    
    PPCustomButton*ppixieBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f)
                                                     andImage:@"ball_pixie_plant2.png"
                                                   withTarget:self
                                                 withSelecter:@selector(physicsAttackClick:)];
    ppixieBtn.position = CGPointMake(-self.size.width/2.0f+ppixieBtn.frame.size.width/2.0f+20.0F, -10.0f);
    [self addChild:ppixieBtn];
    
    
    PPBasicLabelNode *ppixieBtnLabel=[[PPBasicLabelNode alloc] init];
    ppixieBtnLabel.fontSize=10;
    [ppixieBtnLabel setColor:[SKColor redColor]];
    NSLog(@"pixieName=%@",ppixie.pixieName);
    [ppixieBtnLabel setText:@"信息查看"];
    ppixieBtnLabel.position = CGPointMake(0.0F, 0);
    [ppixieBtn addChild:ppixieBtnLabel];
    
    self.currentPPPixie = ppixie;
    
    PPBasicLabelNode *ppixieNameLabel=[[PPBasicLabelNode alloc] init];
    ppixieNameLabel.fontSize=12;
    [ppixieNameLabel setColor:[SKColor blueColor]];
    NSLog(@"pixieName=%@",ppixie.pixieName);
    [ppixieNameLabel setText:ppixie.pixieName];
    ppixieNameLabel.position = CGPointMake(ppixieBtn.position.x, ppixieBtn.position.y+15);
    [self addChild:ppixieNameLabel];
    
    // 添加 HP bar
    barPlayerHP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(90, 6)];
    [barPlayerHP setMaxValue:ppixie.pixieHPmax andCurrentValue:ppixie.currentHP andShowType:PP_HPTYPE];
    barPlayerHP->target = self;
    barPlayerHP->animateEnd = @selector(animateEnd:);
    barPlayerHP.anchorPoint = CGPointMake(0, 0.0);
    barPlayerHP.position = CGPointMake(ppixieBtn.position.x+40.0f,15.0);
    [self addChild:barPlayerHP];
    
    NSArray *skillsArray = [NSArray arrayWithArray:ppixie.pixieSkills];
    
    for (int i = 0; i < [ppixie.pixieSkills count]; i++) {
        
        PPSpriteButton *  passButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(60, 30)];
        
        [passButton setLabelWithText:[[skillsArray objectAtIndex:i] objectForKey:@"skillname"] andFont:[UIFont systemFontOfSize:15] withColor:nil];
        passButton.position = CGPointMake(ppixieBtn.position.x+70.0f*i+70, -10.0f);
        
        passButton.name =[NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i];
        [passButton addTarget:self selector:@selector(skillClick:) withObject:passButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:passButton];
        
        
//        PPCustomButton *ppixieSkillBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f)
//                                                              andTitle:[[skillsArray objectAtIndex:i] objectForKey:@"skillname"]
//                                                            withTarget:self
//                                                          withSelecter:@selector(skillClick:)];
//        ppixieSkillBtn.name = [NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i];
//        ppixieSkillBtn.position = CGPointMake(ppixieBtn.position.x+70.0f*i+70, -30.0f);
//        [self addChild:ppixieSkillBtn];
        
    }
    
}

-(void)setSideElementsForEnemy:(PPPixie *)ppixie
{
    
    PPCustomButton *ppixieBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f)
                                                      andImage:@"ball_pixie_plant2.png"
                                                    withTarget:self
                                                  withSelecter:@selector(physicsAttackClick:)];
    ppixieBtn.position = CGPointMake(0.0f, -10.0f);
    
    [self addChild:ppixieBtn];
    
    
    PPBasicLabelNode *ppixieBtnLabel = [[PPBasicLabelNode alloc] init];
    ppixieBtnLabel.fontSize = 10;
    NSLog(@"pixieName=%@",ppixie.pixieName);
    [ppixieBtnLabel setText:@"信息查看"];
    ppixieBtnLabel.position = CGPointMake(0, 0);
    [ppixieBtn addChild:ppixieBtnLabel];
    
    self.currentPPPixieEnemy = ppixie;
    
    PPBasicLabelNode *ppixieNameLabel=[[PPBasicLabelNode alloc] init];
    ppixieNameLabel.fontSize=12;
    [ppixieNameLabel setColor:[SKColor redColor]];
    NSLog(@"pixieName=%@",ppixie.pixieName);
    [ppixieNameLabel setText:ppixie.pixieName];
    ppixieNameLabel.position = CGPointMake(ppixieBtn.position.x, ppixieBtn.position.y+15);
    [self addChild:ppixieNameLabel];
    
    // 添加 HP bar
    barPlayerHP = [PPValueShowNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(90, 6)];
    [barPlayerHP setMaxValue:ppixie.pixieHPmax andCurrentValue:ppixie.currentHP andShowType:PP_HPTYPE];
    barPlayerHP->target=self;
    barPlayerHP->animateEnd=@selector(animateEnd:);
    barPlayerHP.anchorPoint = CGPointMake(0, 0.0);
    barPlayerHP.position = CGPointMake(-40.0f,15.0);
    [self addChild:barPlayerHP];
    
    
//    for (int i=0; i<[ppixie.pixieSkills count]; i++) {
//        PPCustomButton*ppixieSkillBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f)
//                                                              andTitle:[[ppixie.pixieSkills objectAtIndex:i] objectForKey:@"skillname"]
//                                                            withTarget:self
//                                                          withSelecter:@selector(enemyskillClick:)];
//        
//        ppixieSkillBtn.name = [NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG+i];
//        ppixieSkillBtn.position = CGPointMake(ppixieBtn.position.x+70.0f*i+70, -30.0f);
//        [self addChild:ppixieSkillBtn];
//    }
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

-(void)animateEnd:(NSNumber *)currentHp
{
    if (barPlayerHP->currentValue <= 0.0f) {
        if (self.target != nil && self.hpBeenZeroSel != nil && [self.target respondsToSelector:self.hpBeenZeroSel]) {
            [self.target performSelectorInBackground:self.hpBeenZeroSel withObject:self];
        }
    }
}

-(void)changeHPValue:(CGFloat)HPValue
{
    [barPlayerHP valueShowChangeMaxValue:0 andCurrentValue:HPValue];
}

@end
