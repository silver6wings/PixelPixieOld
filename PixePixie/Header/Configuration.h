#import "ConfigData.h"
#import "ConstantData.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define CurrentDeviceRealSize [UIScreen mainScreen].bounds.size
#define CustomAlertFrame CGRectMake(160.0f,300.0f, 320.0f, 200)

typedef enum {
    PP_HPTYPE,
    PP_MPTYPE
}VALUESHOWTYPE;

#define PP_PET_SKILL_SHOW_NODE_NAME @"petskillshow"
#define PP_ENEMY_SKILL_SHOW_NODE_NAME @"enemyskillshow"
#define PP_PET_PLAYER_SIDE_NODE_NAME @"petsidename"
#define PP_ENEMY_SIDE_NODE_NAME @"enemysidename"

#define PP_MENU_COUNT 5
#define PP_USER_BUTON_TAG 50
#define PP_MENU_BUTON_TAG 100
#define PP_PASSNUM_CHOOSE_TABLE_TAG 200
#define PP_PETS_CHOOSE_BTN_TAG 300
#define PP_SKILLS_CHOOSE_BTN_TAG 400
#define PP_SKILLS_VALUE_LAEBEL_TAG 500
