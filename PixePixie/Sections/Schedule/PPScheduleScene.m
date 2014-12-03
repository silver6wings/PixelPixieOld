

#import "PPScheduleScene.h"
//#import "PPActivityDetailScene.h"

static NSString * activityTitle[] = {
    @"每日日常",
    @"每日抽奖",
    @"神秘转轮",
    @"活动图标",
    @"活动图标"
};

static NSString * joinTitle[] = {
    @"进入",
    @"进入",
    @"进入",
    @"进入",
    @"进入"
};

@implementation PPScheduleScene

-(id)initWithSize:(CGSize)size{
    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [UIColor purpleColor];
        [self setBackTitleText:@"Schedule" andPositionY:360.0f];
        
        for (int i = 0; i < 5; i++) {
            
            SKSpriteNode * activityBarContent = [[SKSpriteNode alloc] initWithColor:[UIColor brownColor] size:CGSizeMake(280.0f, 50)];
            activityBarContent.position = CGPointMake(160.0f, 30+70.0f*i);
            
            SKLabelNode * labalTitle = [[SKLabelNode alloc] init];
            labalTitle.fontSize = 12;
            [labalTitle setText:activityTitle[i]];
            [labalTitle setPosition:CGPointMake(-100.0f, 0.0)];
            [activityBarContent addChild:labalTitle];
            
            
            SKLabelNode * labalContent = [[SKLabelNode alloc] init];
            labalContent.fontSize = 12;
            [labalContent setText:@"活动信息"];
            [labalContent setPosition:CGPointMake(0.0f, 0.0)];
            [activityBarContent addChild:labalContent];
            
            
            PPSpriteButton *joinButton = [PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(40.0f, 40.0f)];
            [joinButton setLabelWithText:joinTitle[i] andFont:[UIFont systemFontOfSize:15] withColor:nil];
            joinButton.position = CGPointMake(100.0f,0.0f);
            joinButton.name = [NSString stringWithFormat:@"%d",i];
            [joinButton addTarget:self selector:@selector(joinButtonClick:)
                       withObject:joinButton.name forControlEvent:PPButtonControlEventTouchUpInside];
            [activityBarContent addChild:joinButton];
            
            [self addChild:activityBarContent];
            
        }
    }
    return self;
}

-(void)joinButtonClick:(NSString *)backName
{
    PPActivityDetailScene * activityDetail = [[PPActivityDetailScene alloc] initWithSize:self.view.bounds.size];
    activityDetail->previousScene = self;
    [self.view presentScene:activityDetail transition:[SKTransition doorwayWithDuration:1.0]];
}

-(void)backButtonClick:(NSString *)backName
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PP_BACK_TO_MAIN_VIEW object:nil];
}

@end
