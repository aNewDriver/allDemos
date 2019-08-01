;//
//  UIWebViewVC.h
//  JSOCInteraction
//
//  Created by Ke Wang on 2019/4/4.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


NS_ASSUME_NONNULL_BEGIN

//!< 定义protocol

@protocol JSObjectDelegate <JSExport>

//!< 取一个JS能够识别的名字
JSExportAs(onClick, - (NSString *)onClick:(NSString *)param1 param2:(NSString *)param2);

@end
//!< 遵循代理 让JS能够调用到方法
@interface UIWebViewVC : UIViewController<JSObjectDelegate, UIWebViewDelegate>

@end

NS_ASSUME_NONNULL_END
