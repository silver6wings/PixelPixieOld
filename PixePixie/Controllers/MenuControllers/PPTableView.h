//
//  PPTableView.h
//  PixelPixie
//
//  Created by xiefei on 14-4-2.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPTableView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    @public
    id choosePassNumber;
    SEL choosePassNumberSel;
}
-(void)ppsetTableViewWithData:(NSArray *)array;
@end
