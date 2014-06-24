//
//  PPSkillNode.m
//  PixelPixie
//
//  Created by xiefei on 6/9/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPSkillNode.h"
@interface PPSkillInfo()
{
}

@end
@implementation PPSkillNode
@synthesize skill;
@synthesize delegate=mdelegate;
-(void)showSkillAnimate:(NSDictionary *)skillInfo
{
    self.skill=[[PPSkillInfo alloc] init];
    
    SKLabelNode *skillNameLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    skillNameLabel.fontColor = [UIColor blueColor];
    skillNameLabel.text = [skillInfo objectForKey:@"skillname"];
    skillNameLabel.position = CGPointMake(0.0f,121);
    [self addChild:skillNameLabel];
    
    
    self.skill.HPChangeValue = [[skillInfo objectForKey:@"skillhpchange"] floatValue];
    self.skill.MPChangeValue = [[skillInfo objectForKey:@"skillmpchange"] floatValue];
    self.skill.skillObject = [[skillInfo objectForKey:@"skillobject"] floatValue];
    
    SKSpriteNode *skillAnimate = [SKSpriteNode spriteNodeWithImageNamed:@"变身效果01000"];
    skillAnimate.size = CGSizeMake(self.frame.size.width, 242);
    skillAnimate.position = CGPointMake(0.0f,0.0f);

    [self addChild:skillAnimate];
    
    NSMutableArray *textureNameArray=[[NSMutableArray alloc] init];
    @synchronized(textureNameArray)
    {
    for (int i=1; i <= 43; i++) {
        NSString *textureName = [NSString stringWithFormat:@"变身效果01%03d.png", i];
        SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
        [textureNameArray addObject:temp];
        
    }
    }
    self.skill.animateTextures =[NSMutableArray arrayWithArray:textureNameArray];
    
    [skillAnimate runAction:[SKAction sequence:@[[SKAction animateWithTextures:self.skill.animateTextures timePerFrame:0.02f]]] completion:^{
     
        [self endAnimateWithSkill];
    
    }];
    
}
-(void)endAnimateWithSkill
{

    [self removeFromParent];
    [self.delegate skillEndEvent:self.skill withSelfName:self.name];
    
}
@end
