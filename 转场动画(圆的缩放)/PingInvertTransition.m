//
//  PingInvertTransition.m
//  KYPingTransition
//
//  Created by Kitten Yang on 1/30/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "PingInvertTransition.h"
#import "ViewController.h"
#import "NextVC.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


//pop动画

@interface PingInvertTransition()<CAAnimationDelegate>
@property(nonatomic,strong)id<UIViewControllerContextTransitioning>transitionContext;
@end

@implementation PingInvertTransition


//转场动画持续时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.618f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    
    self.transitionContext = transitionContext;
    
    NextVC *fromVC = (NextVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC   = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    UIView *containerView = [transitionContext containerView];
//    UIButton *button = toVC.pushBtn;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(WIDTH-60, 20, 40, 40)];
    
    CGFloat radius = sqrt(WIDTH * WIDTH + HEIGHT * HEIGHT);
    NSLog(@"pop中的radius:%f",radius);
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMake(WIDTH-60, 20, 40, 40), -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = finalPath.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    
    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pingAnimation.fromValue = (__bridge id)(startPath.CGPath);
    pingAnimation.toValue = (__bridge id)(finalPath.CGPath);
    pingAnimation.duration = [self transitionDuration:transitionContext];
    pingAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAAnimationLinear];

    pingAnimation.delegate = self;
    
    [maskLayer addAnimation:pingAnimation forKey:@"pingInvert"];
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;

}


@end





