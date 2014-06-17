//
//  PPSkillInfo.m
//  PixelPixie
//
//  Created by xiefei on 6/9/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPSkillInfo.h"

@implementation PPSkillInfo
@synthesize skillName;
@synthesize animateTextures;
@synthesize HPChangeValue;
@synthesize MPChangeValue;
@synthesize skillType;
@synthesize skillObject;
@synthesize cdRounds;
-(id)init
{
    if (self=[super init]) {
        
        self.animateTextures = [[NSMutableArray alloc] init];
        self.HPChangeValue = -193.0f;
        self.MPChangeValue = -43.0f ;
    }
    return self;
}
@end
