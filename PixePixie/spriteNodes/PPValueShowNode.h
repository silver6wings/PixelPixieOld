//
//  PPValueShowNode.h
//  PixelPixie
//
//  Created by xiefei on 6/15/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPBasicSpriteNode.h"

@interface PPValueShowNode : PPBasicSpriteNode
{
@public
    CGFloat maxValue;
    CGFloat currentValue;
    
    CGFloat originalMax;
}
-(void)setMaxValue:(CGFloat)maxV andCurrentValue:(CGFloat)currentV  andShowType:(VALUESHOWTYPE) showType;
-(void)valueShowChangeMaxValue:(CGFloat)maxV andCurrentValue:(CGFloat)currentV;
@end
