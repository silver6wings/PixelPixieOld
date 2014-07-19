

@interface PPHurdleReadyScene : PPBasicScene

@property (nonatomic,retain) NSDictionary *allEnemys;
@property (retain,nonatomic) NSArray *petsArray;

-(void)setEnemysArray;
-(void)setCurrentHurdle:(int)currentIndex;
@end
