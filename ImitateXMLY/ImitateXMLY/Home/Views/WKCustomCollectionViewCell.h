//
//  WKCustomCollectionViewCell.h
//  ImitateXMLY
//
//  Created by Ke Wang on 2019/3/5.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKCustomCollectionViewCell : UICollectionViewCell

- (void)configureUIWithClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END