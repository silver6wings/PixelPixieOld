//
//  PPMonsterScene.m
//  PixelPixie
//
//  Created by xiefei on 5/21/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPMonsterScene.h"
static NSString *monsterBtnTitle[]={
    @"Sell Monster",
    @"Euo Fusion",
    @"Talent Tree"
};
@implementation PPMonsterScene
- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        self.backgroundColor = [UIColor redColor];
//        [self setBackTitleText:@"Monster" andPositionY:380.0f];
        
               [self showPetInfo];
        
        
        PPSpriteButton *showMonsterBtn = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(40.0f, 100.0f)];
        [showMonsterBtn setLabelWithText:@"show" andFont:[UIFont systemFontOfSize:15] withColor:nil];
        showMonsterBtn.name = @"showMonsterName";
        showMonsterBtn.position = CGPointMake(22.0f,180.0f);
        [showMonsterBtn addTarget:self selector:@selector(showMonsterBtnClick:) withObject:showMonsterBtn forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:showMonsterBtn];
        
        
        
 
        
    }
    return self;
}
-(void)showMonsterBtnClick:(PPSpriteButton *)showBtn
{
    if ([showBtn.color isEqual:[UIColor orangeColor]]) {
        showBtn.color = [UIColor blueColor];
        
        for (int i=0; i<3; i++) {
            
            PPSpriteButton *monsterButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(200.0f, 40.0f)];
            [monsterButton setLabelWithText:monsterBtnTitle[i] andFont:[UIFont systemFontOfSize:15] withColor:nil];
            monsterButton.position = CGPointMake(160.0f,i*100+80.0f);
            monsterButton.name = [NSString stringWithFormat:@"%d",i];
            [monsterButton addTarget:self selector:@selector(monsterButtonClick:) withObject:monsterButton.name forControlEvent:PPButtonControlEventTouchUpInside];
            [self addChild:monsterButton];
            
        }
        
    }else
    {
        [self hideShowbtns];
    }
    
}

-(void)showPetInfo
{
    
    PPSpriteButton *feedFromFriendButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(120.0f, 30.0f)];
    [feedFromFriendButton setLabelWithText:@"有朋友给你的宠物喂食了!" andFont:[UIFont systemFontOfSize:10] withColor:nil];
    feedFromFriendButton.position = CGPointMake(60.0f,360.0f);
    feedFromFriendButton.name=@"";
    [feedFromFriendButton addTarget:self selector:@selector(feedButtonClick:) withObject:feedFromFriendButton.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:feedFromFriendButton];
    
    
    PPSpriteButton *removeToGroupBtn = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(80, 30.0f)];
    [removeToGroupBtn setLabelWithText:@"remove to Group" andFont:[UIFont systemFontOfSize:10] withColor:nil];
    removeToGroupBtn.position = CGPointMake(feedFromFriendButton.position.x+120,feedFromFriendButton.position.y);
    removeToGroupBtn.name=@"removeFromGroupBtn";
    [removeToGroupBtn addTarget:self selector:@selector(removeToGroupBtnClick:) withObject:feedFromFriendButton.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:removeToGroupBtn];
    
    
    PPSpriteButton *worldBossButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(60.0f, 30.0f)];
    [worldBossButton setLabelWithText:@"world boss" andFont:[UIFont systemFontOfSize:10] withColor:nil];
    worldBossButton.position = CGPointMake(160.0f+feedFromFriendButton.size.width/2.0f+50.0f,feedFromFriendButton.position.y);
    worldBossButton.name=@"";
    [worldBossButton addTarget:self selector:@selector(worldBossButtonClick:) withObject:feedFromFriendButton.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:worldBossButton];
    
    
    PPMonsterInfoNode *monsterInfo=[[PPMonsterInfoNode alloc] initWithColor:[UIColor cyanColor] size:CGSizeMake(320, 300)];
    [monsterInfo initMonsterInfo:nil];
    monsterInfo.position = CGPointMake(160.0f, 170);
    [self addChild:monsterInfo];

    
}

-(void)feedButtonClick:(NSString *)nameString
{
    
}
-(void)removeToGroupBtnClick:(NSString *)nameString
{
    
}
-(void)worldBossButtonClick:(NSString *)nameString
{
}


-(void)monsterButtonClick:(NSString *)name
{
    switch ([name intValue]) {
        case 0:
        {
            PPSellMonsterScene *sellMonster=[[PPSellMonsterScene alloc] initWithSize:self.view.frame.size];
            sellMonster->previousScene=self;
            [self.view presentScene:sellMonster transition:[SKTransition doorsOpenVerticalWithDuration:0.5]];
            
        }
            break;
        case 1:
        {
            PPEuoFusionScene *euoFusion=[[PPEuoFusionScene alloc] initWithSize:self.view.frame.size];
            euoFusion->previousScene=self;
            [self.view presentScene:euoFusion transition:[SKTransition doorsOpenVerticalWithDuration:0.5]];
        }
            break;
        case 2:
        {
            PPTalentTreeScene *talentTree=[[PPTalentTreeScene alloc] initWithSize:self.view.frame.size];
            talentTree->previousScene = self;
            [self.view presentScene:talentTree transition:[SKTransition doorsOpenVerticalWithDuration:0.5]];
        }
            break;
        case 3:
        {
            PPMonsterBoxScene *monsterBox=[[PPMonsterBoxScene alloc] initWithSize:self.view.frame.size];
            monsterBox->previousScene=self;
            [self.view presentScene:monsterBox transition:[SKTransition doorsOpenVerticalWithDuration:0.5]];
        }
            break;
            
        default:
            break;
    }
}
-(void)backButtonClick:(NSString *)backName
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PP_BACK_TO_MAIN_VIEW object:nil];
    
    
}
-(void)didMoveToView:(SKView *)view
{

}
- (void)willMoveFromView:(SKView *)view
{
    [self hideShowbtns];

    
}
-(void)hideShowbtns
{
    
    PPSpriteButton *btn=(PPSpriteButton *)[self childNodeWithName:@"showMonsterName"];
    
    
    btn.color = [UIColor orangeColor];

    for (int i=0; i<3; i++) {
        SKNode *monsterButton = [self childNodeWithName:[NSString stringWithFormat:@"%d",i]];
        [monsterButton removeFromParent];
    }
    
}
@end
