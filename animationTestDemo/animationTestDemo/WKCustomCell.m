//
//  WKCustomCell.m
//  animationTestDemo
//
//  Created by Ke Wang on 2019/5/10.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKCustomCell.h"

@interface WKCustomCell ()



@end

@implementation WKCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imageV];
    }
    return self;
}



#pragma mark - get

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.frame = CGRectMake(20, 10, 80, 80);
        _imageV.image = [UIImage imageNamed:@"test"];
        _imageV.backgroundColor = [UIColor redColor];
    }
    return _imageV;
}


@end
