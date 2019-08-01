//
//  Header.h
//  WKCrashShelterDemo
//
//  Created by Ke Wang on 2019/7/25.
//  Copyright © 2019 Ke Wang. All rights reserved.
//

#ifndef Header_h
#define Header_h



#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <pthread.h>
#import <objc/runtime.h>
#import "WKCrashShelterRoute.h"

//!< logLogo
static NSString const *WKCrashShelterLogLogo = @"========================WKCrashShelter Log==========================";

//!< logSeparator
static NSString const *WKCrashShelterLogSeparator = @"================================================================";

static NSString *WKCrashShelterDefaultDeal = @"WKCrashShelterDefaultDeal";

//!< 默认处理__returnNil
static NSString *WKCrashShelterDefaultDeal_returnNil = @"WKCrashShelter has return nil to prevent crash";

//!< 默认处理__忽视当前操作
static NSString *WKCrashShelterDefaultDeal_ignoreOperation = @"WKCrashShelter has ignore this operation to prevent crash";


#ifdef DEBUG
#define  WKCrashShelterLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])
#else
#define WKCrashShelterLog(...)
#endif




#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


#pragma mark - inlineMethod

#define necessary_inline __inline__ __attribute__((always_inline))
/**
 当前线程是否为主线程
 
 @return bool
 */
static inline bool dispath_is_mainQueue() {
    return pthread_main_np() != 0;
}

/**
 安全主线程
 @param block 回调
 */
static inline void dispatch_async_safe_mainQueue(void(^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

static inline void dispatch_sync_safe_mainQueue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}


/**
 类方法交换
 
 @param class 目标类
 @param originalMethodSel 原始方法sel
 @param targetMethodSel 目标方法sel
 */
static inline void WKCrashShelterExchangeClassMethod(Class class, SEL originalMethodSel, SEL targetMethodSel) {
    Method originalMethod = class_getClassMethod(class, originalMethodSel);
    Method targetMethod = class_getClassMethod(class, targetMethodSel);
    method_exchangeImplementations(originalMethod, targetMethod);
}

/**
 实例方法交换
 
 @param class 目标类
 @param originalMethodSel 原始方法sel
 @param targetMethodSel 目标方法sel
 */
static inline void WKCrashShelterExchangeInstanceMethod(Class class, SEL originalMethodSel, SEL targetMethodSel) {
    
    Method originalMethod = class_getInstanceMethod(class, originalMethodSel);
    Method targetMethod = class_getInstanceMethod(class, targetMethodSel);
    BOOL needAddMethod = class_addMethod(class, originalMethodSel, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod));
    if (needAddMethod) {
        class_replaceMethod(class, targetMethodSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, targetMethod);
    }
}


/**
 收集错误信息, 打印并处理错误
 
 @param exception 异常
 @param defaultDeal 默认h处理
 */

static inline void WKCrashShelterCollectErrorException(NSException *exception, NSString *defaultDeal) {
    
    NSArray <NSString *>*callStackSymbolsArray = [NSThread callStackSymbols];
    NSString *stackInfoMessage = [WKCrashShelterRoute collectStackSymbolsWithCallStackSymbolsArray:callStackSymbolsArray];
    if (!stackInfoMessage) {
        stackInfoMessage = @"未能准确定位到Crash位置, 请查看函数调用栈排查!";
    }
    NSString *errorName = exception.name;
    NSString *reason = exception.reason;
    NSString *crashPlace = [NSString stringWithFormat:@"Crash Place:%@",stackInfoMessage];
    NSString *errorMsg = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@",WKCrashShelterLogLogo, errorName, reason, crashPlace, defaultDeal];
    errorMsg = [NSString stringWithFormat:@"%@\n\n%@\n\n",errorMsg,WKCrashShelterLogSeparator];
    WKCrashShelterLog(@"%@", errorMsg);
}










#endif /* Header_h */
