//
//  UIView+WKFillet.h
//  JSOCInteraction
//
//  Created by Ke Wang on 2019/4/25.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

//!< 可控的为view添加N个圆角

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WKFillet)

//!< 为view的每一个角都添加圆角
- (void)setupAllCornersToRoundedCornersWithCornersRadius:(CGFloat)cornersRadius;

//!< 为view的某几个角添加圆角
- (void)setupCornersToRoundedCornersWithCornersRadius:(CGFloat)cornersRadius roundingCorners:(UIRectCorner)roundingCorners;

@end

NS_ASSUME_NONNULL_END
