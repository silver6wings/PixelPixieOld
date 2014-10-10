#import "PPValueShowNode.h"

@interface PPValueShowNode()
{
    PPBasicSpriteNode * valueShowNode;
    PPBasicLabelNode * valueShowLabel;
    SKSpriteNode * maskValueNode;

}
@end

@implementation PPValueShowNode

-(void)setMaxValue:(CGFloat)maxV
   andCurrentValue:(CGFloat)currentV
       andShowType:(VALUESHOWTYPE)showType
    andAnchorPoint:(CGPoint )anchorPoint andElementTypeString:(NSString *)typeString
{
    
    maxValue = maxV;
    originalMax = maxValue;
    currentValue = currentV;
    
    if (showType == PP_HPTYPE) {
        // 血条
        valueShowNode = [PPBasicSpriteNode spriteNodeWithTexture:[[TextureManager ui_fighting] textureNamed:
                                                                  [NSString stringWithFormat:@"%@_header_hpbar",typeString]]];
        valueShowNode.size = CGSizeMake(100, 20);
        valueShowNode.position = CGPointMake(0, 0);
        valueShowNode.zPosition = 1.0f;
        [self addChild:valueShowNode];
        
        
        SKCropNode * crop = [[SKCropNode alloc] init];
        crop.zPosition = 2.0f;
        
        SKSpriteNode * spriteHpBar = [SKSpriteNode spriteNodeWithImageNamed:
                                      [NSString stringWithFormat:@"%@_header_hpfull.png",typeString]];
        
        spriteHpBar.size = CGSizeMake(92, 10);
        NSLog(@"self.size.width=%f,height=%f",self.size.width,self.size.height);
        
        if (anchorPoint.x == 0.0f) {
            spriteHpBar.position = CGPointMake(46, 1);
            crop.position = CGPointMake(-46, 0);
        } else if (anchorPoint.x == 1.0f) {
            spriteHpBar.position = CGPointMake(-46, 1);
            crop.position = CGPointMake(46, 0);
        }
        [crop addChild:spriteHpBar];
        
        maskValueNode = [SKSpriteNode spriteNodeWithTexture:
                      [[TextureManager ui_fighting] textureNamed:[NSString stringWithFormat:@"%@_header_hpfull",typeString]]];
        maskValueNode.size = CGSizeMake(92, 11);
        maskValueNode.position = CGPointMake(0, 1);
        maskValueNode.anchorPoint = anchorPoint;
        crop.maskNode = maskValueNode;
        
        [valueShowNode addChild:crop];
        
    } else {
        
        // 能量条
        valueShowNode = [PPBasicSpriteNode spriteNodeWithTexture:[[TextureManager ui_fighting] textureNamed:[NSString stringWithFormat:@"%@_header_mpbar",typeString]]];
        valueShowNode.size = CGSizeMake(100, 10);
        valueShowNode.position = CGPointMake(0, 0);
        valueShowNode.zPosition = 1;
        [self addChild:valueShowNode];
        
        SKSpriteNode * spriteMpBar = [SKSpriteNode spriteNodeWithTexture:[[TextureManager ui_fighting] textureNamed:[NSString stringWithFormat:@"%@_header_mpfull",typeString]]];
        spriteMpBar.size = CGSizeMake(96, 7);
        NSLog(@"self.size.width=%f,height=%f",self.size.width,self.size.height);
    
        SKCropNode * crop = [[SKCropNode alloc]init];
        if (anchorPoint.x == 0.0f) {
            spriteMpBar.position = CGPointMake(48, 0);
            crop.position = CGPointMake(-48, 0);
        } else if (anchorPoint.x == 1.0f) {
            spriteMpBar.position = CGPointMake(-48, 0);
            crop.position = CGPointMake(48, 0);
        }
        crop.zPosition = 2;
        
        
        maskValueNode = [SKSpriteNode  spriteNodeWithTexture:[[TextureManager ui_fighting] textureNamed:[NSString stringWithFormat:@"%@_header_mpfull.png",typeString]]];
        maskValueNode.size = CGSizeMake(96, 7);
        maskValueNode.anchorPoint = anchorPoint;
        crop.maskNode = maskValueNode;
        [crop addChild:spriteMpBar];
        [valueShowNode addChild:crop];
        
    }
    [self valueShowChangeMaxValue:0 andCurrentValue:0];
    
}


//-(void)setMaxValue:(CGFloat)maxV andCurrentValue:(CGFloat)currentV andShowType:(VALUESHOWTYPE)showType andAnchorPoint:(CGPoint )anchorPoint
//{
//    
//    maxValue = maxV;
//    originalMax = maxValue;
//    currentValue = currentV;
//    
//    
//    if (showType == PP_HPTYPE) {
//        valueShowNode = [PPBasicSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(100.0f, 20.0f)];
//
//    } else {
//        valueShowNode = [PPBasicSpriteNode spriteNodeWithColor:[UIColor orangeColor] size:CGSizeMake(100.0f, 10.0f)];
//
//    }
//    valueShowNode.anchorPoint = anchorPoint;
//    valueShowNode.position = CGPointMake(-50.0f,0.0f);
//    if (anchorPoint.x==1.0f) {
//        
//        valueShowNode.position = CGPointMake(50.0f,0.0f);
//        
//    }
//    [self addChild:valueShowNode];
//    
//    
////    valueShowLabel=[[PPBasicLabelNode alloc] init];
////    valueShowLabel.text=[NSString stringWithFormat:@"%.f/%.f",currentV,maxV];
////    NSLog(@"currentV=%f,maxV=%f",currentV,maxV);
////    
////    valueShowLabel.fontSize=10;
////    valueShowLabel.name = [NSString stringWithFormat:@"%d",PP_SKILLS_VALUE_LAEBEL_TAG];
////    valueShowLabel.position = CGPointMake(0,valueShowNode.position.y+5.0f);
////    [self addChild:valueShowLabel];
//    
//     
//    [self valueShowChangeMaxValue:0 andCurrentValue:currentV];
//    
//}

-(CGFloat)valueShowChangeMaxValue:(CGFloat)maxV andCurrentValue:(CGFloat)currentV
{
    maxValue = maxV + maxValue;
    
    currentValue = currentV + currentValue;
    
    if (currentValue <= 0.0f) currentValue = 0.0f;
    if (maxValue <= 0.0f) maxValue = 0.0f;
    if (maxValue <= currentValue) currentValue = maxValue;
    
    valueShowLabel.text = [NSString stringWithFormat:@"%.f/%.f",currentValue,maxValue];
  
    CGFloat xToValue = currentValue/maxValue;
    NSLog(@"xToValue = %f", xToValue);

    xToValue <= 0.0f ? xToValue = 0.0f : xToValue;
    xToValue >= 1.0f ? xToValue = 1.0f : xToValue;
    
    SKAction * actionChangeHP = [SKAction scaleXTo:xToValue duration:1];
    [maskValueNode runAction:actionChangeHP completion:^{
        if (target != nil && animateEnd != nil && [target respondsToSelector:animateEnd]) {
            [target performSelectorInBackground:animateEnd withObject:[NSNumber numberWithFloat:currentValue]];
        }
    }];
    
    return currentValue;
}

@end
