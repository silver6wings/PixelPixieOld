#import "PPCommonTool.h"
#import <objc/runtime.h>

static PPCommonTool * commonTool = nil;

@implementation PPCommonTool

-(PPCommonTool *)getInstance
{
    @synchronized(self){
        if (commonTool == nil) {
            commonTool = [[PPCommonTool alloc] init];
        }
    }
    return commonTool;
}

//得到应用程序Documents文件夹下的目标路径
+(NSString *)getUserInfoPath
{
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Userinfo.plist"];
}

//
+(NSData *)directoryToJSONData:(NSDictionary *)dict
{
    if(class_getClassMethod([NSJSONSerialization class], @selector(dataWithJSONObject:options:error:)) == NULL){
        return nil;
    }
    NSError * error = nil;
    return  [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
}

//
+(NSDictionary *)JSONDataTodirectory:(NSData *)data
{
    if (class_getClassMethod([NSJSONSerialization class], @selector(JSONObjectWithData:options:error:)) == NULL){
        return  nil;
    }
    NSError * error = nil;
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
}

//
+(id)contentFromUserDefaultKey:(NSString *)keyString
{
    NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
    id content = [userDef objectForKey:keyString];
    return content;
}

//
+(void)setContent:(id)content forContentKey:(NSString *)keyString
{
    NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:content forKey:keyString];
}

@end
