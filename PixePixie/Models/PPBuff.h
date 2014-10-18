

@interface PPBuff : NSObject

@property (nonatomic,retain) NSString *buffName;

@property (nonatomic,retain) NSString *buffId;

@property (nonatomic,assign) int continueRound;

@property (nonatomic,assign) NSInteger cdRoundsAttAdd;  //伤害加成回合数
@property (nonatomic,assign) NSInteger cdRoundsDefAdd;  //防御加成回合数
@property (nonatomic,assign) CGFloat attackAddition;    //伤害加成
@property (nonatomic,assign) CGFloat defenseAddition;   //防御加成

@end
