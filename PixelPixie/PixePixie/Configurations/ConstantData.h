
static const int kWallThick = 1;                    // 墙的厚度
static const int kBallRadius = 15;                  // 球的半径
static const int kBallSize = kBallRadius * 2;       // 球的直径
static const float kBallLinearDamping = 0.6f;       // 线阻尼系数
static const float kBallAngularDamping = 0.7f;      // 角阻尼系数
static const float kBallFriction = 0.7f;            // 表面摩擦力
static const float kBallRestitution = 0.7f;         // 弹性恢复系数

// 最大元素个数
static const int kElementTypeMax = 10;

// 元素类型定义
typedef NS_ENUM(NSInteger, PPElementType)
{
    PPElementTypeNone,        // 无
    
    PPElementTypeMetal,       // 金
    PPElementTypePlant,       // 木
    PPElementTypeWater,       // 水
    PPElementTypeFire,        // 火
    PPElementTypeEarth,       // 土
    
    PPElementTypeSteel,       // 钢
    PPElementTypePosion,      // 毒
    PPElementTypeIce,         // 冰
    PPElementTypeBlaze,       // 炎
    PPElementTypeStone,       // 岩
    
    PPElementTypeBurst,       // 爆
    PPElementTypeSand,        // 沙
    PPElementTypeThunder,     // 雷
    PPElementTypeTree,        // 树
    PPElementTypeWind         // 风
};

// 属性相克数值策划表
static const float kElementInhibition[kElementTypeMax + 1][kElementTypeMax + 1] = {
    {0.00f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f, 0.00f},
    {0.00f, 1.00f, 1.30f, 1.00f, 0.70f, 1.15f, 0.85f, 1.15f, 0.85f, 0.55f, 1.00f},
    {0.00f, 0.70f, 1.00f, 1.15f, 1.00f, 1.30f, 0.55f, 1.15f, 1.00f, 0.85f, 1.15f},
    {0.00f, 1.15f, 0.85f, 1.00f, 0.70f, 0.70f, 1.00f, 0.70f, 0.85f, 1.15f, 0.55f},
    {0.00f, 1.30f, 1.15f, 0.70f, 1.00f, 1.00f, 1.15f, 1.00f, 0.55f, 0.85f, 0.85f},
    {0.00f, 1.00f, 0.70f, 1.30f, 1.15f, 1.00f, 0.70f, 0.55f, 1.15f, 1.00f, 0.85f},
    {0.00f, 1.15f, 1.45f, 1.15f, 0.85f, 1.30f, 1.00f, 1.15f, 1.00f, 0.70f, 1.15f},
    {0.00f, 0.85f, 1.15f, 1.30f, 1.15f, 1.45f, 0.70f, 1.00f, 1.15f, 1.00f, 1.30f},
    {0.00f, 1.15f, 1.15f, 1.15f, 1.45f, 0.85f, 1.15f, 1.00f, 1.00f, 1.30f, 0.70f},
    {0.00f, 1.45f, 1.30f, 0.85f, 1.15f, 1.15f, 1.30f, 1.15f, 0.70f, 1.00f, 1.00f},
    {0.00f, 1.15f, 0.85f, 1.45f, 1.30f, 1.15f, 1.00f, 0.70f, 1.30f, 1.15f, 1.00f},
};

// 属性融合策划表
static const int kElementMix[kElementTypeMax + 1][kElementTypeMax + 1] = {
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
};

@interface ConstantData : NSObject

+(NSString *)elementName:(PPElementType)elementType;

@end
