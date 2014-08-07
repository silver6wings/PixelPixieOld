#import "PPCustomAlertNode.h"

@implementation PPCustomAlertNode

-(id)initWithFrame:(CGRect)frame
{
    PPCustomAlertNode * customAlert=[[PPCustomAlertNode alloc] init];
    customAlert.position = frame.origin;
    customAlert.size = frame.size;
    [customAlert setColor:[UIColor whiteColor]];
    return customAlert;
    
}
-(void)showPauseMenuAlertWithTitle:(NSString *)titleStr andMessage:(NSString *)messageStr
{
    
    
    SKLabelNode * titleNameLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    titleNameLabel.fontColor = [UIColor blueColor];
    titleNameLabel.text = titleStr;
    titleNameLabel.position = CGPointMake(0.0f,150);
    [self addChild:titleNameLabel];
    
    if ([messageStr length]!=0) {
        
        SKLabelNode * textContentLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        textContentLabel.fontColor = [UIColor blueColor];
        textContentLabel.text = messageStr;
        textContentLabel.position = CGPointMake(0.0f,-50);
        [self addChild:textContentLabel];
    }
    
    
    PPSpriteButton *continueGameBtn=[PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(100.0f, 50)];
    continueGameBtn.position = CGPointMake(0.0f, 100);
    [continueGameBtn setLabelWithText:@"继续游戏" andFont:[UIFont boldSystemFontOfSize:15] withColor:[UIColor cyanColor]];
    continueGameBtn.name=@"button1";
    [continueGameBtn addTarget:self selector:@selector(buttonClick:) withObject:continueGameBtn.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:continueGameBtn];
    
    
    
    PPSpriteButton *backPrivousBtn=[PPSpriteButton buttonWithColor:[UIColor orangeColor] andSize:CGSizeMake(100.0f, 50)];
    backPrivousBtn.position = CGPointMake(0.0f, 0.0f);
    [backPrivousBtn setLabelWithText:@"返回上一级" andFont:[UIFont boldSystemFontOfSize:15] withColor:[UIColor cyanColor]];
    backPrivousBtn.name=@"button2";
    [backPrivousBtn addTarget:self selector:@selector(buttonClick:) withObject:backPrivousBtn.name forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:backPrivousBtn];
    

    
}
-(void)buttonClick:(NSString *)btnStr
{
    
//    if ([btnStr isEqualToString:@"button1"]) {
//        [self removeFromParent];
//    }else
//    {
    
        [self removeFromParent];
    if (self->target != nil && self->btnClickSel != nil &&
        [self->target respondsToSelector:self->btnClickSel])
    {
        [self->target performSelectorInBackground:self->btnClickSel withObject:btnStr];
    }
        
//    }
}
-(void)showCustomAlertWithInfo:(NSDictionary *)alertInfo
{
    SKLabelNode * titleNameLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    titleNameLabel.fontColor = [UIColor blueColor];
    titleNameLabel.text = [alertInfo objectForKey:@"title"];
    titleNameLabel.position = CGPointMake(0.0f,50);
    [self addChild:titleNameLabel];
    
    SKLabelNode * textContentLabel=[[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    textContentLabel.fontColor = [UIColor blueColor];
    textContentLabel.text = [alertInfo objectForKey:@"context"];
    textContentLabel.position = CGPointMake(0.0f,-50);
    [self addChild:textContentLabel];
    
    SKAction * action = [SKAction fadeAlphaTo:0.0f duration:4];
    [self runAction:action completion:^{
        [self removeFromParent];
        
    }];
}

@end
