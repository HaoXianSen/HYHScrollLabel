//
//  NSTimer+HYHWeaklyTimer.m
//  SDImageUnscramble
//
//  Created by harry on 2019/3/7.
//  Copyright © 2019 DangDang. All rights reserved.
//

#import "NSTimer+HYHWeaklyTimer.h"

@implementation NSTimer (HYHWeaklyTimer)

+ (instancetype)yh_weaklyTimerWithTimerInterval:(NSTimeInterval)interval excuteBlock:(void(^)(NSTimer *timer))excuteBlock repeat:(BOOL)repeat {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(pYH_excute:) userInfo:excuteBlock repeats:repeat];
}

+ (void)pYH_excute:(NSTimer *)timer {
    if (timer.userInfo) {
        void(^excuteBlock)(NSTimer *timer) = timer.userInfo;
        excuteBlock(timer);
    }
}

@end
