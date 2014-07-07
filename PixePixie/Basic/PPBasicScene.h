//#define EXTERN_SIZE_SCREEN_MERGE CGSizeMake(320.0f,480.0f)

@interface PPBasicScene : SKScene
{
    @public
    id target;
    SEL backBtnSel;
    SKScene *previousScene;
}
-(void)setBackTitleText:(NSString *)title andPositionY:(CGFloat)yValue;
@end
