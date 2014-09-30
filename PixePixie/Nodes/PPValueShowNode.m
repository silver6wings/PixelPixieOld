#import "PPValueShowNode.h"

@interface PPValueShowNode()
{
    PPBasicSpriteNode *valueShowNode;
    PPBasicLabelNode *valueShowLabel;
    SKSpriteNode *maskHpNode;
}
@end

@implementation PPValueShowNode

-(void)setMaxValue:(CGFloat)maxV
   andCurrentValue:(CGFloat)currentV
       andShowType:(VALUESHOWTYPE)showType
    andAnchorPoint:(CGPoint )anchorPoint
{
    
    maxValue = maxV;
    originalMax = maxValue;
    currentValue = currentV;
    
    if (showType == PP_HPTYPE) {
        valueShowNode = [PPBasicSpriteNode spriteNodeWithTexture:[[TextureManager ui_fighting] textureNamed:@"header_hpbar"]];
        valueShowNode.size = CGSizeMake(100.0, 20.0f);
        valueShowNode.position = CGPointMake(0.0f, 0.0f);
        valueShowNode.zPosition = 1;
        [self addChild:valueShowNode];
        
        SKSpriteNode *spriteHpBar = [SKSpriteNode spriteNodeWithImageNamed:@"header_hpfull.png"];
        spriteHpBar.position = CGPointMake(46.0f, 0.0f);
        spriteHpBar.size = CGSizeMake(92.0, 10.0f);
        NSLog(@"self.size.width=%f,height=%f",self.size.width,self.size.height);
        
        SKCropNode *crop = [[SKCropNode alloc]init];
        if (anchorPoint.x == 0.0f) {
            spriteHpBar.position = CGPointMake(46.0f, 0.0f);
            crop.position = CGPointMake(-46.0f, 0.0f);
        } else if (anchorPoint.x == 1.0f) {
            spriteHpBar.position = CGPointMake(-46.0f, 0.0f);
            crop.position = CGPointMake(46.0f, 0.0f);
        }
        
        crop.zPosition = 2.0f;
        maskHpNode = [SKSpriteNode spriteNodeWithTexture:[[TextureManager ui_fighting] textureNamed:@"header_hpfull"]];
        maskHpNode.size = CGSizeMake(92, 10);
        maskHpNode.anchorPoint = anchorPoint;
        crop.maskNode = maskHpNode;
        [crop addChild:spriteHpBar];
        [valueShowNode addChild:crop];
        
    } else {
        
        valueShowNode = [PPBasicSpriteNode spriteNodeWithTexture:[[TextureManager ui_fighting] textureNamed:@"header_epbar"]];
        valueShowNode.size = CGSizeMake(100.0, 10.0f);
        valueShowNode.position = CGPointMake(0.0f, 0.0f);
        valueShowNode.zPosition = 1;
        [self addChild:valueShowNode];
        
        SKSpriteNode * spriteHpBar = [SKSpriteNode spriteNodeWithTexture:[[TextureManager ui_fighting] textureNamed:@"header_epfull"]];
        spriteHpBar.size = CGSizeMake(96.0, 10.0f);
        NSLog(@"self.size.width=%f,height=%f",self.size.width,self.size.height);
    
        SKCropNode * crop = [[SKCropNode alloc]init];
        if (anchorPoint.x == 0.0f) {
            spriteHpBar.position = CGPointMake(48.0f, 0.0f);
            crop.position = CGPointMake(-48.0f, 0.0f);
        } else if (anchorPoint.x==1.0f) {
            spriteHpBar.position = CGPointMake(-48.0f, 0.0f);
            crop.position = CGPointMake(48.0f, 0.0f);
        }
        crop.zPosition = 2;
        maskHpNode = [SKSpriteNode  spriteNodeWithTexture:[[TextureManager ui_fighting] textureNamed:@"header_epfull.png"]];
        maskHpNode.size = CGSizeMake(96, 10);
        maskHpNode.anchorPoint = anchorPoint;
        crop.maskNode = maskHpNode;
        [crop addChild:spriteHpBar];
        [valueShowNode addChild:crop];
    }
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
    [maskHpNode runAction:actionChangeHP completion:^{
        if (target != nil && animateEnd != nil && [target respondsToSelector:animateEnd]) {
            [target performSelectorInBackground:animateEnd withObject:[NSNumber numberWithFloat:currentValue]];
        }
    }];
    
    return currentValue;
}

@end
