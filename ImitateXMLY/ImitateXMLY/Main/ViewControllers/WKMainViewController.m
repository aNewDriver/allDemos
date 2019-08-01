//
//  WKMainViewController.m
//  ImitateXMLY
//
//  Created by Ke Wang on 2019/3/5.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKMainViewController.h"
#import "HomeViewController.h"
#import "IListenViewController.h"
#import "PlayViewController.h"
#import "DiscoveryViewController.h"
#import "SelfViewController.h"


@interface WKMainViewController ()

@end

@implementation WKMainViewController {
    NSMutableArray *_subVCs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _subVCs = @[].mutableCopy;
    [self addSubVC:@"HomeViewController" title:@"首页" imageName:@"" selectedImageName:@"" hiddenNAV:YES];
    [self addSubVC:@"IListenViewController" title:@"我听" imageName:@"" selectedImageName:@"" hiddenNAV:NO];
    [self addSubVC:@"PlayViewController" title:@"" imageName:@"" selectedImageName:@"" hiddenNAV:NO];
    [self addSubVC:@"DiscoveryViewController" title:@"发现" imageName:@"" selectedImageName:@"" hiddenNAV:NO];
    [self addSubVC:@"SelfViewController" title:@"我的" imageName:@"" selectedImageName:@"" hiddenNAV:YES];
    self.viewControllers = _subVCs;
}

- (void)addSubVC:(NSString *)className
           title:(NSString *)title
       imageName:(NSString *)imageNage
selectedImageName:(NSString *)selectedImageName
       hiddenNAV:(BOOL)hiddenNAV
{
    //!< homeVC
    
    UIViewController *homeVC = [[NSClassFromString(className) alloc] init];
    homeVC.view.backgroundColor = BACKGROUND_COLOR;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imageNage] selectedImage:[UIImage imageNamed:selectedImageName]];
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SYSTEM_SCALE_FONT(10.0f), NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SYSTEM_SCALE_FONT(10.0f),NSForegroundColorAttributeName : RGBCOLOR(74, 143, 255)} forState:UIControlStateHighlighted];
    [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0,-3)];
    if (hiddenNAV) {
        nav.navigationBar.hidden = YES;
    }
    
    [_subVCs addObject:nav];
    
}

@end
