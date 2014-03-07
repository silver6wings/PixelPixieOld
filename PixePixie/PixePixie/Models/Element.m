//
//  Element.m
//  PixePixie
//
//  Created by silver6wings on 14-3-6.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "Element.h"

static float inhibition[19][19] = {
    {1.50f, 3.00f},
    {4.00f, 7.00f}
};

@implementation Element

+(float)Self:(ElementType)attacker
        Beat:(ElementType)defender{

    return inhibition[attacker][defender];
}

@end
