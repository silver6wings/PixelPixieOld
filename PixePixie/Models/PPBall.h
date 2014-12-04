
#import <objc/runtime.h>

@class PPPixie;

@interface NSObject (ExtendedProperties)
@property (nonatomic, strong, readwrite) id PPBallPhysicsBodyStatus;
@property (nonatomic, strong, readwrite) id PPBallSkillStatus;
@end

// Implementation

static void * MyObjectMyCustomPorpertyKey = (void *) @"MyObjectMyCustomPorpertyKey";
static void * MyObjectMyCustomPorpertyKey1 = (void *) @"MyObjectMyCustomPorpertyKey1";

@implementation NSObject (ExtendedProperties)

- (id)PPBallPhysicsBodyStatus
{
    return objc_getAssociatedObject(self, MyObjectMyCustomPorpertyKey);
}

- (void)setPPBallPhysicsBodyStatus:(id)myCustomProperty
{
    objc_setAssociatedObject(self, MyObjectMyCustomPorpertyKey, myCustomProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)PPBallSkillStatus
{
    return objc_getAssociatedObject(self, MyObjectMyCustomPorpertyKey1);
}

- (void)setPPBallSkillStatus:(id)myCustomProperty
{
    objc_setAssociatedObject(self, MyObjectMyCustomPorpertyKey1, myCustomProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
@class PPBallBattleScene;
@interface PPBall : SKSpriteNode
{
    
    @public
    id target;
    SEL animationEndSel;
    PPBallBattleScene *battleCurrentScene;
    
}

@property (nonatomic,retain) NSMutableArray * ballBuffs;
@property (nonatomic,assign) int ballStatus;
@property (nonatomic) int sustainRounds;
@property (nonatomic) PPBallType ballType;
@property (nonatomic) PPElementType ballElementType;
@property (nonatomic) PPPixie * pixie;
@property (nonatomic) PPPixie * pixieEnemy;

@property (nonatomic,retain) NSArray * comboBallTexture;
@property (nonatomic,retain) SKSpriteNode * comboBallSprite;
@property (nonatomic,retain) SKSpriteNode * plantrootAnimationNode;

/**
 * @brief 生成宠物球
 */
+(PPBall *)ballWithPixie:(PPPixie *)pixie;
/**
 * @brief 生成敌方宠物
 */
+(PPBall *)ballWithPixieEnemy:(PPPixie *)pixieEnemy;
/**
 * @brief 生成元素球
 */
+(PPBall *)ballWithElement:(PPElementType)element;
/**
 * @brief 生成连击球
 */
+(PPBall *)ballWithCombo;

/**
 * @brief 增加buff
 * @param buffName buff名称
 * @param continueRound buff持续回合
 */
-(void)addBuffWithName:(NSString *)buffName andRoundNum:(int)continueRound;
/**
 * @brief 改变buff回合
 */
-(void)changeBuffRound;
/**
 * @brief 设置元素球的持续回合
 */
-(void)setRoundsLabel:(int)rounds;
/**
 * @brief 创建恢复默认纹理动画
 */
-(void)setToDefaultTexture;
/**
 * @brief 创建连击球碰撞动画
 */
-(void)startComboAnimation:(CGVector)vectorValue;
/**
 * @brief 创建治疗动画
 */
-(void)startPixieHealAnimation;
/**
 * @brief 处理加速效果动画
 * @param velocity 速度矢量
 * @param pose 动画形式
 */
-(void)startPixieAccelerateAnimation:(CGVector)velocity andType:(NSString *)pose;
/**
 * @brief  创建元素撞击动画
 * @param ballArray 元素球数组
 * @param battleScene 战斗场景
 */

-(void)startElementBallHitAnimation:(NSMutableArray *)ballArray isNeedRemove:(BOOL)isNeed andScene:(PPBasicScene *)battleScene;
/**
 * @brief 元素球自然消失动画 自身持续回合数已到
 * @param ballArray 元素球数组
 * @param battleScene 战斗场景
 
 */
-(void)startRemoveAnimation:(NSMutableArray *)ballArray  andScene:(PPBasicScene *)battleScene;
/**
 * @brief 元素球生成动画
 */
-(void)startElementBirthAnimation;
/**
 * @brief 元素球变身陷阱动画
*/
-(void)startMagicballAnimation;

/**
* @brief 陷阱缠绕动画
* @param isAppear 是缠绕出现  YES代表缠绕动画   NO代表缠绕消失动画
* @attention
* @warning
* @return
*/

-(void)startPlantrootAppearOrDisappear:(BOOL)isAppear;


@end