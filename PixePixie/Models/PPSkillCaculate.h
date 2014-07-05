

@interface PPSkillCaculate : NSObject

+(instancetype)getInstance;

-(CGFloat)bloodChangeForPhysicalAttack:(CGFloat)attackValue
                            andAddition:(CGFloat)attValueAddition
                     andOppositeDefense:(CGFloat)defValue
                 andOppositeDefAddition:(CGFloat)defAddition
                           andDexterity:(CGFloat)dexterity;

-(CGFloat)bloodChangeForBallAttack:(BOOL)targetDirection
                            andPet:(PPPixie *)petPixie
                          andEnemy:(PPEnemyPixie *)enemyPixie;

@end
