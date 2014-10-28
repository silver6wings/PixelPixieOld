
#import <Foundation/Foundation.h>

@interface PPCommonTool : NSObject

-(PPCommonTool *)getInstance;
+(NSString *)getUserInfoPath;

// json 数据转换
+(NSData *)directoryToJSONData:(NSDictionary *)dict;
+(NSDictionary *)JSONDataTodirectory:(NSData *)dict;

// UserDefault
+(id)contentFromUserDefaultKey:(NSString *) keyString;
+(void)setContent:(id)content forContentKey:(NSString *) keyString;

@end
