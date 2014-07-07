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
    @"Talent Tree",
    @"Monster Box"
};
@implementation PPMonsterScene
- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        self.backgroundColor = [UIColor redColor];
        [self setBackTitleText:@"Monster" andPositionY:360.0f];
        
        for (int i=0; i<4; i++) {
            PPSpriteButton *monsterButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(200.0f, 40.0f)];
            [monsterButton setLabelWithText:monsterBtnTitle[i] andFont:[UIFont systemFontOfSize:15] withColor:nil];
            monsterButton.position = CGPointMake(160.0f,i*80+80.0f);
            monsterButton.name = [NSString stringWithFormat:@"%d",i];
            [monsterButton addTarget:self selector:@selector(monsterButtonClick:) withObject:monsterButton.name forControlEvent:PPButtonControlEventTouchUpInside];
            [self addChild:monsterButton];
        }
    }
    return self;
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
@end
