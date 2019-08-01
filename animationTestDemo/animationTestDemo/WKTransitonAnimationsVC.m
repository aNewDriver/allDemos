//
//  WKTransitonAnimationsVC.m
//  animationTestDemo
//
//  Created by Ke Wang on 2019/5/10.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKTransitonAnimationsVC.h"

@interface WKTransitonAnimationsVC ()


@end

@implementation WKTransitonAnimationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    self.imageV = [[UIView alloc] initWithFrame:CGRectMake(150, 100, 100, 100)];
    self.imageV.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.imageV];
}


@end
