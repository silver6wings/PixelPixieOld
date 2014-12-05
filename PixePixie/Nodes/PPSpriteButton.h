
#import <SpriteKit/SpriteKit.h>

typedef NS_OPTIONS(int, PPButtonControlEvent)
{
    PPButtonControlEventTouchDown = 1,
    PPButtonControlEventTouchUp,
    PPButtonControlEventTouchUpInside,
    PPButtonControlEventAllEvents
};

@interface PPSpriteButton : SKSpriteNode

@property (setter = setExclusiveTouch:, getter = isExclusiveTouch) BOOL exclusiveTouch;
@property (strong, nonatomic) SKLabelNode *label;

//SpriteButton初始化
+(PPSpriteButton *)buttonWithImageNamed:(NSString*)image;
+(PPSpriteButton *)buttonWithColor:(SKColor*)color andSize:(CGSize)size;
+(PPSpriteButton *)buttonWithTexture:(SKTexture*)texture andSize:(CGSize)size;
+(PPSpriteButton *)buttonWithTexture:(SKTexture *)texture;

//方法处理
-(void)addTarget:(id)target selector:(SEL)selector withObject:(id)object forControlEvent:(PPButtonControlEvent)controlEvent;
-(void)removeTarget:(id)target selector:(SEL)selector forControlEvent:(PPButtonControlEvent)controlEvent;
-(void)removeAllTargets;

//改变label text方法
-(void)setLabelWithText:(NSString*)text andFont:(UIFont*)font withColor:(UIColor*)fontColor;

//按钮点击变形方法
-(void)transformForTouchDown;
-(void)transformForTouchUp;

@end
