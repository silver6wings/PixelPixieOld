//
//  PPPassNumberScroll.m
//  PixelPixie
//
//  Created by xiefei on 6/3/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPPassNumberScroll.h"
#import "PPCustomButton.h"
@implementation PPPassNumberScroll

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatPassNumberScroll:@{@"a":@"b",@"a":@"b",@"a":@"b",@"a":@"b",@"a":@"b"}];
        // Initialization code
    }
    return self;
}
-(void)creatPassNumberScroll:(NSDictionary *)passInfo
{
    UIScrollView *scrollContent=[[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    scrollContent.contentSize=CGSizeMake(self.frame.size.width*[passInfo count], self.frame.size.height);
    [self addSubview:scrollContent];
    for (int i=0; i<[[passInfo allKeys] count]; i++) {
        UIButton  *passBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [passBtn setFrame:CGRectMake(i*self.frame.size.width,0.0f, 64.0f, 64.0f)];
        passBtn.tag=PP_PASSNUM_CHOOSE_TABLE_TAG+i;
        
        [passBtn addTarget:self action:@selector(passBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [passBtn setTitle:[NSString stringWithFormat:@"副本00%d",i] forState:UIControlStateNormal];
        [scrollContent addSubview:passBtn];
    }
    
    
}
-(void)passBtnClick:(PPCustomButton *)sender
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
