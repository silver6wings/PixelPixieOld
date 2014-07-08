//
//  PPTalentTreeScene.m
//  PixelPixie
//
//  Created by xiefei on 7/7/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPTalentTreeScene.h"

@implementation PPTalentTreeScene
- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        self.backgroundColor = [UIColor grayColor];
        [self setBackTitleText:@"Talent Tree" andPositionY:360.0f];
        
        for (int i=0; i<3; i++) {
            
            PPSpriteButton *monstersButton = nil;
            
            switch (i) {
                case 0:
                {
                    monstersButton = [PPSpriteButton buttonWithTexture:[SKTexture textureWithImageNamed:@"ball_pixie_plant2.png"] andSize:CGSizeMake(40.0f,40.0f)];
                    
                }
                    break;
                case 1:
                {
                    
                    monstersButton = [PPSpriteButton buttonWithTexture:[SKTexture textureWithImageNamed:@"ball_pixie_plant3.png"] andSize:CGSizeMake(40.0f,40.0f)];
                    
                }
                    break;
                case 2:
                {
                    monstersButton = [PPSpriteButton buttonWithTexture:[SKTexture textureWithImageNamed:@"ball_pixie_plant2.png"] andSize:CGSizeMake(40.0f,40.0f)];
                    
                }
                    break;
                    
                    
                default:
                    break;
            }
            
            //            [monsterButton setLabelWithText:monsterBtnTitle[i] andFont:[UIFont systemFontOfSize:15] withColor:nil];
            monstersButton.position = CGPointMake(100.0f+i*60.0f,300.0f);
            monstersButton.name = [NSString stringWithFormat:@"%d",i];
            [monstersButton addTarget:self selector:@selector(monstersButtonClick:) withObject:monstersButton.name forControlEvent:PPButtonControlEventTouchUpInside];
            [self addChild:monstersButton];
            
            
            
        }
        
//        [self monsterTeamButtonClick:@"0"];


    }
    return self;
}
-(void)monstersButtonClick:(NSString *)stringName
{
    
}
-(void)backButtonClick:(NSString *)backName
{
    
    [self.view presentScene:previousScene transition:[SKTransition doorwayWithDuration:1.0]];
    
    
}
@end
