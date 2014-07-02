//
//  PPBasicScene.m
//  PixelPixie
//
//  Created by xiefei on 5/20/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPBasicScene.h"

@implementation PPBasicScene
-(id)init
{
    self=[super init];
    if (self) {
        self.size=CGSizeMake(320.0f, 480.0f);
    }
    return self;
}
-(void)didMoveToView:(SKView *)view
{
    if ([UIScreen mainScreen].bounds.size.height>500) {

    [self.view setFrame:CGRectMake(0.0f, 44.0f, 320.0, 480.0f)];
    }
}
@end
