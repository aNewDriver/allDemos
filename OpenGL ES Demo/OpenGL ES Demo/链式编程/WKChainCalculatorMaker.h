//
//  WKChainCalculatorMaker.h
//  OpenGL ES Demo
//
//  Created by Ke Wang on 2019/4/1.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

//!< 链式编程思想 : 将多个操作(多行代码)通过 (.)链接在一起, 成为一句代码  增强可读性
//!< 要达到这个目的, 要求 每个方法的返回值是block, 这个block必须有返回值(对象本身), block的参数为需要操作的值



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKChainCalculatorMaker : NSObject

@property (nonatomic, assign) float result;
//@property (nonatomic, copy) WKChainCalculatorMaker *(^add)(float value);


- (WKChainCalculatorMaker *(^)(float))add;
- (WKChainCalculatorMaker *(^)(float))sub;
- (WKChainCalculatorMaker *(^)(float))multiply;
- (WKChainCalculatorMaker *(^)(float))divide;





@end

NS_ASSUME_NONNULL_END
