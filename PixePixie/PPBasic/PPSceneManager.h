//
//  PPSceneManager.h
//  PixelPixie
//
//  Created by xiefei on 5/22/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPSceneManager : NSObject
+ (PPSceneManager *)instance;
//key是场景类的类名
//size是场景获得的场景对象的尺寸大小
- (SKScene *)sceneForKey:(NSString *)key with:(CGSize)size;
//移除对应场景类类名的场景
-(void)removeSceneForKey:(NSString *)key;

@end
