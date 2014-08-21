//
//  PPMainView.m
//  PixelPixie
//
//  Created by xiefei on 7/3/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPMainView.h"

@implementation PPMainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        PPMainScene* mainScene=[[PPMainScene alloc] initWithSize:self.bounds.size];
        mainScene.scaleMode=SKSceneScaleModeFill;
        [self presentScene:mainScene];
        // Initialization code
    }
    return self;
}


@end
