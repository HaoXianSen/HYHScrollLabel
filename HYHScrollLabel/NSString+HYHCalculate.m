//
//  NSString+HYHCalculate.m
//  SDImageUnscramble
//
//  Created by harry on 2019/3/7.
//  Copyright © 2019 DangDang. All rights reserved.
//

#import "NSString+HYHCalculate.h"

@implementation NSString (HYHCalculate)

- (CGFloat)calculateMaxWidthWithHeight:(CGFloat)height Attributes:(NSDictionary *)attributes  {
    CGSize size = CGSizeMake(CGFLOAT_MAX, height);
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width;
}

- (CGFloat)calculateMaxHeightWithWidth:(CGFloat)width Attributes:(NSDictionary *)attributes {
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;
}

@end
