//
//  PPBattleSideNode.h
//  PixelPixie
//
//  Created by xiefei on 6/10/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPBasicSpriteNode.h"
#import "PPValueShowNode.h"
@interface PPBattleSideNode : PPBasicSpriteNode
{
    PPValueShowNode *barPlayerHP;
    PPValueShowNode *barPlayerMP;
}
//回调对象
@property(nonatomic,assign) id target;
//回调方法
@property(nonatomic,assign) SEL skillSelector;

//回调方法
@property(nonatomic,assign) SEL physicsAttackSelector;

@property(nonatomic,retain) PPPixie *currentPPPixie;
@property(nonatomic,retain) PPEnemyPixie *currentEenemyPPPixie;
-(void)setSideElementsForPet:(PPPixie *)ppixie;
-(void)setSideElementsForEnemy:(PPEnemyPixie *)ppixie;
-(void)changeHPValue:(CGFloat)HPValue;
-(void)changeMPValue:(CGFloat)MPValue;
@end
