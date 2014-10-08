

@class PPPixie;

@interface SKPhysicsBody (PPPhysicsBodyStatus) //为SKPhysicsBody类添加状态属性

@property(nonatomic,assign)PPPhysicsBodyStatus bodyStatusValue;//方法

@end

@implementation SKPhysicsBody (PPPhysicsBodyStatus)
@dynamic bodyStatusValue;
//-(PPPhysicsBodyStatus)getbodyStatusValue
//{
//    return _bodyStatusValue;
//}
//-(void)setbodyStatusValue:(PPPhysicsBodyStatus)ppbodyStatus
//{
//    _bodyStatusValue = ppbodyStatus;
//}
@end

@interface PPBall : SKSpriteNode

@property (nonatomic,assign)int ballStatus;
@property (nonatomic) int sustainRounds;
@property (nonatomic) PPBallType ballType;
@property (nonatomic) PPElementType ballElementType;
@property (nonatomic) PPPixie * pixie;
@property (nonatomic) PPPixie * pixieEnemy;

+(PPBall *)ballWithPixie:(PPPixie *)pixie;
+(PPBall *)ballWithPixieEnemy:(PPPixie *)pixieEnemy;
+(PPBall *)ballWithElement:(PPElementType)element;
+(PPBall *)ballWithCombo;
-(void)setRoundsLabel:(int)rounds;
-(void)setToDefaultTexture;

@end