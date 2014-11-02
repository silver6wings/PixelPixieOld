

@interface PPHurdleReadyScene : PPBasicScene
{
    @public
    PPElementType chooseSceneType; //场景类型
    
}
@property (nonatomic,retain) NSDictionary *allEnemys; //所有的怪物
@property (retain,nonatomic) NSArray *petsArray; //己方的所有宠物
/**
 * @brief 设置本次小副本战斗怪物
 */
-(void)setEnemysArray;
/**
 * @brief 进行场景推进来遇到怪物
 * @param currentIndex 第几个怪物索引
 */
-(void)setCurrentHurdle:(int)currentIndex;
@end
