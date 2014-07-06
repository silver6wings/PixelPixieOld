//
//  PPMonsterScene.m
//  PixelPixie
//
//  Created by xiefei on 5/21/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPMonsterScene.h"

@implementation PPMonsterScene
- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        self.backgroundColor = [UIColor redColor];
        
    }
    return self;
}
-(void)didMoveToView:(SKView *)view
{
    SKLabelNode *titilePass = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    titilePass.name = @"eee";
    titilePass.text = @"tesssssss";
    titilePass.fontSize = 15;
    titilePass.color = [UIColor yellowColor];
    titilePass.fontColor=[UIColor whiteColor];
    titilePass.position = CGPointMake(100.0f,100.0f);
    [self addChild:titilePass];
}
@end
