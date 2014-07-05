

@interface PPPassNumberScroll : UIView

@property (strong, nonatomic)SKScene *scene;
@property (weak, nonatomic) UIView *view;

@property(nonatomic,assign) id target; // 回调对象
@property(nonatomic,assign) SEL selector; // 回调方法

-(void)creatPassNumberScroll:(NSDictionary *)passInfo with:(SKScene *)sceneTmp;

@end
