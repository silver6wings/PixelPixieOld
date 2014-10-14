//
//  PPEuoFusionScene.m
//  PixelPixie
//
//  Created by xiefei on 7/7/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPEuoFusionScene.h"

@implementation PPEuoFusionScene
- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        self.backgroundColor = [UIColor purpleColor];
        [self setBackTitleText:@"Euo Fusion" andPositionY:360.0f];

        PPBasicSpriteNode *contentSpriteNode=[[PPBasicSpriteNode alloc] initWithColor:[UIColor blueColor] size:CGSizeMake(280, 200)];
        contentSpriteNode.position=CGPointMake(160.0f, 150);
        contentSpriteNode.name = @"contentMonsterBox";
        SKTexture *boxTexture=nil;
        switch (0) {
            case 0:
            {
                boxTexture = [SKTexture textureWithImageNamed:@"skill_plant.png"];
            }
                break;
            case 1:
            {
                boxTexture = [SKTexture textureWithImageNamed:@"skill_plant.png"];
            }
                break;
            case 2:
            {
                boxTexture = [SKTexture textureWithImageNamed:@"skill_plant.png"];
                
            }
                break;
                
            default:
                break;
        }
        
        for (int i=0; i<15; i++) {
            PPSpriteButton *monsterButton = [PPSpriteButton buttonWithTexture:boxTexture andSize:CGSizeMake(40.0f, 40.0f)];
            monsterButton.position = CGPointMake((i%5)*55-110.0f,(i/5)*60-50.0f);
            monsterButton.name = [NSString stringWithFormat:@"%d",i];
            [monsterButton addTarget:self selector:@selector(monsterBoxButtonClick:) withObject:monsterButton.name forControlEvent:PPButtonControlEventTouchUpInside];
            [contentSpriteNode addChild:monsterButton];
        }
        [self addChild:contentSpriteNode];
        
        
    }
    return self;
}
-(void)monsterBoxButtonClick:(NSString *)stringName
{
    
}
-(void)backButtonClick:(NSString *)backName
{
    
    [self.view presentScene:previousScene transition:[SKTransition doorwayWithDuration:1.0]];
    
    
}
@end
