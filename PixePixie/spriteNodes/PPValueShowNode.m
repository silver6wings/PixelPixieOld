//
//  PPValueShowNode.m
//  PixelPixie
//
//  Created by xiefei on 6/15/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPValueShowNode.h"
@interface PPValueShowNode()
{
    PPBasicSpriteNode *valueShowNode;
    PPBasicLabelNode *valueShowLabel;
    CGFloat maxValue;
    CGFloat currentValue;
    
    CGFloat originalMax;
}
@end



@implementation PPValueShowNode
-(void)setMaxValue:(CGFloat)maxV andCurrentValue:(CGFloat)currentV  andShowType:(VALUESHOWTYPE) showType{
    maxValue = maxV;
    originalMax = maxValue;
    currentValue = currentV;
    
    valueShowLabel=[[PPBasicLabelNode alloc] init];
    valueShowLabel.text=[NSString stringWithFormat:@"%.f/%.f",currentV,maxV];
    valueShowLabel.fontSize=10;
    valueShowLabel.name = [NSString stringWithFormat:@"%d",PP_SKILLS_VALUE_LAEBEL_TAG];
    valueShowLabel.position = CGPointMake(self.size.width+valueShowLabel.frame.size.width,0);
    [self addChild:valueShowLabel];
    
    if (showType == PP_HPTYPE) {
        valueShowNode = [PPBasicSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(90, 6)];

    }else
    {
        valueShowNode = [PPBasicSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(90, 6)];

    }
    valueShowNode.anchorPoint = CGPointMake(0, 0.0);
    valueShowNode.position = CGPointMake(0.0f,0.0);
    [self addChild:valueShowNode];
    
}
-(void)valueShowChangeMaxValue:(CGFloat)maxV andCurrentValue:(CGFloat)currentV
{
    
    maxValue = maxV + maxValue;
    currentValue = currentV+currentValue;
    if (currentValue<=0.0f) {
        currentValue = 0.0f;
    }
    
    if (maxValue <= 0.0f) {
        maxValue = 0.0f;
    }

    if (maxValue<=currentValue) {
        currentValue = maxValue;
    }
    
    valueShowLabel.text=[NSString stringWithFormat:@"%.f/%.f",currentValue,maxValue];
  
    CGFloat xToValue = currentValue/maxValue;
    NSLog(@"xToValue=%f",xToValue);

    xToValue<=0.0f?xToValue = 0.0f:xToValue;
    xToValue>=1.0f?xToValue = 1.0f:xToValue;
    SKAction *actionChangeHP=[SKAction scaleXTo:xToValue duration:1];
    [valueShowNode runAction:actionChangeHP];

}
@end
