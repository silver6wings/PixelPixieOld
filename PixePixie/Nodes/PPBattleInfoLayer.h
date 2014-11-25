

@class PPValueShowNode;

@interface PPBattleInfoLayer : SKSpriteNode
{
    PPValueShowNode *petPlayerHP;
    PPValueShowNode *enemyPlayerHP;
    PPValueShowNode *petPlayerMP;
    PPValueShowNode *enemyPlayerMP;
    BOOL isHaveDead;
    
    
}
//回调对象
@property(nonatomic, assign) id target;

//回调方法
@property(nonatomic, assign) SEL skillSelector;

//回调方法
@property(nonatomic, assign) SEL showInfoSelector;

@property(nonatomic, assign) SEL pauseSelector;

@property(nonatomic, assign) SEL hpBeenZeroSel;

@property(nonatomic, assign) SEL hpChangeEnd;

@property(nonatomic, assign) SEL skillInvalidSel;


@property(nonatomic, retain) PPPixie *currentPPPixie;
@property(nonatomic, retain) PPPixie *currentPPPixieEnemy;
/**
 * @brief 设置战斗场景技能显示条
 * @param ppixie 我方宠物
 * @param sceneString 场景属性
 */
-(void)setSideSkillsBtn:(PPPixie *)ppixie andSceneString:(NSString *)sceneString;
/**
 * @brief 设置战斗场景头像显示条
 * @param petppixie 我方宠物
 * @param enemyppixie 敌方怪物
 * @param sceneString 场景属性
 */
-(void)setSideElements:(PPPixie *)petppixie andEnemy:(PPPixie *)enemyppixie andSceneString:(NSString *)sceneString;

/**
 * @brief 改变我方HP值
 * @param HPValue 改变量
 */
-(void)changePetHPValue:(CGFloat)HPValue;
/**
 * @brief 改变敌方HP值
 * @param HPValue 改变量
 */
-(void)changeEnemyHPValue:(CGFloat)HPValue;
/**
 * @brief 改变我方魔法值
 * @param MPValue 改变量
 */
-(void)changePetMPValue:(CGFloat)MPValue;
/**
 * @brief 改变敌方魔法值
 * @param MPValue 改变量
 */
-(void)changeEnemyMPValue:(CGFloat)MPValue;
/**
 * @brief 设置技能按钮为禁用状态
 */
-(void)setSideSkillButtonDisable;
/**
 * @brief 设置技能按钮为可用状态
 */
-(void)setSideSkillButtonEnable;
/**
 * @brief 设置combo数
 * @param petCombos   我方宠物combo数
 * @param enemyCombos  敌方宠物combo数
 
 */
-(void)setComboLabelText:(int)petCombos  withEnemy:(int)enemyCombos;
/**
 * @brief
 */
-(void)setBufferBar:(NSArray *)buffs;

/**
 * @brief 受到物理攻击头像晃动
 * @param stringSide   战斗来源
 * @param sceneBattle  战斗场景
 
 */
-(void)shakeHeadPortrait:(NSString *)stringSide andCompletion:(PPBallBattleScene *)sceneBattle;
/**
 * @brief 增加buff显示
 * @param buffShow   buff信息
 * @param stringSide   战斗来源
 
 */
-(void)addBuffShow:(PPBuff *)buffShow andSide:(NSString *)stringSide;
/**
 * @brief 移除buff显示
 * @param buffShow   buff信息
 * @param stringSide   战斗来源
 
 */
-(void)removeBuffShow:(PPBuff *)buffShow andSide:(NSString *)stringSide;
/**
 * @brief 显示攻击动画
 * @param buffShow   buff信息
 * @param stringSide   战斗来源
 
 */
-(void)startAttackAnimation:(BOOL)isPetAttack;

@end
