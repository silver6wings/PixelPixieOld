
#import "PPElement.h"

@implementation PPElement

// 返回属性加成的系数
+(float)Self:(PPElementType)attacker
        Beat:(PPElementType)defender{

    if (attacker < 0 || attacker > kElementTypeMax) return -1.00f;
    if (defender < 0 || defender > kElementTypeMax) return -1.00f;
    
    return kElementInhibition[attacker][defender];
}

// 返回宠物融合的属性
+(PPElementType)Mix:(PPElementType)elementA
                 To:(PPElementType)elementB{
    
    if (elementA < 0 || elementA > kElementTypeMax) return PPElementTypeNone;
    if (elementB < 0 || elementB > kElementTypeMax) return PPElementTypeNone;
    
    return kElementMix[elementA][elementB] < 0 ? PPElementTypeNone : kElementMix[elementA][elementB];
}

@end
