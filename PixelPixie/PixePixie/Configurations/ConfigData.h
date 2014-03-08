//
//  ConfigData.h
//  PixelPixie
//
//  Created by silver6wings on 14-3-8.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigData : NSObject
{
}
@property (nonatomic, assign) BOOL launchWithVC;

+(ConfigData *)instance;

@end
