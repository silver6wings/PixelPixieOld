//
//  PPBuffAgg.h
//  PixelPixie
//
//  Created by xiefei on 14-6-18.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPBuff : NSObject

@property (nonatomic,assign) NSInteger cdRoundsAttAdd;  //伤害加成回合数
@property (nonatomic,assign) NSInteger cdRoundsDefAdd;  //防御加成回合数
@property (nonatomic,assign) CGFloat attackAddition;    //伤害加成
@property (nonatomic,assign) CGFloat defenseAddition;   //防御加成

@end
