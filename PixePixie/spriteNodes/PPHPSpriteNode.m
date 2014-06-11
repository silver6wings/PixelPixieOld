//
//  PPHPSpriteNode.m
//  PixelPixie
//
//  Created by xiefei on 6/9/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPHPSpriteNode.h"

@implementation PPHPSpriteNode
-(void)HPChangeWith:(CGFloat)hpValue
{
    SKAction *actionChangeHP=[SKAction scaleXTo:0.1 duration:1];
    [self runAction:actionChangeHP];
    
    
}
-(void)MPChangeWith:(CGFloat)mpvalue
{
    SKAction *actionChangeHP=[SKAction scaleXTo:0.5 duration:1];
    [self runAction:actionChangeHP];
}
@end
