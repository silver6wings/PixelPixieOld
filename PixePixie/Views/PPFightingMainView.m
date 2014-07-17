//
//  PPFightingMainView.m
//  PixelPixie
//
//  Created by xiefei on 7/3/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPFightingMainView.h"
@implementation PPFightingMainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor yellowColor];

        [self changeToPassScene];
       

        
        // Initialization code
    }
    return self;
}

-(void)changeToPassScene
{
    
    PPMenuThemeScene * mainScene = [[PPMenuThemeScene alloc] initWithSize:self.bounds.size];
    mainScene.scaleMode = SKSceneScaleModeFill;
    [self presentScene:mainScene];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
