//
//  PPSkillNode.h
//  PixelPixie
//
//  Created by xiefei on 6/9/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PPSkillInfo.h"
@protocol SkillShowEndDelegate

-(void)skillEndEvent:(PPSkillInfo *)skillInfo;

@end
@interface PPSkillNode : SKSpriteNode
{
    id <SkillShowEndDelegate>mdelegate;

}
@property (nonatomic,retain)id delegate;
@property(nonatomic,retain)PPSkillInfo *skill;
-(void)showSkillAnimate:(NSDictionary *)skillInfo;
@end
