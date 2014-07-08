//
//  PPMonsterInfoNode.m
//  PixelPixie
//
//  Created by xiefei on 7/8/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPMonsterInfoNode.h"

@implementation PPMonsterInfoNode
-(id)init
{
    self = [super init];
    if (self) {
        
   
        
    }
    return self;
}
-(void)initMonsterInfo:(NSDictionary *)monsterInfo
{
    PPSpriteButton *monsterTexture=[PPSpriteButton buttonWithTexture:[SKTexture textureWithImageNamed:@"pixie_plant3_battle0.png"] andSize:CGSizeMake(150.0f, 200)];
    monsterTexture.position = CGPointMake(0.0f,10.0f);
    monsterTexture.name = @"pixie_plant3_battle0";
    [monsterTexture addTarget:self selector:@selector(monsterTextureClick:) withObject:monsterTexture.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:monsterTexture];
    
    for (int i=0; i<3; i++) {
        PPSpriteButton *buffButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(30.0f, 30.0f)];
        [buffButton setLabelWithText:@"Buff" andFont:[UIFont systemFontOfSize:15] withColor:nil];
        buffButton.position = CGPointMake(130.0f,i*40+20.0f);
        buffButton.name = [NSString stringWithFormat:@"%d",i];
        [buffButton addTarget:self selector:@selector(buffButtonClick:) withObject:buffButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:buffButton];
    }
    
    PPSpriteButton *moodButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(130.0f, 25.0f)];
    [moodButton setLabelWithText:@"心情" andFont:[UIFont systemFontOfSize:15] withColor:nil];
    moodButton.position = CGPointMake(0.0f,-105.0f);
    moodButton.name = @"心情";
    [moodButton addTarget:self selector:@selector(moodButtonClick:) withObject:moodButton.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:moodButton];
    
    PPSpriteButton *hungryButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(130.0f, 25.0f)];
    [hungryButton setLabelWithText:@"饥饿" andFont:[UIFont systemFontOfSize:15] withColor:nil];
    hungryButton.position = CGPointMake(0.0f,moodButton.position.y-30.0f);
    hungryButton.name = @"饥饿";
    [hungryButton addTarget:self selector:@selector(hungryButtonClick:) withObject:hungryButton.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:hungryButton];
    
    
    PPSpriteButton *feedButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(50.0f, 50.0f)];
    [feedButton setLabelWithText:@"喂食" andFont:[UIFont systemFontOfSize:15] withColor:nil];
    feedButton.position = CGPointMake(110.0f,moodButton.position.y-15);
    feedButton.name = @"喂食";
    [feedButton addTarget:self selector:@selector(feedButtonClick:) withObject:feedButton.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:feedButton];
    

}
-(void)feedButtonClick:(NSString *)stringName
{
    
}
-(void)hungryButtonClick:(NSString *)stringName
{
    
}
-(void)moodButtonClick:(NSString *)stringName
{
    
}
-(void)monsterTextureClick:(NSString *)stringName
{
    
}
-(void)buffButtonClick:(NSString *)stringName
{
    
}
@end
