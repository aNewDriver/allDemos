//
//  WKCustomCollectionViewCell.m
//  ImitateXMLY
//
//  Created by Ke Wang on 2019/3/5.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKCustomCollectionViewCell.h"



@implementation WKCustomCollectionViewCell {
    NSString *_className;
}

- (void)configureUIWithClassName:(NSString *)className {
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    id class = NSClassFromString(className);
    UIViewController *vc = [[class alloc] init];
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
}

//- (UIViewController *)findViewController:(UIView *)sourceView
//{
//    id target=sourceView;
//    while (target) {
//        target = ((UIResponder *)target).nextResponder;
//        if ([target isKindOfClass:[UIViewController class]]) {
//            break;
//        }
//    }
//    return target;
//}

@end
