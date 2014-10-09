//
//  TextureManager.h
//  PixelPixie
//
//  Created by silver6wings on 14-9-30.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextureManager : NSObject

+(SKTextureAtlas *)ball_elements;
+(SKTextureAtlas *)ball_magic;
+(SKTextureAtlas *)ball_pixie;
+(SKTextureAtlas *)ball_table;

+(SKTextureAtlas *)skill_icon;
+(SKTextureAtlas *)skill_screen;

+(SKTextureAtlas *)ui_fighting;
+(SKTextureAtlas *)pixie_info;

@end
