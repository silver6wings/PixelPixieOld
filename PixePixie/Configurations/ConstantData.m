#import "ConstantData.h"

@implementation ConstantData

// 获取元素名称
+(NSString *)elementName:(PPElementType)elementType{
    
    switch (elementType)
    {
        case PPElementTypeMetal:    return @"metal";
        case PPElementTypePlant:    return @"plant";
        case PPElementTypeWater:    return @"water";
        case PPElementTypeFire:     return @"fire";
        case PPElementTypeEarth:    return @"earth";
            
        case PPElementTypeSteel:    return @"steel";
        case PPElementTypePosion:   return @"posion";
        case PPElementTypeIce:      return @"ice";
        case PPElementTypeBlaze:    return @"blaze";
        case PPElementTypeStone:    return @"stone";
            
        default:
            break;
    }
    return nil;
}

+(NSString *)pixieType:(PPPixie *)pixie isFront:(BOOL)front
{
    return nil;
}

@end
