//
//  NSArray+CrashShelter.m
//  WKCrashShelterDemo
//
//  Created by Ke Wang on 2019/7/24.
//  Copyright © 2019 Ke Wang. All rights reserved.
//

#import "NSArray+CrashShelter.h"
#import "WKDefines.h"
#import "WKCrashShelterRoute.h"


@implementation NSArray (CrashShelter)

+ (void)exchangeNeedShelterMethods {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //!< class Method: ⬇️
        
        //!< arrayWithObjects:count:
        WKCrashShelterExchangeClassMethod([self class], @selector(arrayWithObjects:count:), @selector(WKCrashShelterArrayWithObjects:count:));
        
        Class swizzle__NSArrayI = NSClassFromString(@"__NSArrayI");
        Class swizzle__NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        Class swizzle__NSArray0 = NSClassFromString(@"__NSArray0");
        Class swizzle__NSArray = NSClassFromString(@"NSArray");
        
        
        
        //!< instance Method: ⬇️
        
        //!< objectAtIndex:
        WKCrashShelterExchangeInstanceMethod(swizzle__NSArrayI, @selector(objectAtIndex:), @selector(__NSArrayIWKCrashShelterObjectAtIndex:));
        
        WKCrashShelterExchangeInstanceMethod(swizzle__NSSingleObjectArrayI, @selector(objectAtIndex:), @selector(__NSSingleObjectArrayIWKCrashShelterObjectAtIndex:));
        
        
        WKCrashShelterExchangeInstanceMethod(swizzle__NSArray0, @selector(objectAtIndex:), @selector(__NSArray0WKCrashShelterObjectAtIndex:));
        
        
        //!< objectsAtIndexes:
        WKCrashShelterExchangeInstanceMethod(swizzle__NSArray, @selector(objectsAtIndexes:), @selector(WKCrashShelterObjectsAtIndexes:));
        
        //!< getObjects:ranges:
        WKCrashShelterExchangeInstanceMethod(swizzle__NSArrayI, @selector(getObjects:range:), @selector(__NSArrayIWKCrashShelterGetObjects:range:));
        
        WKCrashShelterExchangeInstanceMethod(swizzle__NSSingleObjectArrayI, @selector(getObjects:range:), @selector(__NSSingleObjectArrayIWKCrashShelterGetObjects:range:));
        
    });
}


#pragma mark - swizzledMethods

#pragma mark - arrayWithObjects:count:

+ (instancetype)WKCrashShelterArrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    id safeInstance = nil;
    
    @try {
        //!< 此时IMP已相互交换 指向arrayWithObjects:count:
        safeInstance = [self WKCrashShelterArrayWithObjects:objects count:cnt];
    } @catch (NSException *exception) {
        //!< 这里收集打印异常信息
        WKCrashShelterCollectErrorException(exception, WKCrashShelterDefaultDeal);
        
    } @finally {
        return safeInstance;
    }
    return safeInstance;
}

#pragma mark - objectAtIndex:

//!< __NSArrayI
- (id)__NSArrayIWKCrashShelterObjectAtIndex:(NSUInteger)index {
    id safeInstance = nil;
    @try {
        safeInstance = [self __NSArrayIWKCrashShelterObjectAtIndex:index];
    } @catch (NSException *exception) {
        WKCrashShelterCollectErrorException(exception, WKCrashShelterDefaultDeal_returnNil);
    } @finally {
        return safeInstance;
    }
}

//__NSSingleObjectArrayI
- (id)__NSSingleObjectArrayIWKCrashShelterObjectAtIndex:(NSUInteger)index {
    id safeInstance = nil;
    
    @try {
        safeInstance = [self __NSSingleObjectArrayIWKCrashShelterObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        WKCrashShelterCollectErrorException(exception, WKCrashShelterDefaultDeal_returnNil);
    }
    @finally {
        return safeInstance;
    }
}

//!< __NSArray0
- (id)__NSArray0WKCrashShelterObjectAtIndex:(NSUInteger)index {
    id safeInstance = nil;
    @try {
        safeInstance = [self __NSArray0WKCrashShelterObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        WKCrashShelterCollectErrorException(exception, WKCrashShelterDefaultDeal_returnNil);
    }
    @finally {
        return safeInstance;
    }
}



#pragma mark - objectsAtIndexes:
//!< objectsAtIndexes:
- (NSArray *)WKCrashShelterObjectsAtIndexes:(NSIndexSet *)indexs {
    id safeInstance = nil;
    @try {
       safeInstance = [self WKCrashShelterObjectsAtIndexes:indexs];
    } @catch (NSException *exception) {
        WKCrashShelterCollectErrorException(exception, WKCrashShelterDefaultDeal_returnNil);
    } @finally {
        return safeInstance;
    }
}


#pragma mark - getObjects:ranges:

//!< NSArray
- (void)NSArrayWKCrashShelterGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self NSArrayWKCrashShelterGetObjects:objects range:range];
    } @catch (NSException *exception) {
        WKCrashShelterCollectErrorException(exception, WKCrashShelterDefaultDeal_ignoreOperation);
    } @finally {
        
    }
}

//!< __NSSingleObjectArrayI
- (void)__NSSingleObjectArrayIWKCrashShelterGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self __NSSingleObjectArrayIWKCrashShelterGetObjects:objects range:range];
    } @catch (NSException *exception) {
        WKCrashShelterCollectErrorException(exception, WKCrashShelterDefaultDeal_ignoreOperation);
    } @finally {
        
    }
}

//!< __NSArrayI
- (void)__NSArrayIWKCrashShelterGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self __NSArrayIWKCrashShelterGetObjects:objects range:range];
    } @catch (NSException *exception) {
        WKCrashShelterCollectErrorException(exception, WKCrashShelterDefaultDeal_ignoreOperation);
    } @finally {
        
    }
}


@end
