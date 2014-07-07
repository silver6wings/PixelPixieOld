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
        PPPassNumberScene* mainScene=[[PPPassNumberScene alloc] initWithSize:self.bounds.size];
        mainScene.scaleMode=SKSceneScaleModeFill;
        [self presentScene:mainScene];
        // Initialization code
    }
    return self;
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
