
@interface PPTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign) id choosePassNumber; // 回调对象
@property(nonatomic,assign) SEL choosePassNumberSel; // 回调方法

-(void)ppsetTableViewWithData:(NSArray *)array;

@end
