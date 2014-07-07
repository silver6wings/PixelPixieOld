//
//  PPTalentTreeScene.m
//  PixelPixie
//
//  Created by xiefei on 7/7/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPTalentTreeScene.h"

@implementation PPTalentTreeScene
- (id)initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        self.backgroundColor = [UIColor grayColor];
        [self setBackTitleText:@"Talent Tree" andPositionY:360.0f];

    }
    return self;
}
-(void)backButtonClick:(NSString *)backName
{
    
    [self.view presentScene:previousScene transition:[SKTransition doorwayWithDuration:1.0]];
    
    
}
@end
