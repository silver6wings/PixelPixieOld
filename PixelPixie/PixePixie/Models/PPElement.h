//
//  Element.h
//  PixePixie
//
//  Created by silver6wings on 14-3-6.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

static const int PPElementTypeMax = 10;

typedef NS_ENUM(NSInteger, PPElementType)
{
    PPElementTypeNone,        // 无

    PPElementTypeMetal,       // 金
    PPElementTypePlant,       // 木
    PPElementTypeWater,       // 水
    PPElementTypeFire,        // 火
    PPElementTypeEarth,       // 土
    
    PPElementTypeSteel,       // 钢
    PPElementTypePosion,      // 毒
    PPElementTypeIce,         // 冰
    PPElementTypeBlaze,       // 炎
    PPElementTypeStone,       // 岩

    PPElementTypeBurst,       // 爆
    PPElementTypeSand,        // 沙
    PPElementTypeThunder,     // 雷
    PPElementTypeTree,        // 树
    PPElementTypeWind         // 风
};

@interface PPElement : NSObject

+(float)Self:(PPElementType)attack
        Beat:(PPElementType)defend;

+(PPElementType)Mix:(PPElementType)element1
                 To:(PPElementType)element2;

@end

