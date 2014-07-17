#import "PPSecondaryPassScene.h"

@implementation PPSecondaryPassScene
@synthesize passDictInfo;

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        [self setBackTitleText:@"副本选择" andPositionY:450.0f];
        
        for (int i=0; i<5; i++) {
            PPSpriteButton *  passButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(90, 60)];
            
            [passButton setLabelWithText:[NSString stringWithFormat:@"副本 %d",5-i] andFont:[UIFont systemFontOfSize:15] withColor:nil];
            passButton.position = CGPointMake(160.0f,i*70+60);
            
            passButton.name = [NSString stringWithFormat:@"%d",i+PP_SECONDARY_PASSNUM_BTN_TAG];
            [passButton addTarget:self selector:@selector(secondaryPassChoose:) withObject:passButton.name forControlEvent:PPButtonControlEventTouchUpInside];
            [self addChild:passButton];
            
        }
    }
   
    return self;
}

-(void)secondaryPassChoose:(NSString *)stringname
{
    
    PPPetChooseScene *petchoose = [[PPPetChooseScene alloc] initWithSize:self.view.bounds.size];
    petchoose->previousScene = self;
    [self.view presentScene:petchoose transition:[SKTransition doorsOpenHorizontalWithDuration:1]];
    
    
}
@end
