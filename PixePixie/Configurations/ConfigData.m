//
//  ConfigData.m
//  PixelPixie
//
//  Created by silver6wings on 14-3-8.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "ConfigData.h"

static ConfigData * instance = nil;
static NSArray * ElementNameList;

@interface ConfigData()
@end

@implementation ConfigData

// 共享的实例 sharedInstance
+(ConfigData *)instance{
    @synchronized (self){
        if (!instance) {
            instance = [[self alloc] init]; // 该方法会调用 allocWithZone
        }
    }
    return instance;
}

// 确保使用同一块内存地址
+(id)allocWithZone:(NSZone *)zone{
    @synchronized (self){
        if (!instance) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

// 确保copy对象也是唯一
- (id)copyWithZone:(NSZone *)zone{
    return self;
}

-(id)init{
    if (self = [super init]) {
        self.launchWithVC = YES;
    }
    return self;
}

@end