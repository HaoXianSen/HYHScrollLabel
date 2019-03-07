//
//  UIView+HYHExtension.m
//  SDImageUnscramble
//
//  Created by harry on 2019/3/7.
//  Copyright © 2019 DangDang. All rights reserved.
//

#import "UIView+HYHExtension.h"

@implementation UIView (HYHExtension)

- (CGFloat)yh_x {
    return self.frame.origin.x;
}

- (void)setYh_x:(CGFloat)yh_x {
    CGRect frame = self.frame;
    frame.origin.x = yh_x;
    self.frame = frame;
}

- (CGFloat)yh_y {
    return self.frame.origin.y;
}

- (void)setYh_y:(CGFloat)yh_y {
    CGRect frame = self.frame;
    frame.origin.y = yh_y;
    self.frame = frame;
}

- (void)setYh_width:(CGFloat)yh_width {
    CGSize size = self.yh_size;
    size.width = yh_width;
    self.yh_size = size;
}

- (CGFloat)yh_width {
    return self.yh_size.width;
}

- (void)setYh_height:(CGFloat)yh_height {
    CGSize size = self.yh_size;
    size.height = yh_height;
    self.yh_size = size;
}

- (CGFloat)yh_height {
    return self.yh_size.height;
}

- (CGSize)yh_size {
    return self.frame.size;
}

- (void)setYh_size:(CGSize)yh_size {
    CGRect frame = self.frame;
    frame.size = yh_size;
    self.frame = frame;
}

- (CGPoint)yh_origin {
    return self.frame.origin;
}

- (void)setYh_origin:(CGPoint)yh_origin {
    CGRect frame = self.frame;
    frame.origin = yh_origin;
    self.frame = frame;
}


@end
