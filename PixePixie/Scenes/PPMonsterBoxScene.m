//
//  PPMonsterBoxScene.m
//  PixelPixie
//
//  Created by xiefei on 7/7/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPMonsterBoxScene.h"

@implementation PPMonsterBoxScene
- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        self.backgroundColor = [UIColor redColor];
        [self setBackTitleText:@"Monster Box" andPositionY:360.0f];
        
        for (int i=0; i<3; i++) {
            
            PPSpriteButton *monsterTeamButton = nil;
            
            switch (i) {
                case 0:
                {
                    monsterTeamButton = [PPSpriteButton buttonWithTexture:[SKTexture textureWithImageNamed:@"ball_pixie_plant2.png"] andSize:CGSizeMake(40.0f,40.0f)];
                    
                }
                    break;
                case 1:
                {
                    
                    monsterTeamButton = [PPSpriteButton buttonWithTexture:[SKTexture textureWithImageNamed:@"ball_pixie_plant3.png"] andSize:CGSizeMake(40.0f,40.0f)];

                }
                    break;
                case 2:
                {
                    monsterTeamButton = [PPSpriteButton buttonWithTexture:[SKTexture textureWithImageNamed:@"ball_pixie_plant2.png"] andSize:CGSizeMake(40.0f,40.0f)];

                }
                    break;

                    
                default:
                    break;
            }
            
//            [monsterButton setLabelWithText:monsterBtnTitle[i] andFont:[UIFont systemFontOfSize:15] withColor:nil];
            monsterTeamButton.position = CGPointMake(100.0f+i*60.0f,300.0f);
            monsterTeamButton.name = [NSString stringWithFormat:@"%d",i];
            [monsterTeamButton addTarget:self selector:@selector(monsterTeamButtonClick:) withObject:monsterTeamButton.name forControlEvent:PPButtonControlEventTouchUpInside];
            [self addChild:monsterTeamButton];
            
            
            
        }
        
        [self monsterTeamButtonClick:@"0"];
        
    
        

    }
    return self;
}
-(void)monsterTeamButtonClick:(NSString *)stringName
{
    SKSpriteNode *spriteContent=(SKSpriteNode *)[self childNodeWithName:@"contentMonsterBox"];
    if (spriteContent!=nil) {
        [spriteContent removeFromParent];
    }
    
    PPBasicSpriteNode *contentSpriteNode=[[PPBasicSpriteNode alloc] initWithColor:[UIColor blueColor] size:CGSizeMake(280, 200)];
    contentSpriteNode.position=CGPointMake(160.0f, 150);
    contentSpriteNode.name = @"contentMonsterBox";
    SKTexture *boxTexture=nil;
    switch ([stringName intValue]) {
        case 0:
        {
            boxTexture = [SKTexture textureWithImageNamed:@"ball_pixie_plant2.png"];
        }
            break;
        case 1:
        {
            boxTexture = [SKTexture textureWithImageNamed:@"ball_pixie_plant3.png"];
        }
            break;
        case 2:
        {
            boxTexture = [SKTexture textureWithImageNamed:@"ball_pixie_plant2.png"];

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
    
    
    PPSpriteButton *monsterBoxAddButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(100.0f, 35.0f)];
    [monsterBoxAddButton setLabelWithText:@"BOX 1 增加" andFont:[UIFont systemFontOfSize:15] withColor:nil];
    monsterBoxAddButton.name =@"增加";
    monsterBoxAddButton.position = CGPointMake(160.0f,25.0f);
    [monsterBoxAddButton addTarget:self selector:@selector(monsterBoxAddClick:) withObject:monsterBoxAddButton.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:monsterBoxAddButton];
    
    
}
-(void)monsterBoxButtonClick:(NSString *)stringName
{
    
}
-(void)monsterBoxAddClick:(NSString *)stringName
{
    
}
-(void)backButtonClick:(NSString *)backName
{
    
    [self.view presentScene:previousScene transition:[SKTransition doorwayWithDuration:1.0]];
    
    
}
@end
