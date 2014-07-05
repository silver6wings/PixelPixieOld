//
//  PPPassNumberScroll.h
//  PixelPixie
//
//  Created by xiefei on 6/3/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPPassNumberScroll : UIView
@property (strong, nonatomic)SKScene *scene;
@property (weak, nonatomic) UIView *view;
//回调对象
@property(nonatomic,assign) id target;
//回调方法
@property(nonatomic,assign) SEL selector;
-(void)creatPassNumberScroll:(NSDictionary *)passInfo with:(SKScene *)sceneTmp;
@end
