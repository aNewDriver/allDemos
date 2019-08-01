//
//  UIImage+WKCorners.m
//  JSOCInteraction
//
//  Created by Ke Wang on 2019/4/25.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "UIImage+WKCorners.h"

@implementation UIImage (WKCorners)

- (UIImage *)setupAllCornersToRoundedCornersWithCornersRadius:(CGFloat)cornersRadius {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, cornersRadius, cornersRadius);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [self drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return newImage;
}

- (UIImage *)setupAllCornersToRoundedCornersUseBezierPathWithCornersRadius:(CGFloat)cornersRadius {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGRect rect = CGRectMake(0, 0, cornersRadius, cornersRadius);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornersRadius] addClip];
    [self drawInRect:rect];
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return newImage;
}


@end
