//
//  WKCrashShelterRoute.m
//  WKCrashShelterDemo
//
//  Created by Ke Wang on 2019/7/24.
//  Copyright © 2019 Ke Wang. All rights reserved.
//


#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


#import "WKCrashShelterRoute.h"


@implementation WKCrashShelterRoute


+ (void)openShelter {
    
}





/**
 从堆栈信息中匹配出崩溃信息

 @param callStackSymbolsArray 堆栈崩溃信息集合
 @return 崩溃信息
 */
+ (NSString *)collectStackSymbolsWithCallStackSymbolsArray:(NSArray <NSString *> *)callStackSymbolsArray {
    __block NSString *resultMessage = nil;
    
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    for (NSUInteger i = 2; i < [callStackSymbolsArray count]; i++) {
        
        NSString *string = callStackSymbolsArray[i];
        
        [regularExp enumerateMatchesInString:string
                                     options:NSMatchingReportProgress
                                       range:NSMakeRange(0, string.length)
                                  usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                                      
                                      if (result) {
                                          // !< 根据result来获取结果
                                          NSString *str1 = [string substringWithRange:result.range];
                                          NSString *className = [str1 componentsSeparatedByString:@" "].firstObject;
                                          className = [className componentsSeparatedByString:@"["].lastObject;
                                          NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                                          if (![className hasPrefix:@")"] && bundle == [NSBundle mainBundle]) {
                                              resultMessage = str1;
                                          }
                                          *stop = YES;
                                      }
            
                                  }];
        
        if (resultMessage != nil) {
            break;
        }
    }
    
    return resultMessage;
}


@end
