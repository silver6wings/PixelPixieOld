//
//  PPFightingMainView.h
//  PixelPixie
//
//  Created by xiefei on 7/3/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PPMenuThemeScene;
@interface PPFightingMainView : SKView
{
    @public
    PPMenuThemeScene * mainScene;
   
}
-(void)changeToPassScene;
@end
