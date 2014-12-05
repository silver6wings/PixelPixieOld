//
//  PPHelpScene.m
//  PixelPixie
//
//  Created by xiefei on 7/10/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPHelpScene.h"

@implementation PPHelpScene
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        [self setBackTitleText:@"Help" andPositionY:360.0f];
    }
    
    return self;
}
-(void)backButtonClick:(NSString *)backName
{
    
    [self.view presentScene:previousScene transition:[SKTransition doorwayWithDuration:1.0]];
    
    
}
@end
