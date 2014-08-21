//
//  PPMonsterMainView.m
//  PixelPixie
//
//  Created by xiefei on 7/3/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPMonsterMainView.h"

@implementation PPMonsterMainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        PPMonsterScene* mainScene = [[PPMonsterScene alloc] initWithSize:self.bounds.size];
        mainScene.scaleMode = SKSceneScaleModeFill;
        [self presentScene:mainScene];
        self.backgroundColor = [UIColor redColor];
        // Initialization code
    }
    return self;
}

@end
