//
//  PPMainScene.m
//  PixelPixie
//
//  Created by xiefei on 5/21/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPMainScene.h"

@implementation PPMainScene
@synthesize chooseCouterpartSel=_chooseCouterpartSel;
@synthesize chooseTarget=_chooseTarget;
CGPoint couterpartPosition[]={
    {150.0f,300.0f}
};
NSString *couterpartName[]={
 @"有朋友给你的宠物喂食了!",
    @"world boss"
};
- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        
        self.backgroundColor = [UIColor blueColor];
        
        PPSpriteButton *monsterButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(120.0f, 30.0f)];
        [monsterButton setLabelWithText:couterpartName[0] andFont:[UIFont systemFontOfSize:10] withColor:nil];
        monsterButton.position = CGPointMake(160.0f,350.0f);
        monsterButton.name=@"";
        [monsterButton addTarget:self selector:@selector(monsterButtonClick:) withObject:monsterButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:monsterButton];
        
        PPSpriteButton *worldBossButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(60.0f, 30.0f)];
        [worldBossButton setLabelWithText:couterpartName[1] andFont:[UIFont systemFontOfSize:10] withColor:nil];
        worldBossButton.position = CGPointMake(160.0f+monsterButton.size.width/2.0f+50.0f,monsterButton.position.y);
        worldBossButton.name=@"";
        [worldBossButton addTarget:self selector:@selector(worldBossButtonClick:) withObject:monsterButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:worldBossButton];
        
        
        PPMonsterInfoNode *monsterInfo=[[PPMonsterInfoNode alloc] initWithColor:[UIColor cyanColor] size:CGSizeMake(320, 300)];
        [monsterInfo initMonsterInfo:nil];
        monsterInfo.position = CGPointMake(160.0f, 170);
        [self addChild:monsterInfo];

        
    }
    return self;
}
-(void)monsterButtonClick:(NSString *)nameString
{
    
}
-(void)worldBossButtonClick:(NSString *)nameString
{
    
    
    //战斗示例 方便连调
    NSDictionary *dictEnemy=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"EnemyInfo" ofType:@"plist"]];
    NSArray *enemys=[[NSArray alloc] initWithArray:[dictEnemy objectForKey:@"EnemysInfo"]];
    
    NSDictionary * dictUserPets=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserPetInfo" ofType:@"plist"]];
    NSArray *petsInfoArray=[[NSArray alloc] initWithArray:[dictUserPets objectForKey:@"userpetinfo"]];
    NSDictionary *petsChoosedInfo=[petsInfoArray objectAtIndex:2];

    // 初始化 ballScene
    PPPixie * playerPixie = [PPPixie birthPixieWithPetsInfo:petsChoosedInfo];
    
    

    
    PPBallScene * ballScene = [[PPBallScene alloc] initWithSize:CurrentDeviceRealSize
                                                         PixieA:playerPixie
                                                         PixieB:enemys];
    
    
    ballScene.choosedEnemys = enemys;
    ballScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene:ballScene transition:[SKTransition doorsOpenVerticalWithDuration:0.5f]];

    
    
    
//    
//    PPWorldBossScene *worldScene=[[PPWorldBossScene alloc] initWithSize:self.view.bounds.size];
//    worldScene->previousScene = self;
//    [self.view presentScene:worldScene];
    
    
    
}
-(void)choosePassNumber
{
    if (self.chooseTarget!=nil&&self.chooseCouterpartSel!=nil&&[self.chooseTarget respondsToSelector:self.chooseCouterpartSel]) {
    
        [self.chooseTarget performSelectorInBackground:self.chooseCouterpartSel withObject:nil];
    }

}
-(void)didMoveToView:(SKView *)view
{
//    if ([UIScreen mainScreen].bounds.size.height>500) {
//
//    NSLog(@"heit=%f",self.view.frame.size.height);
//    [self.view setFrame:CGRectMake(0.0f, 44.0f, 320.0f, 480.0f)];
//    }
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:touchLocation];
        
        if ([node.name isEqualToString:@"couterpart"]) {
            [self choosePassNumber];
        }
    }
}
@end
