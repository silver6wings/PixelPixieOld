//
//  PPMonsterMainView.h
//  PixelPixie
//
//  Created by xiefei on 7/3/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PPMonsterScene;
@interface PPMonsterMainView : SKView
{
    PPMonsterScene* mainScene;
}
-(void)hideMonstorShowBtns;
@end
