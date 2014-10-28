
#import "PPSkillButtonNode.h"

@implementation PPSkillButtonNode

-(void)setSkillButton:(NSDictionary *)skillInfo
{
    PPCustomButton * pixieSkillBtn = [PPCustomButton buttonWithSize:CGSizeMake(30.0f, 30.0f)
                                                           andTitle:[skillInfo objectForKey:@"skillname"] withTarget:self
                                                       withSelecter:@selector(skillClick:)];
    
    pixieSkillBtn.name = [NSString stringWithFormat:@"%d", PP_SKILLS_CHOOSE_BTN_TAG];
    pixieSkillBtn.position = CGPointMake(0.0f,0.0f);
    [self addChild:pixieSkillBtn];
}

-(void)skillClick:(NSString *)stringName
{}

@end
