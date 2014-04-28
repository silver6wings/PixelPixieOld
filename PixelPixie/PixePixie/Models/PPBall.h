
@interface PPBall : SKSpriteNode
{
    BOOL isPlayerBall;
}

+(PPBall *)ballWithElement:(PPElementType) element;
+(PPBall *)ballWithPlayer:(NSString *)player;

@end

