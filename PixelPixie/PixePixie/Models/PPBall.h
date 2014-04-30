
@class PPPixie;

@interface PPBall : SKSpriteNode
{
    PPPixie * pixie;                // 球隶属于那个宠物
    PPElementType ballElementType;  // 球属于哪个元素
}

@property (nonatomic) PPPixie * pixie;
@property (nonatomic) PPElementType ballElementType;

+(PPBall *)ballWithPixie:(PPPixie *)pixie;
+(PPBall *)ballWithElement:(PPElementType)element;

@end