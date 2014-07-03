//
//  PPBasicScene.m
//  PixelPixie
//
//  Created by xiefei on 5/20/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPBasicScene.h"

@implementation PPBasicScene

-(void)didMoveToView:(SKView *)view
{
    
    if (self.view.frame.size.height>500) {
        PPBasicSpriteNode *ppBasicBlack=[[PPBasicSpriteNode alloc] init];
        [ppBasicBlack setColor:[UIColor blackColor]];
        ppBasicBlack.position=CGPointMake(0.0f, self.view.frame.size.height);
        ppBasicBlack.size=CGSizeMake(320.0f, 44.0f);
    }
  
    

}
@end
