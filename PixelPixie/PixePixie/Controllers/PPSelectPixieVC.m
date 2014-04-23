//
//  PPSelectPixieVC.m
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-8.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPSelectPixieVC.h"
#import "iCarousel.h"

@interface PPSelectPixieVC () <iCarouselDataSource, iCarouselDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *iCarousel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation PPSelectPixieVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.iCarousel.type = iCarouselTypeRotary;
}

#pragma iCarouselDelegate & DataSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
	return 5;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
	if (view == nil) {
		PPCoverflow *coverflow = [[PPCoverflow alloc] initWithFrame:CGRectInset(self.iCarousel.frame, 50, 20)];
		coverflow.backgroundColor = [UIColor yellowColor];
		view = coverflow;
	}
	return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
	self.textView.text = [NSString stringWithFormat:@"%d小精灵", (int)index];
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
	self.textView.text = [NSString stringWithFormat:@"%d小精灵", (int)carousel.currentItemIndex];
}

- (IBAction)confirmToHomeVC:(UIButton *)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kPPHomeVCWillMoveToParentVC object:nil];
}

- (void)dealloc {
	_iCarousel.delegate = nil;
	_iCarousel.dataSource = nil;
	NSLog(@"dealloc PixieVC");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
