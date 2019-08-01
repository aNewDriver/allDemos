//
//  MainVC.m
//  animationTestDemo
//
//  Created by Ke Wang on 2019/5/9.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "MainVC.h"
#import "CAPropertyAnimationVC.h"
#import "CASpringAnimationVC.h"
#import "CATransitionVC.h" 

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllers = @[[self addViewControllerWithClass:NSClassFromString(@"CAPropertyAnimationVC")],
                             [self addViewControllerWithClass:NSClassFromString(@"CASpringAnimationVC")],
                             [self addViewControllerWithClass:NSClassFromString(@"CATransitionVC")]];
    
    // Do any additional setup after loading the view.
}

- (UINavigationController *)addViewControllerWithClass:(Class)vcClass {
    UIViewController *vc = (UIViewController *)[[vcClass alloc] init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        [self addChildViewController:vc];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.title = NSStringFromClass(vcClass);
        
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSStringFromClass(vcClass) image:[UIImage imageNamed:@"project"] selectedImage:[UIImage imageNamed:@"projectSelected"]];
        //    UIFont *Font = SYSTEM_NORMAL_NAME_FONT(SpicalTextName, 10.0f);
        //    NSArray *array =  [UIFont familyNames];
        [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0,-3)];
        return nav;
    }
    return nil;
}

@end
