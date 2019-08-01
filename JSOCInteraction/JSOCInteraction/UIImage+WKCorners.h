//
//  UIImage+WKCorners.h
//  JSOCInteraction
//
//  Created by Ke Wang on 2019/4/25.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WKCorners)

//!< 设置圆角
- (UIImage *)setupAllCornersToRoundedCornersWithCornersRadius:(CGFloat)cornersRadius;

//!< 用bezierPath来设置圆角
- (UIImage *)setupAllCornersToRoundedCornersUseBezierPathWithCornersRadius:(CGFloat)cornersRadius;



@end

NS_ASSUME_NONNULL_END
