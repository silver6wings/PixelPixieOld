//
//  PPSkillInfo.h
//  PixelPixie
//
//  Created by xiefei on 6/9/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPSkillInfo : NSObject
@property (nonatomic,retain)NSString *skillName;
@property (nonatomic,retain)NSMutableArray *animateTextures;
@property (nonatomic,assign)CGFloat HPChangeValue;

@end
