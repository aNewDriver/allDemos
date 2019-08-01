//
//  WKTransitionAnimationTool.h
//  animationTestDemo
//
//  Created by Ke Wang on 2019/5/10.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKTransitionAnimationTool : NSObject

+ (CATransition *)animationWithType:(NSString *)type
                            subtype:(NSString *)subtype
                            duraion:(NSTimeInterval)duraion
                             target:(id)target
                     timingFunction:(NSString *)timingFunction;

+ (CATransition *)defaultAnimationWithType:(NSString *)type
                                    target:(id)target;


@end

NS_ASSUME_NONNULL_END
