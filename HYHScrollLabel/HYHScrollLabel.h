//
//  HYHScrollLabel.h
//  SDImageUnscramble
//
//  Created by harry on 2019/3/6.
//  Copyright © 2019 DangDang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HYHScrollLabelScrollDirecttion) {
    HYHScrollLabelScrollLeftToRight, // 从左到右边
    HYHScrollLabelScrollUpToDown, // 从上到下
};

@interface HYHScrollLabel : UIScrollView

@property (nonatomic, copy, readonly) NSArray<NSString *> *titles;

/**
 *  default HYHScrollLabelScrollLeftToRight
 */
@property (nonatomic, assign) HYHScrollLabelScrollDirecttion direction;
/**
 * this value range 1....10;
 * default calculate by 1
 */
@property (nonatomic, assign) NSTimeInterval volacity;

/**
 *  相邻间距 默认10
 */
@property (nonatomic, assign) CGFloat intervalSpace;



- (instancetype)initWithFrame:(CGRect)frame andTitls:(NSArray *)titles;

- (void)beiginScroll;
- (void)endScroll;
@end
