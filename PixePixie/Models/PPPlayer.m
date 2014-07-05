//
//  PPPlayer.m
//  PixelPixie
//
//  Created by silver6wings on 14-4-23.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPPlayer.h"

@implementation PPPlayer

-(void)filePathTest
{
    NSDictionary *dictPass =
    [NSDictionary dictionaryWithObjectsAndKeys:
     [NSArray arrayWithObjects:
      [NSDictionary dictionaryWithObjectsAndKeys:@"副本1",@"passname",@"1234",@"passid",@"2013/11/11 00:00",@"passtime",@"ball_pixie_plant2",@"passimage", nil],
      [NSDictionary dictionaryWithObjectsAndKeys:@"副本2",@"passname",@"1234",@"passid",@"2013/11/11 00:00",@"passtime",@"ball_pixie_plant2",@"passimage", nil],
      [NSDictionary dictionaryWithObjectsAndKeys:@"副本3",@"passname",@"1234",@"passid",@"2013/11/11 00:00",@"passtime",@"ball_pixie_plant2",@"passimage", nil],
      [NSDictionary dictionaryWithObjectsAndKeys:@"副本4",@"passname",@"1234",@"passid",@"2013/11/11 00:00",@"passtime",@"ball_pixie_plant2",@"passimage", nil],
      nil],
     @"transcriptinfo",
     
     @"精灵大战",
     @"transcriptname",
     nil];
    
    if ([dictPass writeToFile:[[self getPersonalSetTargetPath] stringByAppendingPathComponent:@"userinfo.plist"] atomically:YES]) {
        NSLog(@"sucess!");
    } else {
        NSLog(@"fail！");
    }
    NSLog(@"getPersonalSetTargetPath = %@",[self getPersonalSetTargetPath]);
}

// 得到应用程序Documents文件夹下的目标路径

-(NSString *)getPersonalSetTargetPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cahcesPlist = [paths objectAtIndex:0];
    
    return cahcesPlist;
}

@end
