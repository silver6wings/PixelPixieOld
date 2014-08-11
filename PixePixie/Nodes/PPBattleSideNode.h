
@class PPValueShowNode;

@interface PPBattleSideNode : PPBasicSpriteNode
{
    PPValueShowNode *petPlayerHP;
    PPValueShowNode *enemyPlayerHP;
    
    PPValueShowNode *petPlayerMP;
    PPValueShowNode *enemyPlayerMP;
}
//回调对象
@property(nonatomic, assign) id target;

//回调方法
@property(nonatomic, assign) SEL skillSelector;

//回调方法
@property(nonatomic, assign) SEL showInfoSelector;

@property(nonatomic, assign) SEL pauseSelector;

@property(nonatomic, assign) SEL hpBeenZeroSel;
@property(nonatomic, retain) PPPixie *currentPPPixie;
@property(nonatomic, retain) PPPixie *currentPPPixieEnemy;

-(void)setSideSkillsBtn:(PPPixie *)ppixie;
-(void)setSideElements:(PPPixie *)petppixie andEnemy:(PPPixie *)enemyppixie;

-(void)changePetHPValue:(CGFloat)HPValue;
-(void)changeEnemyHPValue:(CGFloat)HPValue;
-(void)setSideSkillButtonDisable;
-(void)setSideSkillButtonEnable;

@end
