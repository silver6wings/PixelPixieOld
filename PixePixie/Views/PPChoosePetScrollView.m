//
//  PPChoosePetScrollView.m
//  PixelPixie
//
//  Created by xiefei on 7/10/14.
//  Copyright (c) 2014 Psyches. All rights reserved.
//

#import "PPChoosePetScrollView.h"
static NSString *typeString[]={
    @"金",
    @"木",
    @"水",
    @"火",
    @"土"
};
@implementation PPChoosePetScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setSCrollWith:(NSDictionary *)petsDict
{
    NSArray *petsInfoArray=[[NSArray alloc] initWithArray:[petsDict objectForKey:@"userpetinfo"]];
    NSArray * petsArray = [NSArray arrayWithArray:petsInfoArray];
    int petsCount = (int)[petsArray count];
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.contentSize=CGSizeMake(self.frame.size.width*petsCount, self.frame.size.height);
    

    for (int i=0; i<petsCount; i++) {
        UIImageView *petsImageView=[[UIImageView alloc] initWithFrame:CGRectMake(i*self.frame.size.width, 0.0f, 320.0f, self.frame.size.height)];
    
        [self addSubview:petsImageView];
        
        
        UIButton *petsNameBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [petsNameBtn setTitle:[[petsInfoArray objectAtIndex:i] objectForKey:@"petname"] forState:UIControlStateNormal];
        [petsNameBtn setBackgroundColor:[UIColor blueColor]];
        [petsNameBtn setFrame:CGRectMake(i*self.frame.size.width+100, 10.0f, 120.0f, 40)];
        [petsNameBtn addTarget:self action:@selector(petsNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:petsNameBtn];
        
        UILabel *labelPetType=[[UILabel alloc] initWithFrame:CGRectMake(petsNameBtn.frame.origin.x,petsNameBtn.frame.origin.y+50, 100, 100)];
        
        
        int typeInt =  [[[petsInfoArray objectAtIndex:i] objectForKey:@"petelementtype"] intValue];
        
        [labelPetType setText:typeString[typeInt-1]];
        [labelPetType setFont:[UIFont boldSystemFontOfSize:100]];
        [labelPetType setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:labelPetType];
    
        
        UIButton *petsTypeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        switch (i) {
            case 0:
            {
                [petsTypeBtn setImage:[UIImage imageNamed:@"fire.png"] forState:UIControlStateNormal];
                [petsTypeBtn setImage:[UIImage imageNamed:@"fire_selected.png"] forState:UIControlStateSelected];
                
                [petsImageView setBackgroundColor:[UIColor yellowColor]];
            }
                break;
            case 1:
            {
                [petsTypeBtn setImage:[UIImage imageNamed:@"soil.png"] forState:UIControlStateNormal];
                [petsTypeBtn setImage:[UIImage imageNamed:@"soil_selected.png"] forState:UIControlStateHighlighted];
                [petsImageView setBackgroundColor:[UIColor greenColor]];
                
            }
                break;
            case 2:
            {
                [petsTypeBtn setImage:[UIImage imageNamed:@"water.png"] forState:UIControlStateNormal];
                [petsTypeBtn setImage:[UIImage imageNamed:@"water_selected.png"] forState:UIControlStateHighlighted];
                [petsImageView setBackgroundColor:[UIColor greenColor]];
                [petsImageView setBackgroundColor:[UIColor grayColor]];
                
            }
                break;
            case 3:
            {
                
                [petsTypeBtn setImage:[UIImage imageNamed:@"fire.png"] forState:UIControlStateNormal];
                [petsTypeBtn setImage:[UIImage imageNamed:@"fire_selected.png"] forState:UIControlStateHighlighted];
                
                [petsImageView setBackgroundColor:[UIColor yellowColor]];
                [petsImageView setBackgroundColor:[UIColor purpleColor]];
                
            }
                break;
            case 4:
            {
                
                [petsTypeBtn setImage:[UIImage imageNamed:@"soil.png"] forState:UIControlStateNormal];
                [petsTypeBtn setImage:[UIImage imageNamed:@"soil_selected.png"] forState:UIControlStateHighlighted];
                [petsImageView setBackgroundColor:[UIColor greenColor]];
                [petsImageView setBackgroundColor:[UIColor redColor]];
                
            }
                break;
                
            default:
                break;
        }
        [petsTypeBtn setFrame:CGRectMake(petsNameBtn.frame.origin.x, petsNameBtn.frame.origin.y+200, 40.0f, 40)];
        [petsTypeBtn addTarget:self action:@selector(petsTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:petsTypeBtn];
        
        
    }
    
    
}
-(void)petsNameBtnClick:(UIButton *)sender
{
    
}
-(void)petsTypeBtnClick:(UIButton *)sender
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
