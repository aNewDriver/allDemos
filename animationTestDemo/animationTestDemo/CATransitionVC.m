//
//  CATransitionVC.m
//  animationTestDemo
//
//  Created by Ke Wang on 2019/5/9.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "CATransitionVC.h"
#import "WKTransitonAnimationsVC.h"
#import "WKTransitionAnimationTool.h"
#import "WKCustomCell.h"
#import "WKPushAnimation.h"

@interface CATransitionVC ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@property (nonatomic, copy) NSArray *dataSource;
@end

@implementation CATransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSource = @[@"cube", @"suckEffect", @"rippleEffect", @"pageCurl", @"pageUnCurl", @"oglFlip", @"cameraIrisHollowOpen", @"cameraIrisHollowClose"];
    [self.view addSubview:self.tableView];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _dataSource.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cusCell"];
        if (!cell) {
            cell = [[WKCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cusCell"];
        }
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _dataSource.count) {
        return 100.f;
    }
    return 60.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WKTransitonAnimationsVC *vc = [[WKTransitonAnimationsVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.row == _dataSource.count) {
        self.navigationController.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        self.navigationController.delegate = nil;
        NSString *str = _dataSource[indexPath.row];
        CATransition *animation = [WKTransitionAnimationTool defaultAnimationWithType:str target:self];
        [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
        [self.navigationController pushViewController:vc animated:NO];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [[WKPushAnimation alloc] init];
    }
    return nil;
}

- (WKCustomCell *)getCellWithIndexPath:(NSIndexPath *)indexPath {
    return [_tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - get

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.frame;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
