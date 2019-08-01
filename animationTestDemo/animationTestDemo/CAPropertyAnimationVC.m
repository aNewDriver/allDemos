//
//  CAPropertyAnimationVC.m
//  animationTestDemo
//
//  Created by Ke Wang on 2019/5/9.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "CAPropertyAnimationVC.h"
#import "WKPushAnimation.h"
#import "CABasicAnimationVC.h"

@interface CAPropertyAnimationVC ()<UINavigationControllerDelegate, CAAnimationDelegate>

@end

@implementation CAPropertyAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addButtonsWithSpace:0 title:@"CABasicAnimationVC" tag:1000];
    [self addButtonsWithSpace:60 title:@"CAKeyFrameAnimationVC" tag:1001];
    // Do any additional setup after loading the view.
}


- (void)addButtonsWithSpace:(CGFloat)space title:(NSString *)title tag:(NSUInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100 + 50 + space, 200, 50);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    [self.view addSubview:button];
    
}

- (void)btnClick:(UIButton *)sender {
    
    if (sender.tag == 1000) {
        CABasicAnimationVC * vc = [[CABasicAnimationVC alloc] init];
        CATransition *animation = [CATransition animation];
        animation.duration = 1.f;
        animation.delegate = self;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.type = @"cameraIrisHollowClose";
        animation.subtype = kCATransitionFromRight;
        [self.navigationController.view.layer addAnimation:animation forKey:@"pushAnimation"];
        [self.navigationController pushViewController:vc animated:NO];
    } else {
        
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [[WKPushAnimation alloc] init];
    }
    return nil;
}


@end
