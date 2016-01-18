//
//  CustomPresentAnimationCotroller.m
//  ZFJianShuTransition
//
//  Created by macOne on 16/1/5.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "CustomPresentAnimationCotroller.h"

@interface CustomPresentAnimationCotroller ()

@property (nonatomic,strong) UIViewController *toVC;
@end

@implementation CustomPresentAnimationCotroller

//转场动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = _toVC.view;
    UIView *fromView = fromVC.view;
    
    if(self.isDismissed){
        [self RunDismissAnimation:transitionContext fromVC:fromVC toVC:_toVC fromView:fromView toView:toView];
    } else {
        [self RunPresentAnimation:transitionContext fromVC:fromVC toVC:_toVC fromView:fromView toView:toView];
    }
    
    [_toVC beginAppearanceTransition:YES animated:YES];
}

#pragma mark - presentAnimation

-(void)RunPresentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    /*
     fromVC UINavigationController 的根视图控制器---->ViewController
     toVC --->SecondViewController
     */
    UIView* containerView = [transitionContext containerView];
    //获取fromVC（ViewController）的frame
    CGRect frame = [transitionContext initialFrameForViewController:fromVC];
    //底部滑进 离屏滑入 即y坐标 从height --->0
    CGRect offScreenFrame = frame;
    offScreenFrame.origin.y = offScreenFrame.size.height;
    toView.frame = offScreenFrame;

    [containerView insertSubview:toView aboveSubview:fromView];
    
    //三维变化
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-1000;
    //x y方向各缩放比例为0.95
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    //x方向旋转15°
    t1 = CATransform3DRotate(t1, 15.0f * M_PI/180.0f, 1, 0, 0);
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = 1.0/-1000;
    //沿Y方向向上移动
    t2 = CATransform3DTranslate(t2, 0, -fromView.frame.size.height*0.08, 0);
    //在x y方向各缩放比例为0.8
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    
    //UIView关键帧动画 总的持续时间：1.0
    [UIView animateKeyframesWithDuration:1.0 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        //开始时间：1.0*0.0 持续时间：1.0*0.4
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.4f animations:^{
            //执行t1动画 缩放并旋转角度
            fromView.layer.transform = t1;
            //fromView的透明度
            fromView.alpha = 0.6;
        }];
        //开始时间：1.0*0.1 持续时间：1.0*0.5
        [UIView addKeyframeWithRelativeStartTime:0.1f relativeDuration:0.5f animations:^{
            //执行t2动画 向上平移和缩放
            fromView.layer.transform = t2;
        }];
        //开始时间：1.0*0.0 持续时间：1.0*1.0
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:1.0f animations:^{
            //toView向上滑入
            toView.frame = frame;
        }];
        
    } completion:^(BOOL finished) {
        //过渡动画结束
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

    }];
 
    
}
#pragma mark - dismissAnimation
-(void)RunDismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    

    CGRect frame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame = frame;
    
    CGRect frameOffScreen = frame;
    frameOffScreen.origin.y = frame.size.height;
    
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-1000;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 15.0f * M_PI/180.0f, 1, 0, 0);
    
    //关键帧过渡动画
    [UIView animateKeyframesWithDuration:1.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:1.0f animations:^{
            fromView.frame = frameOffScreen;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.35f relativeDuration:0.35f animations:^{
            toView.layer.transform = t1;
            //透明度为1.0
            toView.alpha = 1.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75f relativeDuration:0.25f animations:^{
            //还原3D状态
            toView.layer.transform = CATransform3DIdentity;
        }];
    } completion:^(BOOL finished) {

        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];


}

-(void)animationEnded:(BOOL)transitionCompleted{
    if (!transitionCompleted) {
        _toVC.view.transform = CGAffineTransformIdentity;
    }
    else{
        [_toVC endAppearanceTransition];
    }
}

@end
