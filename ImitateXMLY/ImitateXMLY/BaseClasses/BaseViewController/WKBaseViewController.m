//
//  WKBaseViewController.m
//  iOSDemos
//
//  Created by Ke Wang on 2018/10/22.
//  Copyright © 2018年 Ke Wang. All rights reserved.
//

#import "WKBaseViewController.h"

@interface WKBaseViewController ()<UITextFieldDelegate>

@end

@implementation WKBaseViewController

- (void)viewDidLoad {
    [self baseConfigureUI];
    [super viewDidLoad];
}

- (void)baseConfigureUI {
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //!< 去除黑线
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [self createImageWithColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar dropShadowWithOffset:CGSizeMake(0, 2)
//                                                           radius:4
//                                                            color:RGBACOLOR(98, 98, 98, 0.12)
//                                                          opacity:1];
}



#pragma mark - baseConfigure


- (void)configureRightItemsWithItemNameArray:(NSArray <NSString *> *)itemNameArray actionNameArray:(NSArray <NSString *> *)actionNameArray {
    if (itemNameArray.count != actionNameArray.count) { //!< 保证名字和方法一一对应
        return;
    }
    NSMutableArray <UIBarButtonItem *>*barItems = @[].mutableCopy;
    for (NSUInteger i = 0; i < itemNameArray.count; i++) {
        NSString *itemName = itemNameArray[i];
        NSString *actionName = actionNameArray[i];
        SEL action = NSSelectorFromString(actionName);
        if (![self respondsToSelector:action]) {
            return;
        }
        UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:itemName style:UIBarButtonItemStyleDone target:self action:action];
        bar.tintColor = [UIColor blackColor];
        [barItems addObject:bar];
    }
    
    if (barItems.count > 0) {
        self.navigationItem.rightBarButtonItems = barItems;
    }
    
}


- (void)configureRightItemsWithItemNameArray:(nonnull NSArray <NSString *> *)itemNameArray
                              itemColorArray:(nonnull NSArray <UIColor *>*)itemColorArray
                               itemFontArray:(nonnull NSArray <UIFont *>*)itemFontArray
                             actionNameArray:(nonnull NSArray <NSString *> *)actionNameArray {
    if (itemNameArray.count != actionNameArray.count) { //!< 保证名字和方法一一对应
        return;
    }
    NSMutableArray <UIBarButtonItem *>*barItems = @[].mutableCopy;
    for (NSUInteger i = 0; i < itemNameArray.count; i++) {
        NSString *itemName = itemNameArray[i];
        NSString *actionName = actionNameArray[i];
        UIColor *tincolor = itemColorArray[i];
        UIFont *font = itemFontArray[i];
        SEL action = NSSelectorFromString(actionName);
        if (![self respondsToSelector:action]) {
            return;
        }
        UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:itemName style:UIBarButtonItemStyleDone target:self action:action];
        bar.tintColor = tincolor;

        [bar setTitleTextAttributes:@{NSFontAttributeName : font} forState:UIControlStateNormal];
        [barItems addObject:bar];
    }
    
    if (barItems.count > 0) {
        self.navigationItem.rightBarButtonItems = barItems;
    }
    
}

- (void)configureRightItemsWithItemNameArray:(nonnull NSArray <NSString *> *)itemNameArray
                              attributeRules:(NSArray <NSDictionary *>*)attributeRules
                             itemColorArray:(nonnull NSArray <UIColor *>*)itemColorArray
                             actionNameArray:(nonnull NSArray <NSString *> *)actionNameArray {
    if (itemNameArray.count != actionNameArray.count) { //!< 保证名字和方法一一对应
        return;
    }
    NSMutableArray <UIBarButtonItem *>*barItems = @[].mutableCopy;
    for (NSUInteger i = 0; i < itemNameArray.count; i++) {
        NSString *itemName = itemNameArray[i];
        NSString *actionName = actionNameArray[i];
        UIColor *tincolor = itemColorArray[i];
        NSDictionary *attDic = attributeRules[i];
        SEL action = NSSelectorFromString(actionName);
        if (![self respondsToSelector:action]) {
            return;
        }
        UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:itemName style:UIBarButtonItemStyleDone target:self action:action];
        bar.tintColor = tincolor;
        [bar setTitleTextAttributes:attDic forState:UIControlStateNormal];
        [barItems addObject:bar];
    }
    
    if (barItems.count > 0) {
        self.navigationItem.rightBarButtonItems = barItems;
    }
    
}

- (void)configureRightItemsWithItemImageNameArray:(NSArray <NSString *> *)itemImageNameArray actionNameArray:(NSArray <NSString *> *)actionNameArray {
    if (itemImageNameArray.count != actionNameArray.count) { //!< 保证名字和方法一一对应
        return;
    }
    NSMutableArray <UIBarButtonItem *>*barItems = @[].mutableCopy;
    for (NSUInteger i = 0; i < itemImageNameArray.count; i++) {
        NSString *imageName = itemImageNameArray[i];
        NSString *actionName = actionNameArray[i];
        SEL action = NSSelectorFromString(actionName);
        if (![self respondsToSelector:action]) {
            return;
        }
        UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:action];
        bar.tintColor = [UIColor blackColor];
        [barItems addObject:bar];
    }
    
    if (barItems.count > 0) {
        self.navigationItem.rightBarButtonItems = barItems;
    }
}

#pragma mark - get

- (void)setNavTinColor:(UIColor *)navTinColor {
    if (navTinColor == _navTinColor) {
        return;
    }
    _navTinColor = navTinColor;
    self.navigationController.navigationBar.tintColor = _navTinColor;
}

- (void)setNavBackgroundColor:(UIColor *)navBackgroundColor {
    if (navBackgroundColor == _navBackgroundColor) {
        return;
    }
    _navBackgroundColor = navBackgroundColor;
    self.navigationController.navigationBar.barTintColor = navBackgroundColor;
}

- (void)hiddenBackAction {
    self.navigationController.navigationItem.leftBarButtonItem = nil;
}

- (UIImage*) createImageWithColor:(UIColor*) color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}





@end
