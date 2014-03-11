//
//  PPReversibleAnimationController.m
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-11.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import "PPReversibleAnimationController.h"

@implementation PPReversibleAnimationController

- (id)init {
	if (self = [super init]) {
		//config default duration.
		self.duration = 1.f;
	}
	return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
	return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIView *fromView = fromVC.view;
	UIView *toView = toVC.view;
	[self animateTransition:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
}
/**
 this method must be implementation by child class
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
				   fromVC:(UIViewController *)fromVC
					 toVC:(UIViewController *)toVC
				 fromView:(UIView *)fromView
				   toView:(UIView *)toView {
	
}


@end
