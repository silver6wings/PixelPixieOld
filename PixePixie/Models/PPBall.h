
#import <objc/runtime.h>

@class PPPixie;

@interface NSObject (ExtendedProperties)
@property (nonatomic, strong, readwrite) id PPBallPhysicsBodyStatus;
@end

// Implementation

static void * MyObjectMyCustomPorpertyKey = (void *)@"MyObjectMyCustomPorpertyKey";

@implementation NSObject (ExtendedProperties)

- (id)PPBallPhysicsBodyStatus
{
    return objc_getAssociatedObject(self, MyObjectMyCustomPorpertyKey);
}

- (void)setPPBallPhysicsBodyStatus:(id)myCustomProperty
{
    objc_setAssociatedObject(self, MyObjectMyCustomPorpertyKey, myCustomProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@interface PPBall : SKSpriteNode

@property (nonatomic,assign) int ballStatus;
@property (nonatomic) int sustainRounds;
@property (nonatomic) PPBallType ballType;
@property (nonatomic) PPElementType ballElementType;
@property (nonatomic) PPPixie * pixie;
@property (nonatomic) PPPixie * pixieEnemy;

@property (nonatomic,retain) NSArray * comboBallTexture;
@property (nonatomic,retain) PPBasicSpriteNode * comboBallSprite;

+(PPBall *)ballWithPixie:(PPPixie *)pixie;
+(PPBall *)ballWithPixieEnemy:(PPPixie *)pixieEnemy;
+(PPBall *)ballWithElement:(PPElementType)element;
+(PPBall *)ballWithCombo;

-(void)setRoundsLabel:(int)rounds;
-(void)setToDefaultTexture;
-(void)startComboAnimation;
-(void)startPixieHealAnimation;
-(void)startElementBallHitAnimation;
@end