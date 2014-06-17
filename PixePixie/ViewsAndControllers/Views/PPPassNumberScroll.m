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
@synthesize scene;
@synthesize view;
@synthesize target;
@synthesize selector;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        // Initialization code
    }
    return self;
}
-(void)creatPassNumberScroll:(NSDictionary *)passInfo with:(SKScene *)sceneTmp
{
    self.scene=sceneTmp;
    NSArray *passArray=[NSArray arrayWithArray:[passInfo objectForKey:@"transcriptinfo"]];
    NSInteger passCount=[passArray count];
    
    
    UIScrollView *scrollContent=[[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    NSLog(@"count=%ld",(long)passCount);
    
    scrollContent.showsHorizontalScrollIndicator=NO;
    
    scrollContent.contentSize=CGSizeMake(self.frame.size.width*passCount, self.frame.size.height);
    scrollContent.contentOffset=CGPointMake(0.0, 0.0);
    scrollContent.pagingEnabled=YES;
    [self addSubview:scrollContent];
    
    
    for (NSInteger i=0; i<passCount; i++) {
        
        UIButton  *passBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [passBtn setFrame:CGRectMake(i*self.frame.size.width,0.0f, 64.0f, 64.0f)];
        passBtn.tag=PP_PASSNUM_CHOOSE_TABLE_TAG+i;
        [passBtn setBackgroundColor:[UIColor blueColor]];
        [passBtn addTarget:self action:@selector(passBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [passBtn setTitle:[[passArray objectAtIndex:i] objectForKey:@"passname"] forState:UIControlStateNormal];
        [scrollContent addSubview:passBtn];
        
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(passBtn.frame.origin.x+passBtn.frame.size.width+50, passBtn.frame.origin.y, 120.0f, 120.0f)];
        [imageView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[[passArray objectAtIndex:i] objectForKey:@"passimage"] ofType:@"png"]]];
        [imageView setBackgroundColor:[UIColor greenColor]];
        [scrollContent addSubview:imageView];
        
        UILabel *labelPassText=[[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height, 220.0f, 60.0f)];
        [labelPassText setFont:[UIFont boldSystemFontOfSize:15]];
        [labelPassText setTextColor:[UIColor whiteColor]];
        [labelPassText setText:[[passArray objectAtIndex:i] objectForKey:@"passtime"]];
        [scrollContent addSubview:labelPassText];
        
        
    }
    
    [self addSubview:self.view];

}
-(SKScene *)scene {
    if (!scene) scene = [[SKScene alloc]init];
    return scene;
}

-(void)passBtnClick:(UIButton *)sender
{
    if (self.target!=nil&&self.selector!=nil&&[self.target respondsToSelector:self.selector]) {
        [self.target performSelectorInBackground:self.selector withObject:[NSNumber numberWithInt:(int)sender.tag]];

    }
    [self setHidden:YES];
    [self removeFromSuperview];
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
