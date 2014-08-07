

@interface PPCustomAlertNode : PPBasicSpriteNode
{
    @public
    id target;
    SEL alertConfirm;
    SEL btnClickSel;
}

-(id)initWithFrame:(CGRect)frame;

-(void)showCustomAlertWithInfo:(NSDictionary *)alertInfo;

-(void)showPauseMenuAlertWithTitle:(NSString *)titleStr andMessage:(NSString *)messageStr;
@end
