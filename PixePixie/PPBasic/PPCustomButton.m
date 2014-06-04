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
+(PPCustomButton *)buttonWithSize:(CGSize)size andTitle:(NSString *)title
{
    CGRect rect= CGRectMake(0.0f, 0.0f, size.width, size.height);
    PPCustomButton *customBtn=[[PPCustomButton alloc] init];
    
    //创建路径
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddRoundedRect(path, NULL, rect, 5.0f, 5.0f);
    //设置路径及相关属性
    customBtn.path=path;
    customBtn.lineWidth=0.5f;
    customBtn.strokeColor=[SKColor yellowColor];
    customBtn.userInteractionEnabled=YES;
    customBtn.antialiased=YES;
    //释放路径
    CFRelease(path);
    
    //创建文本标签
    SKLabelNode *label=[[SKLabelNode alloc] initWithFontNamed:@"Avenir"];
    [label setName:@"label"];
    [label setFontSize:22];
    [label setText:title];
    [label setFontColor:[SKColor yellowColor]];
    [label setPosition:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)-CGRectGetMidY(label.frame))];
    [customBtn addChild:label];
    return  customBtn;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setHidden:YES];
    [self.target performSelectorInBackground:self.selector withObject:self];
}
@end
