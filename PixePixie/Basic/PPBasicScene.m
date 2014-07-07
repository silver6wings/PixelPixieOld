#import "PPBasicScene.h"
#import "PPSpriteButton.h"
@interface PPBasicScene()
{
    PPCustomButton *backButtonTitle;
}
@end
@implementation PPBasicScene

- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        self.backgroundColor = [UIColor redColor];
        
       PPSpriteButton       *button = [PPSpriteButton buttonWithColor:[UIColor redColor] andSize:CGSizeMake(300, 100)];
        [button setLabelWithText:@"返回" andFont:nil withColor:nil];
        button.position = CGPointMake(self.size.width / 2, self.size.height / 3);
        [button addTarget:self selector:@selector(addSpaceshipAtPoint:) withObject:[NSValue valueWithCGPoint:CGPointMake(self.size.width / 2, self.size.height / 2)] forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:button];
        
        
        PPCustomButton *backButton=[PPCustomButton buttonWithSize:CGSizeMake(120.0f, 30.0f) andTitle:@"返回" withTarget:self withSelecter:@selector(backToSuperScene)];
        backButton.position = CGPointMake(0.0f, 300);
        [self addChild:backButton];
        
        

        
    }
    return self;
}

-(void)addSpaceshipAtPoint:(NSValue*)pointValue
{
    
    
    
    CGPoint point = [pointValue CGPointValue];
    

    
}

-(void)didMoveToView:(SKView *)view
{
    

}
-(void)backToSuperScene
{
    
}
@end
