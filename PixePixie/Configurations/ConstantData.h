

static const int kWallThick = 1;                    // 墙的厚度
static const int kBallNumberMax = 15;               // 球的最大数量
static const int kBallRadius = 15;                  // 球的半径
static const int kBallSize = kBallRadius * 2;       // 球的直径
static const int kBallSustainRounds = 5;            // 球的持续回合

static const float kBallLinearDamping = 0.6f;       // 线阻尼系数
static const float kBallAngularDamping = 0.8f;      // 角阻尼系数
static const float kBallFriction = 0.0f;            // 表面摩擦力
static const float kBallRestitution = 1.0f;         // 弹性恢复系数

static const float kAutoAttackMax = 50.0f;          // 自动攻击最大力量限制
static const float kBounceReduce = 0.5f;            // 弹出去的按距离比例衰减系数
static const float kStopThreshold = 5.0f;           // 速度停止阈值
static const float kVelocityAddition = 1.1f;        // 撞击加速系数

// 最大元素类型个数
static const int kElementTypeMax = 10;

// 元素类型定义
typedef NS_ENUM(NSInteger, PPElementType)
{
    PPElementTypeNone = 0,    // 无
    
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

typedef NS_ENUM(NSInteger, PPPhysicsBodyStatus)
{
    
    PPPhysicsBodyStatusNone = 0,
    PPPhysicsBodyStatusForest
    
};


// 血条显示
typedef enum {
    PP_HPTYPE,
    PP_MPTYPE
}VALUESHOWTYPE;

// 技能类型定义
typedef NS_ENUM(NSInteger, PPSkillUniversalType)
{
    PPSkillTypePhysicalAttack = 0,     // 物理攻击
    PPSkillTypeBallAttack,             // 弹球攻击
    PPSkillTypeSubtractBlood,          // 耗血技能
    PPSkillTypeAppendBlood,            // 补血技能
    PPSkillTypeSubtractDefense,        // 削减对方防御
    PPSkillTypeAppendDefense,          // 增加本体防御
};

// 球类型定义
typedef NS_ENUM(NSInteger, PPBallType)
{
    PPBallTypeNone = 0,     // 无
    PPBallTypePlayer,       // 玩家球
    PPBallTypeEnemy,        // 敌方球
    PPBallTypeCombo,        // 连击球
    PPBallTypeElement,      // 元素球
    PPBallTypeTrap,         // 陷阱球
};

// 临时状态buff定义
typedef NS_ENUM(NSInteger, PPBuffUniversalType)
{
    PPBuffTypeAttackAddition = 0,              // 伤害加成
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
    {0.00f, 1.15f, 0.85f, 1.45f, 1.30f, 1.15f, 1.00f, 0.70f, 1.30f, 1.15f, 1.00f}
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
