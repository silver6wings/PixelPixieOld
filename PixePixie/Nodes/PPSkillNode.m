
#import "PPSkillNode.h"

@implementation PPSkillNode
@synthesize skill;
@synthesize delegate = mdelegate;

-(void)showSkillAnimate:(NSDictionary *)skillInfo
{
    self.skill=[[PPSkill alloc] init];
    
    SKLabelNode *skillNameLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    skillNameLabel.fontColor = [UIColor blueColor];
    skillNameLabel.text = [skillInfo objectForKey:@"skillname"];
    skillNameLabel.position = CGPointMake(0.0f,121);
    [self addChild:skillNameLabel];
    
    
    self.skill.HPChangeValue = [[skillInfo objectForKey:@"skillhpchange"] floatValue];
    self.skill.MPChangeValue = [[skillInfo objectForKey:@"skillmpchange"] floatValue];
    self.skill.skillObject = [[skillInfo objectForKey:@"skillobject"] floatValue];
    
    
    SKSpriteNode *skillAnimate = [SKSpriteNode spriteNodeWithImageNamed:@"fire_blade_cast_0000"];
    skillAnimate.size = CGSizeMake(self.frame.size.width, 150.0f);
    skillAnimate.position = CGPointMake(0.0f,0.0f);
    [self addChild:skillAnimate];
    
    
    
    NSMutableArray *textureNameArray=[[NSMutableArray alloc] init];
    @synchronized(textureNameArray)
    {
        for (int i=0; i <24; i++) {
            NSString *textureName = [NSString stringWithFormat:@"fire_blade_cast_00%02d.png", i];
            SKTexture * temp = [SKTexture textureWithImageNamed:textureName];
            [textureNameArray addObject:temp];
            
        }
    }
    self.skill.animateTextures =[NSMutableArray arrayWithArray:textureNameArray];
    
    [skillAnimate runAction:[SKAction animateWithTextures:self.skill.animateTextures timePerFrame:0.05f]
                 completion:^{
        [self endAnimateWithSkill];
    }];
    
}
-(void)endAnimateWithSkill
{

    [self removeFromParent];
    [self.delegate skillEndEvent:self.skill withSelfName:self.name];
    
}
@end
