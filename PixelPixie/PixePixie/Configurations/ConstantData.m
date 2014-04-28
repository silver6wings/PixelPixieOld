#import "ConstantData.h"

@implementation ConstantData

+(NSString *)elementName:(PPElementType)elementType{
    switch (elementType) {
        case PPElementTypeMetal:    return @"metal";
            
            
        default:
            break;
    }
    return @"";
}

@end
