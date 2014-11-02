
@interface PPValueShowNode : SKSpriteNode
{
@public
    CGFloat maxValue;
    CGFloat currentValue;
    id target;
    SEL animateEnd;
    CGFloat originalMax;
}
/**
 * @brief 设置hp/mp变化条
 * @param maxV 上限值
 * @param showType 显示类型
 * @param showType anchorPoint 重心点
 * @param typeString 场景属性
 */
-(void)setMaxValue:(CGFloat)maxV
   andCurrentValue:(CGFloat)currentV
       andShowType:(VALUESHOWTYPE)showType
    andAnchorPoint:(CGPoint )anchorPoint andElementTypeString:(NSString *)typeString;
/**
 * @brief 设置hp/mp变化条改变动画
 * @param maxV 上限值
 * @param currentV 当前值
 */
-(CGFloat)valueShowChangeMaxValue:(CGFloat)maxV
                  andCurrentValue:(CGFloat)currentV;

@end
