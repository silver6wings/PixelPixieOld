//
//  PPScheduleScene.m
//  PixelPixie
//
//  Created by xiefei on 7/7/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPScheduleScene.h"

@implementation PPScheduleScene
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [UIColor purpleColor];
        [self setBackTitleText:@"Schedule" andPositionY:360.0f];
        
        
    }
    return self;
}
-(void)backButtonClick:(NSString *)backName
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PP_BACK_TO_MAIN_VIEW object:nil];
    
    
}
@end
