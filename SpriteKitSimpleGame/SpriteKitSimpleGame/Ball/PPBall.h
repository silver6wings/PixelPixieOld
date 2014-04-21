//
//  PPBall.h
//  SpriteKitSimpleGame
//
//  Created by silver6wings on 14-4-21.
//  Copyright (c) 2014年 silver6wings. All rights reserved.
//

#import <Foundation/Foundation.h>


static const int BALL_RADIUS = 15;
static const int BALL_SIZE = BALL_RADIUS * 2;

@interface PPBall : SKSpriteNode

+(PPBall *)ballWithElement:(int) element;
+(PPBall *)ballWithPlayer:(NSString *)player;

@end

