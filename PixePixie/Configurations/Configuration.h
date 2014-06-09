#import "ConfigData.h"
#import "ConstantData.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define CurrentDeviceRealSize [[[UIScreen mainScreen] currentMode] size]

#define PP_MENU_COUNT 5
#define PP_MENU_BUTON_TAG 100
#define PP_PASSNUM_CHOOSE_TABLE_TAG 200
