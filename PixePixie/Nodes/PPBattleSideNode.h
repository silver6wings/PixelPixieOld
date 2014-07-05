

@interface PPBattleSideNode : PPBasicSpriteNode
{
    PPValueShowNode *barPlayerHP;
    PPValueShowNode *barPlayerMP;
}
//回调对象
@property(nonatomic,assign) id target;
//回调方法
@property(nonatomic,assign) SEL skillSelector;

//回调方法
@property(nonatomic,assign) SEL physicsAttackSelector;

@property(nonatomic,assign) SEL hpBeenZeroSel;
@property(nonatomic,retain) PPPixie *currentPPPixie;
@property(nonatomic,retain) PPEnemyPixie *currentEenemyPPPixie;
-(void)setSideElementsForPet:(PPPixie *)ppixie;
-(void)setSideElementsForEnemy:(PPEnemyPixie *)ppixie;
-(void)changeHPValue:(CGFloat)HPValue;
@end
