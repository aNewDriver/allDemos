//
//  WKWebViewVC.m
//  JSOCInteraction
//
//  Created by Ke Wang on 2019/4/4.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKWebViewVC.h"
#import <WebKit/WebKit.h>
#import "UIViewController+WKAlert.h"


@interface WKWebViewVC ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //!< 为WKUserContentController添加name为'JSToOC'的 ScriptMessageHandler;
    WKUserContentController *userC = [[WKUserContentController alloc] init];
    //!< 配置WKWebViewConfiguration;
    WKWebViewConfiguration *configuretion = [[WKWebViewConfiguration alloc] init];
    configuretion.userContentController = userC;
    
    //!< 使用WKWebViewConfiguration初始化
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuretion];
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TestWKWebJS" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:html baseURL:baseURL];
    
    UIBarButtonItem *loginBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login:)];
    self.navigationItem.rightBarButtonItems = @[loginBtnItem];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"JSToOC"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"JSToOC"];
}

- (void)login:(UIButton *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //!< 注意: evaluateJavaScript 只有在webView全部load完成后才能执行
        [self.webView evaluateJavaScript:[NSString stringWithFormat:@"OCTransferJS('OC调用JS代码, 并传递参数;', 'OC传递来了参数:12345678')"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            
        }];
    });
}


#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    //!< 判断是否是约定好的scheme
    if ([navigationAction.request.URL.scheme caseInsensitiveCompare:@"JSTransferOC"] == NSOrderedSame) {
        [self presentAlertWithTitle:navigationAction.request.URL.host message:navigationAction.request.URL.query handler:^(UIAlertAction * _Nonnull action) {
            decisionHandler(WKNavigationActionPolicyCancel);
        }];
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    //!< 注意这里的 decisionHandler()必须调用, 否则会崩溃. 相当于UIWebView中的 - shouldStartLoadWithRequest 方法中 返回YES Or NO 是否允许跳转
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name caseInsensitiveCompare:@"JSToOC"] == NSOrderedSame) {
        NSDictionary *dic = message.body;
        NSString *messageStr = [NSString stringWithFormat:@"%@, %@", dic[@"title"], dic[@"content"]];
        [self presentAlertWithTitle:message.name message:messageStr handler:nil];
    }
}

#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    [self presentAlertWithTitle:@"title" message:message handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirm" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = defaultText;
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text);
    }];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
