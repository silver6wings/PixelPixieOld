//
//  PPCustomAlertNode.m
//  PixelPixie
//
//  Created by xiefei on 6/26/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPCustomAlertNode.h"

@implementation PPCustomAlertNode
-(id)initWithFrame:(CGRect)frame
{
    PPCustomAlertNode *customAlert=[[PPCustomAlertNode alloc] init];
    customAlert.position = frame.origin;
    customAlert.size = frame.size;
    [customAlert setColor:[UIColor whiteColor]];
    return customAlert;
    
}
-(void)showCustomAlertWithInfo:(NSDictionary *)alertInfo
{
    
    SKLabelNode *titleNameLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    titleNameLabel.fontColor = [UIColor blueColor];
    titleNameLabel.text = [alertInfo objectForKey:@"title"];
    titleNameLabel.position = CGPointMake(0.0f,50);
    [self addChild:titleNameLabel];
    
    
    SKLabelNode *textContentLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    textContentLabel.fontColor = [UIColor blueColor];
    textContentLabel.text = [alertInfo objectForKey:@"context"];
    textContentLabel.position = CGPointMake(0.0f,-50);
    [self addChild:textContentLabel];
    
    SKAction *action = [SKAction fadeAlphaTo:0.0f duration:4];
    [self runAction:action completion:^{
        
        
        [self removeFromParent];
    
    }];
}


@end
