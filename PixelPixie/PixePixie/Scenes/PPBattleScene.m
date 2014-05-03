//
//  PPBattleScene.m
//  PixelPixie
//
//  Created by silver6wings on 14-5-3.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPBattleScene.h"

@interface PPBattleScene ()
@property (nonatomic) SKLabelNode * myLabel;
@end

@implementation PPBattleScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _myLabel.name = @"bt_start";
        _myLabel.text = @"Click me to start ^~^";
        _myLabel.fontSize = 15;
        _myLabel.fontColor = [UIColor grayColor];
        _myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMidY(self.frame));
        [self addChild:_myLabel];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode * touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
    
    // 点击开始按钮
    
    if ([[touchedNode name] isEqualToString:@"bt_start"]) {
        NSLog(@"start");
    }
}

@end
