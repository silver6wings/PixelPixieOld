

@interface SKTextureAtlas (AnimationBuilder)
-(SKAction *)getAnimation:(NSString *)name;
-(SKAction *)getAnimationContrary:(NSString *)name;
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

-(SKAction *)getAnimationContrary:(NSString *)name
{
    NSString * plistName = [[NSBundle mainBundle] pathForResource:@"FrameCount" ofType:@"plist"];
    NSDictionary * plistDic = [[NSDictionary alloc] initWithContentsOfFile:plistName];
    NSNumber * frameCount = [plistDic objectForKey:name];
    
    NSMutableArray * textureArray = [[NSMutableArray alloc] init];
    for (int i = [frameCount intValue]-1; i >=0 ; i--)
    {
        SKTexture * textureCombo = [self textureNamed:[NSString stringWithFormat:@"%@_%04d.png",name,i]];
        [textureArray addObject:textureCombo];
    }
    return [SKAction animateWithTextures:textureArray timePerFrame:kFrameInterval];
}

@end


@interface TextureManager : NSObject

+(SKTextureAtlas *)ball_buff;
+(SKTextureAtlas *)ball_elements;
+(SKTextureAtlas *)ball_magic;
+(SKTextureAtlas *)ball_table;

+(SKTextureAtlas *)pixie_info;

+(SKTextureAtlas *)skill_buff;
+(SKTextureAtlas *)skill_icon;

+(SKTextureAtlas *)ui_fighting;
+(SKTextureAtlas *)ui_talent;

@end
