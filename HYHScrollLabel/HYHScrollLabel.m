//
//  HYHScrollLabel.m
//  SDImageUnscramble
//
//  Created by harry on 2019/3/6.
//  Copyright © 2019 DangDang. All rights reserved.
//

#import "HYHScrollLabel.h"
#import "UIView+HYHExtension.h"
#import "NSTimer+HYHWeaklyTimer.h"
#import "NSString+HYHCalculate.h"

@interface HYHScrollLabel()

@property (nonatomic, weak) UILabel *leftLabel;
@property (nonatomic, weak) UILabel *rightLabel;

@property (nonatomic, strong) NSTimer *animateTimer;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSInteger currentShowIndex;
/// 缓存计算出来的高度或者宽度
@property (nonatomic, strong) NSMutableArray *cache;
@end

@implementation HYHScrollLabel

- (instancetype)initWithFrame:(CGRect)frame andTitls:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        NSAssert(titles.count>0, @"titles 不能无元素");
        _titles = titles;
        [self initailizeData];
        [self setUpSubViews];
    }
    return self;
}

- (void)initailizeData {
    _currentShowIndex = 0;
    _direction = HYHScrollLabelScrollLeftToRight;
    _cache = [NSMutableArray arrayWithCapacity:self.titles.count];
    _intervalSpace = 10;
    self.scrollEnabled = NO;
    self.volacity = 1;
}

- (void)setUpSubViews {
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    leftLabel.lineBreakMode = NSLineBreakByWordWrapping;
    leftLabel.numberOfLines = 0;
    [self addSubview:leftLabel];
    _leftLabel = leftLabel;
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    rightLabel.lineBreakMode = NSLineBreakByWordWrapping;
    rightLabel.numberOfLines = 0;
    [self addSubview:rightLabel];
    _rightLabel = rightLabel;
    
    [self updateLocationWithType:self.direction currentIndex:self.currentShowIndex];
}

- (void)updateLocationWithType:(HYHScrollLabelScrollDirecttion)direction currentIndex:(NSInteger)currentShowIndex {
    CGFloat leftWidth = 0.0f;
    CGFloat rightWidth = 0.0f;
    CGFloat rightX = 0.0f;
    CGFloat rightY = 0.0f;
    CGFloat leftHeight = 0.0f;
    CGFloat rightHeight = 0.0f;
    NSInteger leftTitleIndex = currentShowIndex;
    NSInteger rightTitleIndex = 0;
    if (currentShowIndex >= self.titles.count) {
        leftTitleIndex = 0;
        rightTitleIndex = leftTitleIndex + 1;
    } else if (currentShowIndex + 1 >= self.titles.count) {
        rightTitleIndex = 0;
    } else {
        rightTitleIndex = leftTitleIndex + 1;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.leftLabel.text = self.titles[leftTitleIndex];
        self.rightLabel.text = self.titles[rightTitleIndex];
    });
    
    if (direction == HYHScrollLabelScrollLeftToRight) {
        leftHeight = rightHeight = self.yh_height;
        
        if (self.cache.count > leftTitleIndex) {
            leftWidth = [self.cache[leftTitleIndex] floatValue];
        } else {
            leftWidth = [self.titles[leftTitleIndex] calculateMaxWidthWithHeight:leftHeight Attributes:@{NSFontAttributeName : self.leftLabel.font}];
            leftWidth = MAX(leftWidth, self.yh_width);
            [self.cache addObject:@(leftWidth)];
        }
        
        if (self.cache.count > rightTitleIndex) {
            rightWidth = [self.cache[rightTitleIndex] floatValue];
        } else {
            rightWidth = [self.titles[rightTitleIndex] calculateMaxWidthWithHeight:rightWidth Attributes:@{NSFontAttributeName : self.rightLabel.font}];
            rightWidth = MAX(rightWidth, self.yh_width);
            [self.cache addObject:@(rightWidth)];
        }
        
        rightX = leftWidth + 10;
    } else if (direction == HYHScrollLabelScrollUpToDown) {
        leftWidth = rightWidth = self.yh_width;
        if (self.cache.count > leftTitleIndex) {
            leftHeight = [self.cache[leftTitleIndex] floatValue];
        } else {
            leftHeight = [self.titles[leftTitleIndex] calculateMaxHeightWithWidth:leftWidth Attributes:@{NSFontAttributeName : self.leftLabel.font}];
            leftHeight = MAX(leftWidth, self.yh_height);
            [self.cache addObject:@(leftHeight)];
        }
        
        if (self.cache.count > rightTitleIndex) {
            rightHeight = [self.cache[rightTitleIndex] floatValue];
        } else {
            rightHeight = [self.titles[rightTitleIndex] calculateMaxWidthWithHeight:rightHeight Attributes:@{NSFontAttributeName : self.rightLabel.font}];
            rightHeight = MAX(rightHeight, self.yh_height);
            [self.cache addObject:@(rightHeight)];
        }
    }
    
    self.contentSize = CGSizeMake(leftWidth+rightWidth, leftHeight+rightHeight);
    self.leftLabel.frame = CGRectMake(0, 0, leftWidth, leftHeight);
    self.rightLabel.frame = CGRectMake(rightX, rightY, rightWidth, rightHeight);
}

