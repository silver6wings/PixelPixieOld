

@interface PPSceneManager : NSObject

+(PPSceneManager *)instance;

/*
key:场景类的类名
size:场景获得的场景对象的尺寸大小
*/
-(SKScene *)sceneForKey:(NSString *)key with:(CGSize)size;

// 移除对应场景类类名的场景
-(void)removeSceneForKey:(NSString *)key;

@end
