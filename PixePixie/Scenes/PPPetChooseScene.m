

#import "PPPetChooseScene.h"

@interface PPPetChooseScene()
@end

@implementation PPPetChooseScene
@synthesize petsArray;
@synthesize passDictInfo;

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        [self setBackTitleText:@"宠物选择" andPositionY:450.0f];
        
        [self setPetsChooseContent];
        
    }
    return self;
}


-(void)coinButton:(NSValue *)valueTmp
{
    
}

-(void)setPetsChooseContent
{
    
    SKSpriteNode *spriteContent = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(300, 350)];
    spriteContent.name = @"contentSprite";
    spriteContent.position = CGPointMake(160.0, 260.0);
    [self addChild:spriteContent];
    
    NSDictionary * dictUserPets = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserPetInfo"
                                                                                                             ofType:@"plist"]];
    NSArray *petsInfoArray = [[NSArray alloc] initWithArray:[dictUserPets objectForKey:@"userpetinfo"]];
    NSInteger petsCount = [petsInfoArray count];
    
    for (int i = 0; i < petsCount; i++) {
        
        PPCustomButton *sprit1 = [PPCustomButton buttonWithSize:CGSizeMake(80.0f, 80.0f)
                                                     andTitle:[[petsInfoArray objectAtIndex:i] objectForKey:@"petname"]
                                                   withTarget:self
                                                 withSelecter:@selector(spriteChooseClick:)];
        sprit1.name = [NSString stringWithFormat:@"%d", PP_PETS_CHOOSE_BTN_TAG + i];
        sprit1.position = CGPointMake(0.0, 100 * (i - 1));
        [spriteContent addChild:sprit1];
    }

    self.petsArray = [NSArray arrayWithArray:petsInfoArray];
    
    SKLabelNode *titilePass = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    titilePass.name = @"eee";
    titilePass.text = [NSString stringWithFormat:@"副本id:%@",[self.passDictInfo objectForKey:@"passid"]];
    titilePass.fontSize = 10;
    titilePass.color = [UIColor yellowColor];
    titilePass.fontColor = [UIColor whiteColor];
    titilePass.position = CGPointMake(100.0f,100.0f);
    [self addChild:titilePass];
}

-(void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
}

-(void)spriteChooseClick:(PPCustomButton *)spriteBtn
{
    NSDictionary * petsChoosedInfo = [self.petsArray objectAtIndex:[spriteBtn.name integerValue]-PP_PETS_CHOOSE_BTN_TAG];
    PPHurdleReadyScene * battleScene = [[PPHurdleReadyScene alloc] initWithSize:self.view.bounds.size];
    battleScene.choosedPet = [NSDictionary dictionaryWithDictionary:petsChoosedInfo];
    battleScene->previousScene = self;
    [self.view presentScene:battleScene transition:[SKTransition fadeWithDuration:1]];
}

-(void)backButtonClick:(NSString *)backName
{
    [self.view presentScene:previousScene];
}

@end
