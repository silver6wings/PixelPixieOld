//
//  PPMainScene.m
//  PixelPixie
//
//  Created by xiefei on 5/21/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPMainScene.h"

@implementation PPMainScene
@synthesize chooseCouterpartSel=_chooseCouterpartSel;
@synthesize chooseTarget=_chooseTarget;
CGPoint couterpartPosition[]={
    {150.0f,300.0f}
};
NSString *couterpartName[]={
 @"封印之塔"
};
- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        
        self.backgroundColor = [UIColor blueColor];
        
        SKLabelNode *counterpartNode = [SKLabelNode labelNodeWithFontNamed:@""];
        counterpartNode.name=@"couterpart";
        counterpartNode.text = couterpartName[0];
        counterpartNode.fontSize = 15;
        counterpartNode.fontColor = [UIColor yellowColor];
        counterpartNode.position = CGPointMake(couterpartPosition[0].x,couterpartPosition[0].y);
        
        [self addChild:counterpartNode];
        
        
    }
    return self;
}
-(void)choosePassNumber
{
    if (self.chooseTarget!=nil&&self.chooseCouterpartSel!=nil&&[self.chooseTarget respondsToSelector:self.chooseCouterpartSel]) {
    
        [self.chooseTarget performSelectorInBackground:self.chooseCouterpartSel withObject:nil];
    }

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:touchLocation];
        
        if ([node.name isEqualToString:@"couterpart"]) {
            [self choosePassNumber];
        }
    }
}
@end
