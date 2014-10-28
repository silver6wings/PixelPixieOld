
#import "TextureManager.h"

@implementation TextureManager

+(SKTextureAtlas *)ball_buff
{
    __strong static SKTextureAtlas * tAtlas = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        tAtlas = [SKTextureAtlas atlasNamed:@"ball_buff"];
    });
    return tAtlas;
}

+(SKTextureAtlas *)ball_elements
{
    __strong static SKTextureAtlas * tAtlas = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        tAtlas = [SKTextureAtlas atlasNamed:@"ball_elements"];
    });
    return tAtlas;
}

+(SKTextureAtlas *)ball_magic
{
    __strong static SKTextureAtlas * tAtlas = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        tAtlas = [SKTextureAtlas atlasNamed:@"ball_magic"];
    });
    return tAtlas;
}

+(SKTextureAtlas *)ball_table
{
    __strong static SKTextureAtlas * tAtlas = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        tAtlas = [SKTextureAtlas atlasNamed:@"ball_table"];
    });
    return tAtlas;
}

+(SKTextureAtlas *)pixie_info
{
    __strong static SKTextureAtlas * tAtlas = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        tAtlas = [SKTextureAtlas atlasNamed:@"pixie_info"];
    });
    return tAtlas;
}

+(SKTextureAtlas *)skill_buff
{
    __strong static SKTextureAtlas * tAtlas = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        tAtlas = [SKTextureAtlas atlasNamed:@"skill_buff"];
    });
    return tAtlas;
}

+(SKTextureAtlas *)skill_icon
{
    __strong static SKTextureAtlas * tAtlas = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        tAtlas = [SKTextureAtlas atlasNamed:@"skill_icon"];
    });
    return tAtlas;
}

+(SKTextureAtlas *)ui_fighting
{
    __strong static SKTextureAtlas * tAtlas = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        tAtlas = [SKTextureAtlas atlasNamed:@"ui_fighting"];
    });
    return tAtlas;
}

+(SKTextureAtlas *)ui_number
{
    __strong static SKTextureAtlas * tAtlas = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        tAtlas = [SKTextureAtlas atlasNamed:@"ui_number"];
    });
    return tAtlas;
}

+(SKTextureAtlas *)ui_talent
{
    __strong static SKTextureAtlas * tAtlas = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        tAtlas = [SKTextureAtlas atlasNamed:@"ui_talent"];
    });
    return tAtlas;
}

@end
