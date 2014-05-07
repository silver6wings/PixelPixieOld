//
//  Element.h
//  PixePixie
//
//  Created by silver6wings on 14-3-6.
//  Copyright (c) 2014年 Psyches. All rights reserved.



@interface PPElement : NSObject

+(float)Self:(PPElementType)attack
        Beat:(PPElementType)defend;

+(PPElementType)Mix:(PPElementType)element1
                 To:(PPElementType)element2;

@end

