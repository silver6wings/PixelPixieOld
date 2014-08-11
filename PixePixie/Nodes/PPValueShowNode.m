#import "PPValueShowNode.h"

@interface PPValueShowNode()
{
    PPBasicSpriteNode *valueShowNode;
    PPBasicLabelNode *valueShowLabel;
}
@end

@implementation PPValueShowNode

-(void)setMaxValue:(CGFloat)maxV andCurrentValue:(CGFloat)currentV andShowType:(VALUESHOWTYPE)showType andAnchorPoint:(CGPoint )anchorPoint
{
    maxValue = maxV;
    originalMax = maxValue;
    currentValue = currentV;
    

    
    if (showType == PP_HPTYPE) {
        valueShowNode = [PPBasicSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(90, 6)];

    } else {
        valueShowNode = [PPBasicSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(90, 6)];

    }
    valueShowNode.anchorPoint = anchorPoint;
    valueShowNode.position = CGPointMake(-45.0f,0.0f);
    if (anchorPoint.x==1.0f) {
        
        valueShowNode.position = CGPointMake(45.0f,0.0f);
        
    }
    [self addChild:valueShowNode];
    
    valueShowLabel=[[PPBasicLabelNode alloc] init];
    valueShowLabel.text=[NSString stringWithFormat:@"%.f/%.f",currentV,maxV];
    valueShowLabel.fontSize=10;
    valueShowLabel.name = [NSString stringWithFormat:@"%d",PP_SKILLS_VALUE_LAEBEL_TAG];
    valueShowLabel.position = CGPointMake(0,valueShowNode.position.y+5.0f);
    [self addChild:valueShowLabel];
    
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
    [valueShowNode runAction:actionChangeHP completion:^{
        if (target!=nil&&animateEnd!=nil&&[target respondsToSelector:animateEnd]) {
            [target performSelectorInBackground:animateEnd withObject:[NSNumber numberWithFloat:currentValue]];
        }
    }];

}
@end
