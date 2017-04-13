//
//  PingTransition.m
//  KYPingTransition
//
//  Created by Kitten Yang on 1/30/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "PingTransition.h"
#import "ViewController.h"
#import "NextVC.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PingTransition ()<CAAnimationDelegate>
@property(nonatomic,strong)id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation PingTransition
//动画持续时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return  0.618f;
}

//动画的实现过程
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;

    ViewController * fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NextVC *toVC = (NextVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //获取到发生动画的View
    UIView *contView = [transitionContext containerView];
    //视图加入顺序要注意
    [contView addSubview:fromVC.view];
    [contView addSubview:toVC.view];
    
    //注意贝塞尔的开始 和 结束顺序
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(WIDTH-60, 20, 40, 40)];

    CGFloat radius = sqrt(WIDTH * WIDTH + HEIGHT * HEIGHT);
//    NSLog(@"push中的radius:%f",radius);
    //CGRectInset 以原rect为中心，再参考dx，dy，进行缩小或者放大。如果dx和dy是正值，则该矩形的尺寸减小。如果dx和dy是负值，矩形的尺寸增大。
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMake(WIDTH-60, 20, 40, 40), -radius, -radius)];
        
    //创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    maskLayer.path = maskFinalBP.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(maskFinalBP.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAAnimationLinear];
    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    

    
    

/*  POP的弹框效果 CGPathRef
 
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyFrame.values = @[(__bridge id)(maskStartBP.CGPath),(__bridge id)(maskFinalBP.CGPath)];
    keyFrame.duration = 100.0f;
    keyFrame.additive = YES;
    keyFrame.removedOnCompletion = NO;
    keyFrame.fillMode = kCAFillModeForwards;
    
    
    [maskLayer addAnimation:keyFrame forKey:nil];
    maskLayer.speed = 0.0;
    
    
    POPAnimatableProperty* pop = [POPAnimatableProperty propertyWithName:@"timeOffset" initializer:^(POPMutableAnimatableProperty *prop) {
        // read value
        prop.readBlock = ^(CAShapeLayer *obj, CGFloat values[]) {
            values[0] = obj.timeOffset;
        };
        // write value
        prop.writeBlock = ^(CAShapeLayer *obj, const CGFloat values[]) {
            obj.timeOffset = values[0];
        };
        // dynamics threshold
        prop.threshold = 0.1;
    }];
    
    
    POPSpringAnimation *popSpring = [POPSpringAnimation animation];
    popSpring.fromValue = @(0.0);
    popSpring.toValue =  @(100.f);
    popSpring.springBounciness = 1.0;//弹性
    popSpring.springSpeed = 20.0;//速度
    popSpring.dynamicsTension = 700;//张力
    popSpring.dynamicsFriction = 5; // 摩擦力
    popSpring.dynamicsMass = 1;
    popSpring.property = pop;
    popSpring.delegate = self;
    [maskLayer pop_addAnimation:popSpring forKey:nil];
    
  */
  
//    kPOPShapeLayerStrokeStart
    
    //创建一个关于 path 的 CABasicAnimation 动画来从 circleMaskPathInitial.CGPath 到 circleMaskPathFinal.CGPath 。同时指定它的 delegate 来在完成动画时做一些清除工作
    
}

#pragma mark - CABasicAnimation的Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //告诉 iOS 这个 transition 完成
    [self.transitionContext completeTransition:![self. transitionContext transitionWasCancelled]];
    
    //清除 fromVC 的 mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;

}



@end





