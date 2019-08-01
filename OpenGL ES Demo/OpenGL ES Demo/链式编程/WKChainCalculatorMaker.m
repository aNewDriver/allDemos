//
//  WKChainCalculatorMaker.m
//  OpenGL ES Demo
//
//  Created by Ke Wang on 2019/4/1.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKChainCalculatorMaker.h"

@implementation WKChainCalculatorMaker

- (WKChainCalculatorMaker *(^)(float))add {
    return ^WKChainCalculatorMaker *(float value) {
        self.result += value;
        return self;
    };
}
//!< 方法的返回值是一个block, 这个block的返回值是对象自身
- (WKChainCalculatorMaker *(^)(float))sub {
    return ^WKChainCalculatorMaker *(float value) {
        self.result -= value;
        return self;
    };
}

- (WKChainCalculatorMaker *(^)(float))multiply {
    return ^WKChainCalculatorMaker *(float value) {
        self.result *= value;
        return self;
    };
}

- (WKChainCalculatorMaker *(^)(float))divide {
    return ^WKChainCalculatorMaker *(float value) {
        self.result /= value;
        return self;
    };
}




@end
