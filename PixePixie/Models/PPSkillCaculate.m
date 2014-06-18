//
//  PPSkillCaculate.m
//  PixelPixie
//
//  Created by xiefei on 6/17/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPSkillCaculate.h"
static PPSkillCaculate *skillCaculate = nil;
@implementation PPSkillCaculate
+ (instancetype)getInstance
{
    @synchronized([PPSkillCaculate class])
    {
        if(skillCaculate == nil)
        {
            skillCaculate = [[PPSkillCaculate alloc] init];
        
        }
    }
    
    return skillCaculate;
}

- (CGFloat)bloodChangeForPhysicalAttack:(CGFloat )attackValue andAddition:(CGFloat) attValueAddition andOppositeDefense:(CGFloat) defValue andOppositeDefAddition:(CGFloat)defAddition andDexterity:(CGFloat)dexterity
{
    
    return 200.0f;
    
}

@end
