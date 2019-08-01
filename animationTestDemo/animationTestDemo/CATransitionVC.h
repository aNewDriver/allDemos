//
//  CATransitionVC.h
//  animationTestDemo
//
//  Created by Ke Wang on 2019/5/9.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

//!< u多元化转场动画 

#import <UIKit/UIKit.h>

@class WKCustomCell;

NS_ASSUME_NONNULL_BEGIN

@interface CATransitionVC : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGRect finiRect;


- (WKCustomCell *)getCellWithIndexPath:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
