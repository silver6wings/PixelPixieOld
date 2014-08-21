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
    }
    return self;
}

-(void)changeToPassScene
{
    PPMenuThemeScene * mainScene = [[PPMenuThemeScene alloc] initWithSize:self.bounds.size];
    mainScene.scaleMode = SKSceneScaleModeAspectFit;
    [self presentScene:mainScene];
}

@end
