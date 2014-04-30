#import "ConstantData.h"

@implementation ConstantData

+(NSString *)elementName:(PPElementType)elementType{
    
    switch (elementType) {
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
    return @"";
}

@end
