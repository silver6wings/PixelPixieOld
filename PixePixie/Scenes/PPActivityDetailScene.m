//
//  PPActivityDetailScene.m
//  PixelPixie
//
//  Created by xiefei on 7/9/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPActivityDetailScene.h"

@implementation PPActivityDetailScene
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        [self setBackTitleText:@"schedule" andPositionY:360.0f];
        
    }
    
    return self;
}
-(void)backButtonClick:(NSString *)backName
{
    
    [self.view presentScene:previousScene transition:[SKTransition doorsCloseVerticalWithDuration:1.0]];
    
    
}
@end
