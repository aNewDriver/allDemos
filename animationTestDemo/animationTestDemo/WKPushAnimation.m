//
//  WKPushAnimation.m
//  animationTestDemo
//
//  Created by Ke Wang on 2019/5/9.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKPushAnimation.h"
#import "CATransitionVC.h"
#import "WKCustomCell.h"
#import "WKTransitonAnimationsVC.h"

@implementation WKPushAnimation

//!< 控制时间
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CATransitionVC *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    WKTransitonAnimationsVC *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = nil;
    UIView *fromView = nil;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromVC.view;
        toView = toVC.view;
    }
    
    //!< 获取截图  用来做动画
    NSIndexPath *indexP = [fromVC.tableView indexPathForSelectedRow];
    WKCustomCell *cell = [fromVC getCellWithIndexPath:indexP];
    UIView *screenShot = [cell.imageV snapshotViewAfterScreenUpdates:NO];
    screenShot.backgroundColor = [UIColor clearColor];
    screenShot.frame = fromVC.finiRect = [[transitionContext containerView] convertRect:cell.imageV.frame fromView:cell.imageV.superview];
    cell.imageV.hidden = YES;
    
    //!< 设置目标vc的frame
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0.5f;
    toVC.imageV.hidden = YES;
    
    //!< 添加视图
    [[transitionContext containerView] addSubview:toVC.view];
    [[transitionContext containerView] addSubview:screenShot];
     
     [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
         [[transitionContext containerView] layoutIfNeeded];
         fromVC.view.alpha = 1.0f;
         screenShot.frame = [[transitionContext containerView] convertRect:toVC.imageV.frame toView:toVC.imageV.superview];
    } completion:^(BOOL finished) {
        
        toVC.imageV.hidden = NO;
        cell.imageV.hidden = NO;
        [screenShot removeFromSuperview];
        toVC.view.alpha = 1;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}




@end
