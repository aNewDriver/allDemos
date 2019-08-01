//
//  UIWebViewVC.m
//  JSOCInteraction
//
//  Created by Ke Wang on 2019/4/4.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "UIWebViewVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "UIViewController+WKAlert.h"

@interface UIWebViewVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation UIWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TestJS" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:html baseURL:baseURL];
    
    UIBarButtonItem *loginBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login:)];
    self.navigationItem.rightBarButtonItems = @[loginBtnItem];
    
    
    
    
}
#pragma mark - delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //!< 将JS和OC中定义好的类(iOSDelgate)指向自身, 这样JS中的 window.iOSDelgate.onClick();就会调用oc代码
    context[@"iOSDelgate"] = self;
    
    //!< 相当于监听了JS方法,  或者在OC中重写了JS方法
//    context[@"clickAction0"] = ^() {
//        NSLog(@"获取到点击js按钮的事件");
//    };
    
    //!< OC监听JS事件  同时JS向OC传递参数
    //!< 点击HTML按钮, 传递参数到OC中
    context[@"JSTransferOC"] = ^(NSString *action, NSString *params) {
        [self presentAlertWithTitle:[NSString stringWithFormat:@"获取到点击js按钮的事件, 传递过来了事件:%@" , action] message:params handler:nil];
    };
}

//!< uwebView每次加载请求前都会调用这个方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //!< 通过判断URL.scheme来判断是否是JS中定义好的方法
//    if ([request.URL.scheme caseInsensitiveCompare:@"JSTransferOC"] == NSOrderedSame) {
//        [self presentAlertWithTitle:request.URL.host message:request.URL.query handler:nil];
//        return NO;
//    }
    
    return YES;
}

#pragma mark - 实现protocol方法, 供JS调用, JS调用OC本地代码, 常用在定位, 获取相册等操作
//!< 点击HTML中的按钮, 调用OC中的代码, 并回传参数给JS
- (NSString *)onClick:(NSString *)param1 param2:(NSString *)param2 {
    
    return [NSString stringWithFormat:@"OC方法被JS调用%@%@", param1, param2];
}


#pragma mark - OC调用JS  OC调用JS代码, 并传递参数
//!< 点击native按钮登录, 并将登录成功的参数回传给JS
- (void)login:(UIButton *)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //!< 方式一: 使用 stringByEvaluatingJavaScriptFromString的方式
//        NSString *jsString = [NSString stringWithFormat:@"OCTransferJS('loginSucceed', 'oc_tokenString')"];
//        [self.webView stringByEvaluatingJavaScriptFromString:jsString];
        
        //!< 方式二: 使用JavaScriptCore
         JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        [context evaluateScript:[NSString stringWithFormat:@"OCTransferJS('login_success', 'login_success_token')"]];
    });
}


@end
