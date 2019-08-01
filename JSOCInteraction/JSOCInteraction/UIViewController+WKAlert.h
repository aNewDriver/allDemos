//
//  UIViewController+WKAlert.h
//  JSOCInteraction
//
//  Created by Ke Wang on 2019/4/8.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (WKAlert)

- (void)presentAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                      handler:(void(^ __nullable)(UIAlertAction *action))handler;

@end

NS_ASSUME_NONNULL_END
