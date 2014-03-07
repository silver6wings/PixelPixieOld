//
//  Element.h
//  PixePixie
//
//  Created by silver6wings on 14-3-6.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ElementType) {
    ElementTypeNone,        // 无
    ElementTypeMetal,       // 金
    ElementTypeSteel,       // 钢
    ElementTypePlant,       // 木
    ElementTypePosion,      // 毒
    ElementTypeWater,       // 水
    ElementTypeIce,         // 冰
    ElementTypeFire,        // 火
    ElementTypeBlaze,       // 炎
    ElementTypeEarth,       // 土
    ElementTypeRock,        // 岩
    ElementTypeBurst,       // 爆
    ElementTypeSand,        // 沙
    ElementTypeThunder,     // 雷
    ElementTypeGrowth,      // 霖
    ElementTypeFlame,       // 焰
    ElementTypeWind,        // 风
    ElementTypeFantasy      // 幻
};

@interface Element : NSObject

+(float)Self:(ElementType)attack
        Beat:(ElementType)defend;

@end

