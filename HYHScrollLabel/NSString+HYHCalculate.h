//
//  NSString+HYHCalculate.h
//  SDImageUnscramble
//
//  Created by harry on 2019/3/7.
//  Copyright © 2019 DangDang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (HYHCalculate)

- (CGFloat)calculateMaxWidthWithHeight:(CGFloat)height Attributes:(NSDictionary *)attributes;

- (CGFloat)calculateMaxHeightWithWidth:(CGFloat)width Attributes:(NSDictionary *)attributes;

@end
