
#import "PPMenuDungeonScene.h"

@interface PPMenuDungeonScene()
@end

@implementation PPMenuDungeonScene
@synthesize passDictInfo;

-(id)initWithSize:(CGSize)size andElement:(PPElementType)elementType{
    if (self = [super initWithSize:size]) {
        [self setBackTitleText:@"小场景" andPositionY:450.0f];
        [self setBackgroundColor:[UIColor purpleColor]];
        
        [self addPassChoose];
    }
    return self;
}

-(void)introduceInfoLabel:(NSString *)text
{
    PPBasicSpriteNode * enemyDeadContent = [[PPBasicSpriteNode alloc] initWithColor:[UIColor orangeColor] size:CGSizeMake(320, 350)];
    [enemyDeadContent setPosition:CGPointMake(160, 200)];
    [self addChild:enemyDeadContent];
    
    PPBasicLabelNode * labelNode = (PPBasicLabelNode *)[self childNodeWithName:@"RoundLabel"];
    if (labelNode) [labelNode removeFromParent];
    
    PPBasicLabelNode * additonLabel = [[PPBasicLabelNode alloc] init];
    additonLabel.name  = @"titleLabel";
    additonLabel.fontColor = [UIColor redColor];
    additonLabel.position = CGPointMake(0, 100);
    [additonLabel setText:text];
    [enemyDeadContent addChild:additonLabel];
    
    PPBasicLabelNode * infoContentLabel = [[PPBasicLabelNode alloc] init];
    infoContentLabel.name  = @"contentLabel";
    infoContentLabel.fontColor = [UIColor redColor];
    infoContentLabel.position = CGPointMake(0, 0);
    [infoContentLabel setText:@"介绍内容"];
    [enemyDeadContent addChild:infoContentLabel];
    
    PPSpriteButton * confirmButton = [PPSpriteButton buttonWithColor:[UIColor blueColor] andSize:CGSizeMake(90, 60)];
    confirmButton.position = CGPointMake(0, -100);
    [confirmButton setLabelWithText:@"知道" andFont:[UIFont systemFontOfSize:15] withColor:nil];
    [confirmButton addTarget:self selector:@selector(confirmBtnClick:) withObject:enemyDeadContent
             forControlEvent:PPButtonControlEventTouchUpInside];
    [enemyDeadContent addChild:confirmButton];
}

-(void)confirmBtnClick:(PPBasicSpriteNode *)contentNode
{
    if (contentNode != nil) {
        [contentNode removeFromParent];
        contentNode = nil;
    }
}

-(void)addPassChoose
{
    for (int i = 0; i < 5; i++) {
        PPSpriteButton *  passButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(90, 60)];
        
        [passButton setLabelWithText:[NSString stringWithFormat:@"副本 %d",5-i] andFont:[UIFont systemFontOfSize:15] withColor:nil];
        passButton.position = CGPointMake(160.0f,i*70+60);
        passButton.name = [NSString stringWithFormat:@"%d",i+PP_SECONDARY_PASSNUM_BTN_TAG];
        [passButton addTarget:self selector:@selector(menuDungeonGoForward:)
                   withObject:passButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:passButton];
        
        PPSpriteButton * passIntroduceButton = [PPSpriteButton buttonWithColor:[UIColor redColor] andSize:CGSizeMake(30, 30)];
        [passIntroduceButton setLabelWithText:[NSString stringWithFormat:@"%d信息",5-i]
                                      andFont:[UIFont systemFontOfSize:11] withColor:nil];
        passIntroduceButton.position = CGPointMake(passButton.position.x + 60.0f,passButton.position.y + 15.0f);
        passIntroduceButton.name = [NSString stringWithFormat:@"副本%d介绍",5-i];
        [passIntroduceButton addTarget:self selector:@selector(introduceInfoLabel:) withObject:passIntroduceButton.name
                       forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:passIntroduceButton];
    }
}

-(void)menuDungeonGoForward:(NSString *)stringName
{
    [self enterHurdleReady];
}

-(void)enterHurdleReady
{
    SKNode * spriteNode = [self childNodeWithName:PP_GOFORWARD_MENU_DUNGEON_FIGHTING];
    if (spriteNode) [spriteNode removeFromParent];
    
    NSDictionary * dictEnemy = [NSDictionary dictionaryWithContentsOfFile:
                                [[NSBundle mainBundle]pathForResource:@"EnemyInfo" ofType:@"plist"]];
    
//    PPHurdleReadyScene * battleScene = [[PPHurdleReadyScene alloc] initWithSize:self.view.bounds.size];
//    battleScene.allEnemys = dictEnemy;
//    battleScene->previousScene = self;
//    [battleScene setEnemysArray];
//    [battleScene setCurrentHurdle:0];

    PPHurdleReadyScene * battleScene = [[PPHurdleReadyScene alloc] initWithSize:self.view.bounds.size];
    battleScene.allEnemys = dictEnemy;
    battleScene->previousScene = self;
    [battleScene setEnemysArray];
    [battleScene setCurrentHurdle:0];
    [self.view presentScene:battleScene];
}

-(void)backButtonClick:(NSString *)backName
{
    [self.view presentScene:previousScene];
}

@end
