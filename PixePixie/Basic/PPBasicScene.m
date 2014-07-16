#import "PPBasicScene.h"
#import "PPSpriteButton.h"
#import "PPCommonTool.h"
@interface PPBasicScene()
{
    PPSpriteButton *backButtonTitle;
    PPSpriteButton  *backButton;
}
@end
@implementation PPBasicScene

- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)setBackTitleText:(NSString *)title andPositionY:(CGFloat)yValue;
{
    
    backButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(45, 30)];
    [backButton setLabelWithText:@"返回" andFont:[UIFont systemFontOfSize:15] withColor:nil];
    backButton.position = CGPointMake(15.0f,yValue);
    [backButton addTarget:self selector:@selector(backButtonClick:) withObject:title forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:backButton];
    
    
    
    backButtonTitle = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(120, 30)];
    [backButtonTitle setLabelWithText:title andFont:[UIFont systemFontOfSize:15] withColor:nil];
    backButtonTitle.position = CGPointMake(backButton.position.x+backButton.size.width/2.0f+backButtonTitle.size.width/2.0f,backButton.position.y);
    [backButtonTitle addTarget:self selector:@selector(backTitleClick:) withObject:title forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:backButtonTitle];

}

-(void)backButtonClick:(NSString *)backName
{
    


    
}

-(void)backTitleClick:(NSString *)backName
{
    
    
    
    
}

-(void)didMoveToView:(SKView *)view
{
    

}
-(void)backToSuperScene
{
    
}
@end
