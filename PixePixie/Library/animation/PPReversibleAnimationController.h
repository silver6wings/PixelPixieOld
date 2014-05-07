//
//  PPReversibleAnimationController.h
//  PixelPixie
//
//  Created by liuxiaoyu on 14-3-11.
//  Copyright (c) 2014年 Psyches. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 a base class for animationControllers which provide reversible animations.
 */

@interface PPReversibleAnimationController : NSObject<UIViewControllerAnimatedTransitioning>

/**
	The direction of the animation.
 */
@property (nonatomic, assign) BOOL reverse;
/**
	The animation duration.
 */
@property (nonatomic, assign) NSTimeInterval duration;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
				   fromVC:(UIViewController *)fromVC
					 toVC:(UIViewController *)toVC
				 fromView:(UIView *)fromView
				   toView:(UIView *)toView;

@end
