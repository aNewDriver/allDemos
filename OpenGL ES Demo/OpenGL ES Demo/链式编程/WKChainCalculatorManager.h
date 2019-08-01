//
//  WKChainCalculatorManager.h
//  OpenGL ES Demo
//
//  Created by Ke Wang on 2019/4/1.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WKChainCalculatorMaker;


NS_ASSUME_NONNULL_BEGIN

@interface WKChainCalculatorManager : NSObject

+ (float)makeCalculator:(void(^)(WKChainCalculatorMaker *make))calculatorMaker;



@end

NS_ASSUME_NONNULL_END
