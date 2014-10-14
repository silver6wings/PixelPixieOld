
#import <Foundation/Foundation.h>

@interface TextureManager : NSObject

+(SKAction *)getAnimation:(NSString *)name;

+(SKTextureAtlas *)ball_elements;
+(SKTextureAtlas *)ball_magic;
+(SKTextureAtlas *)ball_pixie;
+(SKTextureAtlas *)ball_table;
+(SKTextureAtlas *)ball_buffer;

+(SKTextureAtlas *)skill_icon;
+(SKTextureAtlas *)skill_screen;

+(SKTextureAtlas *)ui_fighting;
+(SKTextureAtlas *)pixie_info;

@end
