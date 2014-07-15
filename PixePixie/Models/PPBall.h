

@class PPPixie;

@interface PPBall : SKSpriteNode

@property (nonatomic) PPElementType ballElementType;
@property (nonatomic) PPPixie * pixie;
@property (nonatomic) PPPixie * pixieEnemy;

+(PPBall *)ballWithPixie:(PPPixie *)pixie;
+(PPBall *)ballWithEnemyPixie:(PPPixie *)pixieEnemy;
+(PPBall *)ballWithElement:(PPElementType)element;
-(void)setToDefaultTexture;

@end