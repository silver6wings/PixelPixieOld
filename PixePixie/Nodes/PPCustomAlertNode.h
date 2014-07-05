

@interface PPCustomAlertNode : PPBasicSpriteNode
{
    @public
    id target;
    SEL alertConfirm;
}
-(id)initWithFrame:(CGRect)frame;
-(void)showCustomAlertWithInfo:(NSDictionary *)alertInfo;

@end
