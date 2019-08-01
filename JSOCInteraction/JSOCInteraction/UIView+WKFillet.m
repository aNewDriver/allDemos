//
//  UIView+WKFillet.m
//  JSOCInteraction
//
//  Created by Ke Wang on 2019/4/25.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "UIView+WKFillet.h"

@implementation UIView (WKFillet)


- (void)setupAllCornersToRoundedCornersWithCornersRadius:(CGFloat)cornersRadius {
    
    [self setupCornerToRoundedCornerWithRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornersRadius, cornersRadius)];
}


- (void)setupCornersToRoundedCornersWithCornersRadius:(CGFloat)cornersRadius roundingCorners:(UIRectCorner)roundingCorners{
    [self setupCornerToRoundedCornerWithRoundingCorners:roundingCorners cornerRadii:CGSizeMake(cornersRadius, cornersRadius)];
}




- (void)setupCornerToRoundedCornerWithRoundingCorners:(UIRectCorner)byRoundingCorners cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:byRoundingCorners
                                                         cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}



@end
