//
//  ConfigData.h
//  PixelPixie
//
//  Created by silver6wings on 14-3-8.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

@interface ConfigData : NSObject

@property (nonatomic, assign) BOOL launchWithVC;
//@property (nonatomic, strong) NSObject;

+(ConfigData *)instance;

@end
