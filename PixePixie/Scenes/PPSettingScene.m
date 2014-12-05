//
//  PPSettingScene.m
//  PixelPixie
//
//  Created by xiefei on 5/20/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPSettingScene.h"
#import "PPTableView.h"
static NSString *monsterBtnTitle[]={
    @"help",
    @"options",
    @"monster book",
    @"news"
};
@implementation PPSettingScene
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {

        self.backgroundColor = [UIColor purpleColor];
        [self setBackTitleText:@"Other" andPositionY:360.0f];
        

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
            PPHelpScene *helpScene=[[PPHelpScene alloc] initWithSize:self.view.bounds.size];
            helpScene->previousScene = self;
            [self.view presentScene:helpScene transition:[SKTransition flipHorizontalWithDuration:1.0]];
            
        }
            break;
        case 1:
        {
            PPOptionsScene *optionScene=[[PPOptionsScene alloc] initWithSize:self.view.bounds.size];
            optionScene->previousScene = self;
            [self.view presentScene:optionScene transition:[SKTransition flipHorizontalWithDuration:1.0]];
        }
            break;
        case 2:
        {
            PPMonsterBookScene *monstorBookScene=[[PPMonsterBookScene alloc] initWithSize:self.view.bounds.size];
            monstorBookScene->previousScene = self;
            [self.view presentScene:monstorBookScene transition:[SKTransition flipHorizontalWithDuration:1.0]];
        }
            break;
        case 3:
        {
            PPNewsScene *newsScene=[[PPNewsScene alloc] initWithSize:self.view.bounds.size];
            newsScene->previousScene = self;
            [self.view presentScene:newsScene transition:[SKTransition flipHorizontalWithDuration:1.0]];
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

@end
