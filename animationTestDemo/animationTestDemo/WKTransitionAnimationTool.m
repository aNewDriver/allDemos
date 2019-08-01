//
//  WKTransitionAnimationTool.m
//  animationTestDemo
//
//  Created by Ke Wang on 2019/5/10.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKTransitionAnimationTool.h"

@implementation WKTransitionAnimationTool

+ (CATransition *)defaultAnimationWithType:(NSString *)type target:(id)target {
    
   return [self animationWithType:type
                    subtype:kCATransitionFromRight
                    duraion:1.f
                     target:target
             timingFunction:kCAMediaTimingFunctionLinear];
    
}

+ (CATransition *)animationWithType:(NSString *)type
                  subtype:(NSString *)subtype
                  duraion:(NSTimeInterval)duraion
                   target:(id)target
           timingFunction:(NSString *)timingFunction {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duraion;
    animation.delegate = target;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    animation.type = type;
    animation.subtype = subtype;
    
    return animation;
}

@end
