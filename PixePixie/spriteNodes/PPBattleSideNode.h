//
//  PPBattleSideNode.h
//  PixelPixie
//
//  Created by xiefei on 6/10/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPBasicSpriteNode.h"

@interface PPBattleSideNode : PPBasicSpriteNode
{
    PPHPSpriteNode *barPlayerHP;
}
-(void)setSideElements:(PPPixie *)ppixie;
-(void)changeHPValue:(CGFloat)HPValue;
@end
