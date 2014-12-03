#import "PPSceneManager.h"

@interface PPSceneManager()
@property(nonatomic,readonly)NSMutableDictionary *sceneInfo;
@end

@implementation PPSceneManager
@synthesize sceneInfo = _sceneInfo;

static PPSceneManager *pp_PPSceneManager = nil;

+(PPSceneManager *)instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (pp_PPSceneManager==nil) {
            pp_PPSceneManager=[[PPSceneManager alloc] init];
        }
    });
    return pp_PPSceneManager;
}

-(id)init
{
    self = [super init];
    if (self) {
        _sceneInfo = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(SKScene *)sceneForKey:(NSString *)key with:(CGSize)size
{
    SKScene *pp_scene = [self.sceneInfo objectForKey:key];
    if (pp_scene == nil) {
        pp_scene = [[NSClassFromString(key) alloc] initWithSize:size];
        [self.sceneInfo setObject:pp_scene forKey:key];
    }
    pp_scene.size = size;
    return pp_scene;
}

-(void)removeSceneForKey:(NSString *)key
{
    [self.sceneInfo removeObjectForKey:key];
}

@end
