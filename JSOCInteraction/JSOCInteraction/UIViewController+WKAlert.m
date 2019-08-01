//
//  UIViewController+WKAlert.m
//  JSOCInteraction
//
//  Created by Ke Wang on 2019/4/8.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "UIViewController+WKAlert.h"

@implementation UIViewController (WKAlert)

- (void)presentAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                      handler:(void (^ __nullable) (UIAlertAction *action))handler {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *centain = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:handler];
        [alert addAction:centain];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

@end
