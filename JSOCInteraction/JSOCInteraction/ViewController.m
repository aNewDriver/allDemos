//
//  ViewController.m
//  JSOCInteraction
//
//  Created by Ke Wang on 2019/4/4.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "ViewController.h"
#import "UIWebViewVC.h"
#import "WKWebViewVC.h"
#import "UIView+WKFillet.h"
#import "UIImage+WKCorners.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *UIWebViewButton;
@property (weak, nonatomic) IBOutlet UIButton *WKWebViewButton;
@property (nonatomic, strong) JSContext *context;

@property (nonatomic, strong) UIView *subView;


@property (nonatomic, strong) UIImageView *imagV;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _context = [[JSContext alloc] init];
    _context[@"hello"] = ^(NSString *msg){
        NSLog(@"hello%@", msg);
    };
    
    
    [self unSetObject];
    [self SetObject];
    
    
    self.subView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
    self.subView.backgroundColor = [UIColor redColor];
    [self.subView setupCornersToRoundedCornersWithCornersRadius:10 roundingCorners: UIRectCornerTopLeft | UIRectCornerBottomRight | UIRectCornerBottomLeft];
    [self.view addSubview:self.subView];
    
    
    self.imagV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 550, 80, 80)];
//    [self.imagV setupCornersToRoundedCornersWithCornersRadius:40 roundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight];
    self.imagV.backgroundColor = [UIColor blueColor];
    
    
    UIImage *image = [UIImage imageNamed:@"test.png"];
    
    UIImage * newImage = [image setupAllCornersToRoundedCornersWithCornersRadius:image.size.width];
    
    self.imagV.image = newImage;
    [self.view addSubview:self.imagV];
    
    
}

- (IBAction)buttonClick:(id)sender {
    
    [_context evaluateScript:@"hello('word')"];
    
    
    if (sender == self.UIWebViewButton) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[UIWebViewVC alloc] init]];
        
        [self presentViewController:nav animated:YES completion:nil];
    } else {
        
    }
}
- (IBAction)WKWebViewBtnClick:(id)sender {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[WKWebViewVC alloc] init]];
    [self presentViewController:nav animated:YES completion:nil];
}


//!< 非集合类对象的copy和mutableCopy
- (void)unSetObject {
    
    //!< 非集合类不可变对象:
    NSString *str = @"hello word";
    id copyStr = [str copy];
    id mutableCopyStr = [str mutableCopy];
    NSLog(@"str:%p class:%@  \n copyStr:%p class:%@ \n mutableCopyStr:%p  class:%@", str, [str class],  copyStr, [copyStr class], mutableCopyStr, [mutableCopyStr class]);
    
    //!< 非集合类可变对象:
    
    NSMutableString *str1 = [[NSMutableString alloc] initWithFormat:@"hello word"];
    id copyStr1 = [str1 copy];
    id mutableCopyStr1 = [str1 mutableCopy];
    NSLog(@"str1:%p class:%@  \n copyStr1:%p class:%@ \n mutableCopyStr1:%p  class:%@", str1, [str1 class],  copyStr1, [copyStr1 class], mutableCopyStr1, [mutableCopyStr1 class]);
}

//!< 集合类对象的copy和mutableCopy
- (void)SetObject {
    
    NSArray *arr = @[];
    id copyArr = [arr copy];
    id mutableCArr = [arr mutableCopy];
    NSLog(@"arr:%p class:%@     \n  \tcopyArr:%p class:%@ \n \tmutableCArr:%p  class:%@", arr, [arr class],  copyArr, [copyArr class], mutableCArr, [mutableCArr class]);
    
    
    NSMutableArray *muArr = [NSMutableArray new];
    id copyMuArr = [muArr copy];
    id mutableCMuArr = [muArr mutableCopy];
    
    NSLog(@"muArr:%p class:%@     \n \tcopyMuArr:%p class:%@ \n \tmutableCMuArr:%p  class:%@", muArr, [muArr class],  copyMuArr, [copyMuArr class], mutableCMuArr, [mutableCMuArr class]);
}



@end

