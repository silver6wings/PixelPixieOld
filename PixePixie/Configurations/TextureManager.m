//
//  TextureManager.m
//  PixelPixie
//
//  Created by silver6wings on 14-9-30.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "TextureManager.h"

@implementation TextureManager

+(SKTextureAtlas *) ball_elements
{
    static dispatch_once_t pred_ball_elements;
    __strong static SKTextureAtlas * ball_elements = nil;
    dispatch_once(&pred_ball_elements, ^{
        ball_elements = [SKTextureAtlas atlasNamed:@"ball_elements"];
    });
    return ball_elements;
}

+(SKTextureAtlas *) ball_magic
{
    static dispatch_once_t pred_ball_magic;
    __strong static SKTextureAtlas * ball_magic = nil;
    dispatch_once(&pred_ball_magic, ^{
        ball_magic = [SKTextureAtlas atlasNamed:@"ball_magic"];
    });
    return ball_magic;
}

+(SKTextureAtlas *) ball_pixie
{
    static dispatch_once_t pred_ball_pixie;
    __strong static SKTextureAtlas * ball_pixie = nil;
    dispatch_once(&pred_ball_pixie, ^{
        ball_pixie = [SKTextureAtlas atlasNamed:@"ball_pixie"];
    });
    return ball_pixie;
}

+(SKTextureAtlas *) ball_table
{
    static dispatch_once_t pred_ball_table;
    __strong static SKTextureAtlas * ball_table = nil;
    
    dispatch_once(&pred_ball_table, ^{
        ball_table = [SKTextureAtlas atlasNamed:@"ball_table"];
    });
    return ball_table;
}

+(SKTextureAtlas *) skill_icon
{
    static dispatch_once_t pred_skill_icon;
    __strong static SKTextureAtlas * skill_icon = nil;
    dispatch_once(&pred_skill_icon, ^{
        skill_icon = [SKTextureAtlas atlasNamed:@"skill_icon"];
    });
    return skill_icon;
}

+(SKTextureAtlas *) skill_screen
{
    static dispatch_once_t pred_skill_screen;
    __strong static SKTextureAtlas * skill_screen = nil;
    dispatch_once(&pred_skill_screen, ^{
        skill_screen = [SKTextureAtlas atlasNamed:@"skill_screen"];
    });
    return skill_screen;
}

+(SKTextureAtlas *) ui_fighting
{
    static dispatch_once_t pred_ui_fighting;
    __strong static SKTextureAtlas * ui_fighting = nil;
    dispatch_once(&pred_ui_fighting, ^{
        ui_fighting = [SKTextureAtlas atlasNamed:@"ui_fighting"];
    });
    
    return ui_fighting;
}

+(SKTextureAtlas *)pixie_info
{
    static dispatch_once_t pred_ui_fighting;
    __strong static SKTextureAtlas * ui_fighting = nil;
    dispatch_once(&pred_ui_fighting, ^{
        ui_fighting = [SKTextureAtlas atlasNamed:@"pixie_info"];
    });
    
    return ui_fighting;
}

@end
