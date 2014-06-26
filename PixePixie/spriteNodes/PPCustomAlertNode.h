//
//  PPCustomAlertNode.h
//  PixelPixie
//
//  Created by xiefei on 6/26/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PPBasicSpriteNode.h"
@interface PPCustomAlertNode : PPBasicSpriteNode
{
    @public
    id target;
    SEL alertConfirm;
}
-(id)initWithFrame:(CGRect)frame;
-(void)showCustomAlertWithInfo:(NSDictionary *)alertInfo;

@end
