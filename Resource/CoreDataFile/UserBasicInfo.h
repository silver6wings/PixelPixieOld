//
//  UserBasicInfo.h
//  PixelPixie
//
//  Created by xiefei on 14/11/5.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserBasicInfo : NSManagedObject

@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * useraccount;
@property (nonatomic, retain) NSString * userpassword;

@end
