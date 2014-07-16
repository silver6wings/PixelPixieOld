//
//  PPSkillButtonNode.m
//  PixelPixie
//
//  Created by xiefei on 7/16/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPSkillButtonNode.h"

@implementation PPSkillButtonNode
-(void)setSkillButton:(NSDictionary *)skillInfo
{
    
    PPCustomButton *ppixieSkillBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f)
                                                           andTitle:[skillInfo objectForKey:@"skillname"]
                                                         withTarget:self
                                                       withSelecter:@selector(skillClick:)];
    ppixieSkillBtn.name = [NSString stringWithFormat:@"%d",PP_SKILLS_CHOOSE_BTN_TAG];
    ppixieSkillBtn.position = CGPointMake(0.0f,0.0f);
    [self addChild:ppixieSkillBtn];
    

}
-(void)skillClick:(NSString *)stringName
{
    
}
@end
