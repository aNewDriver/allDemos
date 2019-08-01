//
//  WKCrashShelterRoute.h
//  WKCrashShelterDemo
//
//  Created by Ke Wang on 2019/7/24.
//  Copyright © 2019 Ke Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


NS_ASSUME_NONNULL_BEGIN

@interface WKCrashShelterRoute : NSObject



/**
 从堆栈信息中匹配出崩溃信息
 
 @param callStackSymbolsArray 堆栈崩溃信息集合
 @return 崩溃信息
 */
+ (NSString *)collectStackSymbolsWithCallStackSymbolsArray:(NSArray <NSString *> *)callStackSymbolsArray;


@end

NS_ASSUME_NONNULL_END
