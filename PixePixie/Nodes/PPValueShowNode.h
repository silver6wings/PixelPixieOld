
@interface PPValueShowNode : PPBasicSpriteNode
{
@public
    CGFloat maxValue;
    CGFloat currentValue;
    id target;
    SEL animateEnd;
    CGFloat originalMax;
}

-(void)setMaxValue:(CGFloat)maxV
   andCurrentValue:(CGFloat)currentV
       andShowType:(VALUESHOWTYPE)showType
    andAnchorPoint:(CGPoint )anchorPoint andElementTypeString:(NSString *)typeString;

-(CGFloat)valueShowChangeMaxValue:(CGFloat)maxV
                  andCurrentValue:(CGFloat)currentV;

@end
