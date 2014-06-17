#import "ConfigData.h"
#import "ConstantData.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define CurrentDeviceRealSize [[[UIScreen mainScreen] currentMode] size]

typedef enum {
    PP_HPTYPE,
    PP_MPTYPE
}VALUESHOWTYPE;


#define PP_MENU_COUNT 5
#define PP_MENU_BUTON_TAG 100
#define PP_PASSNUM_CHOOSE_TABLE_TAG 200
#define PP_PETS_CHOOSE_BTN_TAG 300
#define PP_SKILLS_CHOOSE_BTN_TAG 400
#define PP_SKILLS_VALUE_LAEBEL_TAG 500
