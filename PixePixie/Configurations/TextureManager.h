

@interface SKTextureAtlas (AnimationBuilder)
-(SKAction *)getAnimation:(NSString *)name;
@end

@implementation SKTextureAtlas (AnimationBuilder)

-(SKAction *)getAnimation:(NSString *)name
{
    NSString * plistName = [[NSBundle mainBundle] pathForResource:@"FrameCount" ofType:@"plist"];
    NSDictionary * plistDic = [[NSDictionary alloc] initWithContentsOfFile:plistName];
    NSNumber * frameCount = [plistDic objectForKey:name];
    
    NSMutableArray * textureArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [frameCount intValue]; i++)
    {
        SKTexture * textureCombo = [self textureNamed:[NSString stringWithFormat:@"%@_%04d.png",name,i]];
        [textureArray addObject:textureCombo];
    }
    return [SKAction animateWithTextures:textureArray timePerFrame:kFrameInterval];
}

@end


@interface TextureManager : NSObject

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
