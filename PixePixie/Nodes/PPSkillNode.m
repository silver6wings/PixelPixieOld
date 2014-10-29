
#import "PPSkillNode.h"
#import "ConstantData.h"

@implementation PPSkillNode
@synthesize skill;
@synthesize delegate = mdelegate;

-(void)showSkillAnimate:(NSDictionary *)skillInfo andElement:(PPElementType) element;
{
    
    self.skill = [[PPSkill alloc] init];
    
    SKLabelNode *skillNameLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    skillNameLabel.fontColor = [UIColor blueColor];
    skillNameLabel.text = [skillInfo objectForKey:@"skillname"];
    skillNameLabel.position = CGPointMake(0.0f,121);
    [self addChild:skillNameLabel];
    
    
    self.skill.skillName = [skillInfo objectForKey:@"skillname"];
    self.skill.HPChangeValue = [[skillInfo objectForKey:@"skillhpchange"] floatValue];
    self.skill.MPChangeValue = [[skillInfo objectForKey:@"skillmpchange"] floatValue];
    self.skill.skillObject = [[skillInfo objectForKey:@"skillobject"] floatValue];
    
    
    SKSpriteNode * skillAnimate = [SKSpriteNode spriteNodeWithImageNamed:@"fire_blade_cast_0000"];
    skillAnimate.size = CGSizeMake(self.frame.size.width, 150.0f);
    skillAnimate.position = CGPointMake(0.0f,0.0f);
    [self addChild:skillAnimate];
    
    
    
    NSString * plistName = [[NSBundle mainBundle] pathForResource:@"FrameCount" ofType:@"plist"];
    NSDictionary * plistDic = [[NSDictionary alloc] initWithContentsOfFile:plistName];
    NSNumber * frameCount = [plistDic objectForKey:[NSString stringWithFormat:@"%@_%@_cast",kElementTypeString[element],[skillInfo objectForKey:@"animateTexturename"]]];
    
    
    NSMutableArray * textureArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [frameCount intValue]; i++)
    {
        SKTexture * textureCombo = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@_%@_cast_00%02d",kElementTypeString[element],[skillInfo objectForKey:@"animateTexturename"],i]];
        [textureArray addObject:textureCombo];
    }
    
    self.skill.animateTextures =[NSMutableArray arrayWithArray:textureArray];
    
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
