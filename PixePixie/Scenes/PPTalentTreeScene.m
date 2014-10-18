
#import "PPTalentTreeScene.h"
 static NSString *stringTree0[]={@"arrow",@"blade",@"burn",@"dance",@"purgatory",@"shield",@"smoke",@"spout",@"suppression",@"swear"};
@implementation PPTalentTreeScene

- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        self.backgroundColor = [UIColor grayColor];
        [self setBackTitleText:@"Talent Tree" andPositionY:360.0f];
        

        [self creatTreeWith:PPElementTypeFire];
        
//        [self monsterTeamButtonClick:@"0"];
    }
    return self;
}
-(void)creatTreeWith:(PPElementType)elementType{
    
    PPBasicSpriteNode *backTree=[[PPBasicSpriteNode alloc] initWithTexture:[[TextureManager ui_talent] textureNamed:[NSString stringWithFormat:@"%@_tree",kElementTypeString[elementType]]]];
    backTree.position = CGPointMake(self.size.width/2.0f, self.size.height/2.0f);
    backTree.size = CGSizeMake(backTree.size.width/2.0f, backTree.size.height/2.0f);
    [self addChild:backTree];
    
    
    for (int i = 0; i < 10; i++) {
        
        PPSpriteButton * monstersButton = [PPSpriteButton buttonWithTexture:[[TextureManager ui_talent] textureNamed:[NSString stringWithFormat:@"%@_tree_%@",kElementTypeString[elementType],stringTree0[i]]]];
        monstersButton.position = CGPointMake(-30.0f,40*i-backTree.size.height);
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
