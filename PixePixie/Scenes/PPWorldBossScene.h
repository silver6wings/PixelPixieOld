//
//  PPWorldBossScene.h
//  PixelPixie
//
//  Created by xiefei on 7/14/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPBasicScene.h"

@interface PPWorldBossScene : PPBasicScene<SkillShowEndDelegate>
{
    int currentEnemyIndex;
    CGFloat directFori5;
}
@property (nonatomic,retain)NSArray *choosedEnemys;


@end
