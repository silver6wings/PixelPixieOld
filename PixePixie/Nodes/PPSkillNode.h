

@class PPSkill;

@protocol SkillShowEndDelegate
-(void)skillEndEvent:(PPSkill *)skillInfo withSelfName:(NSString *)nodeName;
@end

@interface PPSkillNode : SKSpriteNode
{
    id <SkillShowEndDelegate> mdelegate;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) PPSkill *skill;

-(void)showSkillAnimate:(NSDictionary *)skillInfo;

@end

