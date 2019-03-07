//
//  NSTimer+HYHWeaklyTimer.h
//  SDImageUnscramble
//
//  Created by harry on 2019/3/7.
//  Copyright © 2019 DangDang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (HYHWeaklyTimer)

+ (instancetype)yh_weaklyTimerWithTimerInterval:(NSTimeInterval)interval excuteBlock:(void(^)(NSTimer *timer))excuteBlock repeat:(BOOL)repeat;

@end
