//
//  WKCopyObject.m
//  JSOCInteraction
//
//  Created by Ke Wang on 2019/4/24.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKCopyObject.h"

@interface WKCopyObject ()<NSCopying, NSMutableCopying>

@property (nonatomic, copy) NSString *name;

@end

@implementation WKCopyObject

- (id)copyWithZone:(NSZone *)zone {
    WKCopyObject *obj = [[[self class] alloc] init];
    obj.name = self.name;
    return obj;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    WKCopyObject *obj = [[[self class] alloc] init];
    obj.name = self.name.mutableCopy;
    return obj;
}

@end
