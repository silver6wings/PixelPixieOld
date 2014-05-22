//
//  PPCustomButton.h
//  SKTest
//
//  Created by xiefei on 14-5-22.
//  Copyright (c) 2014年 xiefei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PPCustomButton : SKShapeNode
//回调对象
@property(nonatomic,assign) id target;
//回调方法
@property(nonatomic,assign) SEL selector;
//便利构造器
+(PPCustomButton *)buttonWithSize:(CGSize)size andTitle:(NSString *)title;

@end
