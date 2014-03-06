//
//  Element.h
//  PixePixie
//
//  Created by silver6wings on 14-3-6.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ElementType) {
    ElementNone,        // 无
    ElementMetal,       // 金
    ElementSteel,       // 钢
    ElementPlant,       // 木
    ElementPosion,      // 毒
    ElementWater,       // 水
    ElementIce,         // 冰
    ElementFire,        // 火
    ElementBlaze,       // 炎
    ElementEarth,       // 土
    ElementRock,        // 岩
    ElementBurst,       // 爆
    ElementSand,        // 沙
    ElementThunder,     // 雷
    ElementGrowth,      // 霖
    ElementFlame,       // 焰
    ElementWind,        // 风
    ElementFantasy      // 幻
};

@interface Element : NSObject{
}

@end

