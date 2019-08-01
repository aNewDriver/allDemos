//
//  WKChainCalculatorManager.m
//  OpenGL ES Demo
//
//  Created by Ke Wang on 2019/4/1.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKChainCalculatorManager.h"
#import "WKChainCalculatorMaker.h"


@implementation WKChainCalculatorManager

+ (float)makeCalculator:(void(^)(WKChainCalculatorMaker *))calculatorMaker {
    WKChainCalculatorMaker *maker = [WKChainCalculatorMaker new];
    calculatorMaker(maker);
    return maker.result;
}


@end
