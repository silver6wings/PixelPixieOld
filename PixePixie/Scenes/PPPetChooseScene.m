//
//  PPPetChooseScene.m
//  PixelPixie
//
//  Created by xiefei on 6/14/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPPetChooseScene.h"
@interface PPPetChooseScene()
{
    
}
@end

@implementation PPPetChooseScene
@synthesize petsArray;
@synthesize passDictInfo;
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        [self setBackTitleText:@"关卡选择" andPositionY:450.0f];
        
        PPSpriteButton * coinButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(80, 20)];
        [coinButton setLabelWithText:@"coin" andFont:[UIFont systemFontOfSize:15] withColor:nil];
        coinButton.position = CGPointMake(80.0f,380.0f);
        [coinButton addTarget:self selector:@selector(coinButton:) withObject:[NSValue valueWithCGPoint:CGPointMake(self.size.width / 2, self.size.height / 2)] forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:coinButton];
        
        
        PPSpriteButton * petsButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(80, 20)];
        [petsButton setLabelWithText:@"pets" andFont:[UIFont systemFontOfSize:15] withColor:nil];
        petsButton.position = CGPointMake(coinButton.frame.size.width+100.0f,380.0f);
        [petsButton addTarget:self selector:@selector(petsButton:) withObject:[NSValue valueWithCGPoint:CGPointMake(self.size.width / 2, self.size.height / 2)] forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:petsButton];
        
        
        
   
    }
    
    return self;
}
-(void)coinButton:(NSValue *) valueTmp
{
    
}
-(void)petsButton:(NSValue *) valueTmp
{
    
    
    SKSpriteNode *spriteContent=[SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(300, 350)];
    spriteContent.name=@"contentSprite";
    spriteContent.position=CGPointMake(160.0, 260.0);
    [self addChild:spriteContent];
    
    
    
    
    //
    
    NSDictionary * dictUserPets=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserPetInfo" ofType:@"plist"]];
    NSArray *petsInfoArray=[[NSArray alloc] initWithArray:[dictUserPets objectForKey:@"userpetinfo"]];
    NSInteger petsCount = [petsInfoArray count];
    
    
    for (int i=0; i<petsCount; i++) {
        
        PPCustomButton *sprit1=[PPCustomButton buttonWithSize:CGSizeMake(80.0f, 80.0f) andTitle:[[petsInfoArray objectAtIndex:i] objectForKey:@"petname"] withTarget:self withSelecter:@selector(spriteChooseClick:)];
        sprit1.name=[NSString stringWithFormat:@"%d",PP_PETS_CHOOSE_BTN_TAG+i];
        sprit1.position=CGPointMake(0.0, 100*(i-1));
        [spriteContent addChild:sprit1];
        
    }
    
    
    self.petsArray = [NSArray arrayWithArray:petsInfoArray];
    
    
    
    SKLabelNode *titilePass = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    titilePass.name = @"eee";
    titilePass.text = [NSString stringWithFormat:@"副本id:%@",[self.passDictInfo objectForKey:@"passid"]];
    titilePass.fontSize = 10;
    titilePass.color = [UIColor yellowColor];
    titilePass.fontColor=[UIColor whiteColor];
    titilePass.position = CGPointMake(100.0f,100.0f);
    [self addChild:titilePass];
}

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    
}

-(void)spriteChooseClick:(PPCustomButton *)spriteBtn
{
    
    NSDictionary *petsChoosedInfo=[self.petsArray objectAtIndex:[spriteBtn.name integerValue]-PP_PETS_CHOOSE_BTN_TAG];
    PPBattleScene *battleScene=[[PPBattleScene alloc] initWithSize:self.view.bounds.size];
    battleScene.choosedPet =[NSDictionary dictionaryWithDictionary:petsChoosedInfo];
    battleScene->previousScene = self;
    [self.view presentScene:battleScene transition:[SKTransition doorwayWithDuration:1.0]];    
    
    
    
}
-(void)backButtonClick:(NSString *)backName
{
    
    [self.view presentScene:previousScene transition:[SKTransition doorwayWithDuration:1.0]];
    
    
}
@end