#pragma mark - setter
- (void)setDirection:(HYHScrollLabelScrollDirecttion)direction {
    if (_direction != direction) {
        _direction = direction;
        [self updateLocationWithType:direction currentIndex:self.currentShowIndex];
    }
}

- (void)setVolacity:(NSTimeInterval)volacity {
    if (volacity < 1) {
        volacity = 1;
    } else if (volacity > 10) {
        volacity = 10;
    }
    _volacity = volacity;
    CGFloat delta = self.yh_width;
    CGFloat allDuration = 2.0;
    if (self.direction == HYHScrollLabelScrollUpToDown) {
        delta = self.yh_height;
        allDuration = 10.0;
    }
    _duration = (allDuration / self.yh_width)*10 / volacity;
}

- (void)setIntervalSpace:(CGFloat)intervalSpace {
    if (_intervalSpace != intervalSpace) {
        _intervalSpace = intervalSpace;
        [self updateLocationWithType:self.direction currentIndex:self.currentShowIndex];
    }
}

#pragma mark -

- (void)beiginScroll {
    if (!_animateTimer) {
        __weak typeof(self) weakSelf = self;
        _animateTimer = [NSTimer yh_weaklyTimerWithTimerInterval:self.duration excuteBlock:^(NSTimer *timer) {
            [weakSelf animate];
        } repeat:YES];
        [[NSRunLoop currentRunLoop] addTimer:_animateTimer forMode:NSRunLoopCommonModes];
    }
}
- (void)endScroll {
    [_animateTimer invalidate];
    _animateTimer = nil;
}

#pragma mark - private

- (void)animate {
    if (self.direction == HYHScrollLabelScrollLeftToRight) {
        if (self.contentOffset.x <= (self.leftLabel.yh_width+self.leftLabel.yh_x + self.intervalSpace)) {
            CGFloat x = self.contentOffset.x + 1;
            self.contentOffset = CGPointMake(x, self.contentOffset.y);
        } else {
            [self endScroll];
            if (self.currentShowIndex < self.titles.count-1) {
                self.currentShowIndex += 1;
            } else {
                self.currentShowIndex = 0;
            }
            self.contentOffset = CGPointMake(0, self.contentOffset.y);
            [self updateLocationWithType:self.direction currentIndex:self.currentShowIndex];
            [self beiginScroll];
        }
    } else {
        if (self.contentOffset.y <= (self.leftLabel.yh_height+self.leftLabel.yh_y + self.intervalSpace)) {
            CGFloat y = self.contentOffset.y + self.leftLabel.font.lineHeight;
            self.contentOffset = CGPointMake(self.contentOffset.x, y);
        } else {
            [self endScroll];
            if (self.currentShowIndex < self.titles.count-1) {
                self.currentShowIndex += 1;
            } else {
                self.currentShowIndex = 0;
            }
            self.contentOffset = CGPointMake(self.contentOffset.x, 0);
            [self updateLocationWithType:self.direction currentIndex:self.currentShowIndex];
            [self beiginScroll];
        }
    }
   
}

#pragma mark -

- (void)dealloc
{
    if (_animateTimer) {
        [self.animateTimer invalidate];
        _animateTimer = nil;
    }
}
@end
