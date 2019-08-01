//
//  ViewController.m
//  OpenGL ES Demo
//
//  Created by Ke Wang on 2019/3/20.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>
#import "WKGLKitRenderVC.h"
#import "WKGLSLRenderVC.h"
#import "WKChainCalculatorManager.h"
#import "WKChainCalculatorMaker.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *GLKitViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    GLKitViewButton.frame = CGRectMake(100, 100, 200, 50);
    [GLKitViewButton setTitle:@"GLKViewRender" forState:UIControlStateNormal];
    [GLKitViewButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [GLKitViewButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:GLKitViewButton];
    
    
    UIButton *GLSLButton = [UIButton buttonWithType:UIButtonTypeCustom];
    GLSLButton.frame = CGRectMake(100, 300, 200, 50);
    [GLSLButton setTitle:@"GLSLRender" forState:UIControlStateNormal];
    [GLSLButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [GLSLButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [GLSLButton setTag:10000];
    [self.view addSubview:GLSLButton];
}
- (void)btnClick:(UIButton *)sender {
    
    if (sender.tag == 10000) {
        [self.navigationController pushViewController:[[WKGLSLRenderVC alloc] init]
                                             animated:YES];
    } else
    
    [self.navigationController pushViewController:[[WKGLKitRenderVC alloc] init]
                                         animated:YES];
   float result = [WKChainCalculatorManager makeCalculator:^(WKChainCalculatorMaker * _Nonnull make) {
        make.sub(1).add(10).multiply(2).divide(5);
    }];
    
    NSLog(@"%.2f", result);
//    WKChainCalculatorMaker *make = [WKChainCalculatorMaker new].sub(1).add(1).add(1);
    
   
}




@end
