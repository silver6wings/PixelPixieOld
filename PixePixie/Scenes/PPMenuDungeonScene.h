
@interface PPMenuDungeonScene : PPBasicScene
{
    PPElementType currentElementType;
}
@property (retain,nonatomic) NSDictionary * passDictInfo;

-(id)initWithSize:(CGSize)size andElement:(PPElementType)elementType;

@end
