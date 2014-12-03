//
//  PPMonsterBookScene.m
//  PixelPixie
//
//  Created by xiefei on 7/10/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPMonsterBookScene.h"

@implementation PPMonsterBookScene
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        [self setBackTitleText:@"Monster book" andPositionY:360.0f];
    }
    
    return self;
}
-(void)backButtonClick:(NSString *)backName
{
    
    [self.view presentScene:previousScene transition:[SKTransition doorwayWithDuration:1.0]];
    
    
}
@end
