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
        
   
    }
    
    return self;
}
- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];

//    NSLog(@"passName=%@",passName);
//    NSDictionary *dictPassInfo=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PassInfo" ofType:@"plist"]];
//    NSArray *passArray=[NSArray arrayWithArray:[dictPassInfo objectForKey:@"transcriptinfo"]];
//    NSInteger passCount=[passArray count];
//    int index=[passName integerValue]-PP_PASSNUM_CHOOSE_TABLE_TAG;
//    NSDictionary *passDictInfo=nil;
//    if (passCount>index) {
//        NSLog(@"pass choosed=%@",[passArray objectAtIndex:index]);
//        passDictInfo=[NSDictionary dictionaryWithDictionary:[passArray objectAtIndex:index]];
//    }
    
    self.backgroundColor = [SKColor purpleColor];
    
    SKSpriteNode *spriteContent=[SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(300, 350)];
    spriteContent.name=@"contentSprite";
    spriteContent.position=CGPointMake(160.0, 260.0);
    [self addChild:spriteContent];
    
//
    
    NSDictionary * dictUserPets=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserPetInfo" ofType:@"plist"]];
    NSLog(@"dictUserPets11111=%@",self.passDictInfo);

    
    
    NSArray *petsInfoArray=[[NSArray alloc] initWithArray:[dictUserPets objectForKey:@"userpetinfo"]];
    NSInteger petsCount = [petsInfoArray count];
    
    for (int i=0; i<petsCount; i++) {
        
        PPCustomButton *sprit1=[PPCustomButton buttonWithSize:CGSizeMake(80.0f, 80.0f) andTitle:[[petsInfoArray objectAtIndex:i] objectForKey:@"petname"] withTarget:self withSelecter:@selector(spriteChooseClick:)];
        sprit1.name=[NSString stringWithFormat:@"%d",PP_PETS_CHOOSE_BTN_TAG+i];
        sprit1.position=CGPointMake(0.0, 100*(i-1));
        [spriteContent addChild:sprit1];
        
    }
    self.petsArray = petsInfoArray;
    
    
    SKLabelNode *titilePass = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    titilePass.name = @"eee";
    titilePass.text = [NSString stringWithFormat:@"副本id:%@",[self.passDictInfo objectForKey:@"passid"]];
    titilePass.fontSize = 10;
    titilePass.color = [UIColor yellowColor];
    titilePass.fontColor=[UIColor whiteColor];
    titilePass.position = CGPointMake(100.0f,100.0f);
    [self addChild:titilePass];
    
    
}
-(void)spriteChooseClick:(PPCustomButton *)spriteBtn
{
    
    NSDictionary *petsChoosedInfo=[self.petsArray objectAtIndex:[spriteBtn.name integerValue]-PP_PETS_CHOOSE_BTN_TAG];
    
    NSLog(@"petsChoose=%@",petsChoosedInfo);
    PPBattleScene *battleScene=[[PPBattleScene alloc] initWithSize:self.view.bounds.size];
    battleScene.choosedPet =[NSDictionary dictionaryWithDictionary:petsChoosedInfo];
    [self.view presentScene:battleScene transition:[SKTransition doorwayWithDuration:1.0]];    
    
    
    
}
@end
