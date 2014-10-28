
#import "PPTalentTreeScene.h"

@implementation PPTalentTreeScene

- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        self.backgroundColor = [UIColor grayColor];
        [self setBackTitleText:@"Talent Tree" andPositionY:360.0f];
        [self creatTreeWith:PPElementTypeFire];
    }
    return self;
}

-(void)creatTreeWith:(PPElementType)elementType{
    
    SKSpriteNode * backTree = [[SKSpriteNode alloc] initWithTexture:[[TextureManager ui_talent] textureNamed:[NSString stringWithFormat:@"%@_tree", kElementTypeString[elementType]]]];
    backTree.position = CGPointMake(self.size.width/2.0f, self.size.height/2.0f);
    backTree.size = CGSizeMake(290, 223*290/195);
    [self addChild:backTree];
    
    for (int i = 0; i < 10; i++) {
        NSString * textureName = [NSString stringWithFormat:@"%@_tree_%@",
                                  kElementTypeString[elementType], kSkillEnglishName[elementType][i]];
        PPSpriteButton * monstersButton = [PPSpriteButton buttonWithTexture:[[TextureManager ui_talent] textureNamed:textureName]];
        monstersButton.position = CGPointMake(80*(i%3)-50,60*(i/3)-80);
        monstersButton.size = CGSizeMake(monstersButton.size.width/2.0f, monstersButton.size.height/2.0f);
        monstersButton.name = [NSString stringWithFormat:@"%d",i];
        [monstersButton addTarget:self selector:@selector(monstersButtonClick:) withObject:monstersButton.name forControlEvent:PPButtonControlEventTouchUpInside];
        [backTree addChild:monstersButton];
    }
}

-(void)monstersButtonClick:(NSString *)stringName
{
}

-(void)backButtonClick:(NSString *)backName
{
    [self.view presentScene:previousScene transition:[SKTransition doorwayWithDuration:1.0]];
}

@end
