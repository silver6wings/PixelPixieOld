
#import <objc/runtime.h>

@class PPPixie;

@interface NSObject (ExtendedProperties)
@property (nonatomic, strong, readwrite) id PPBallPhysicsBodyStatus;
@property (nonatomic, strong, readwrite) id PPBallSkillStatus;
@end

// Implementation

static void * MyObjectMyCustomPorpertyKey = (void *)@"MyObjectMyCustomPorpertyKey";
static void * MyObjectMyCustomPorpertyKey1 = (void *)@"MyObjectMyCustomPorpertyKey1";

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

@interface PPBall : SKSpriteNode
{
    
    @public
    id target;
    SEL animationEndSel;
    
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

+(PPBall *)ballWithPixie:(PPPixie *)pixie;
+(PPBall *)ballWithPixieEnemy:(PPPixie *)pixieEnemy;
+(PPBall *)ballWithElement:(PPElementType)element;
+(PPBall *)ballWithCombo;

//buff
-(void)addBuffWithName:(NSString *)buffName andRoundNum:(int)continueRound;
-(void)changeBuffRound;

-(void)setRoundsLabel:(int)rounds;
-(void)setToDefaultTexture;
-(void)startComboAnimation;
-(void)startPixieHealAnimation;
-(void)startPixieAccelerateAnimation:(CGVector)velocity andType:(NSString *)pose;
-(void)startElementBallHitAnimation:(NSMutableArray *)ballArray isNeedRemove:(BOOL)isNeed andScene:(PPBasicScene *)battleScene;
-(void)startRemoveAnimation:(NSMutableArray *)ballArray  andScene:(PPBasicScene *)battleScene;
-(void)startElementBirthAnimation;
-(void)startMagicballAnimation;
-(void)startPlantrootAppearOrDisappear:(BOOL)appearOrDisappear andScene:(PPBasicScene *)sceneBattle;


@end