//
//  PPSkillCaculate.h
//  PixelPixie
//
//  Created by xiefei on 6/17/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPModels.h"
#import "PPPixie.h"
#import "PPEnemyPixie.h"
@interface PPSkillCaculate : NSObject
+ (instancetype)getInstance;

- (CGFloat)bloodChangeForPhysicalAttack:(CGFloat )attackValue andAddition:(CGFloat) attValueAddition andOppositeDefense:(CGFloat) defValue andOppositeDefAddition:(CGFloat)defAddition andDexterity:(CGFloat)dexterity;

-(CGFloat)bloodChangeForBallAttack:(BOOL)targetDirection andPet:(PPPixie * )petPixie andEnemy:(PPEnemyPixie *)enemyPixie;
    


@end
