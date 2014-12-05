

@interface PPPassNumberScroll : UIView

@property (retain, nonatomic)SKScene *scene;
@property (retain, nonatomic) UIView *view;

@property(nonatomic,assign) id target; // 回调对象
@property(nonatomic,assign) SEL selector; // 回调方法

-(void)creatPassNumberScroll:(NSDictionary *)passInfo with:(SKScene *)sceneTmp;

@end
