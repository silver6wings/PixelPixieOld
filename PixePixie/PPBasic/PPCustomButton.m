//
//  PPCustomButton.m
//  SKTest
//
//  Created by xiefei on 14-5-22.
//  Copyright (c) 2014年 xiefei. All rights reserved.
//

#import "PPCustomButton.h"

@implementation PPCustomButton
@synthesize target=_target;
@synthesize selector=_selector;
+(PPCustomButton *)buttonWithSize:(CGSize)size andTitle:(NSString *)title withTarget:(id)targetTmp withSelecter:(SEL)selectorTmp
{

    CGRect rect= CGRectMake(0.0f, 0.0f, size.width, size.height);
    PPCustomButton *customBtn=[[PPCustomButton alloc] init];
    customBtn.target = targetTmp;
    customBtn.selector = selectorTmp;
    //创建路径
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddRoundedRect(path, NULL, rect, 5.0f, 5.0f);
    //设置路径及相关属性
    customBtn.path=path;
    customBtn.lineWidth=0.5f;
    customBtn.strokeColor=[SKColor clearColor];
    customBtn.userInteractionEnabled=YES;
    customBtn.antialiased=YES;
    //释放路径
    CFRelease(path);
    
    //创建文本标签
    SKLabelNode *label=[[SKLabelNode alloc] initWithFontNamed:@"Avenir"];
    [label setName:@"label"];
    [label setFontSize:14];
    [label setText:title];
    [label setFontColor:[SKColor yellowColor]];
    [label setPosition:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)-CGRectGetMidY(label.frame))];
    [customBtn addChild:label];
    
    customBtn.target = targetTmp;
    customBtn.selector = selectorTmp;
    return  customBtn;
}

+(PPCustomButton *)buttonWithSize:(CGSize)size andImage:(NSString *)image withTarget:(id)targetTmp withSelecter:(SEL)selectorTmp
{
    
    CGRect rect= CGRectMake(0.0f, 0.0f, size.width, size.height);
    PPCustomButton *customBtn=[[PPCustomButton alloc] init];
    customBtn.target = targetTmp;
    customBtn.selector = selectorTmp;
    //创建路径
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddRoundedRect(path, NULL, rect, 5.0f, 5.0f);
    //设置路径及相关属性
    customBtn.path=path;
    customBtn.lineWidth=0.5f;
    customBtn.strokeColor=[SKColor clearColor];
    customBtn.userInteractionEnabled=YES;
    customBtn.antialiased=YES;
    //释放路径
    CFRelease(path);
    
    
    SKSpriteNode *spritePixieNode = [SKSpriteNode spriteNodeWithImageNamed:image];
    spritePixieNode.size=size;
    spritePixieNode.position = CGPointMake(0.0f, 0.0f);
    [customBtn addChild:spritePixieNode];
  
    return  customBtn;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.target!=nil &&self.selector!=nil &&[self.target respondsToSelector:self.selector]) {
        [self.target performSelectorInBackground:self.selector withObject:self];

    }
}
@end
