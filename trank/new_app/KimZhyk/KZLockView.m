//
//  KZLockView.m
//  KimZhyk
//
//  Created by Ihor Koblan on 3/27/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZLockView.h"

@implementation KZLockView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.0f;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)showInView:(id)view {
    [view addSubview:self];
    __weak KZLockView *lWeekSelf_ = self;
    [UIView animateWithDuration:0.3f animations:^{
        lWeekSelf_.alpha = 1.0f;
    }];
}

- (void)hide {
    __weak KZLockView *lWeekSelf_ = self;
    [UIView animateWithDuration:0.3f animations:^{
        lWeekSelf_.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [lWeekSelf_ removeFromSuperview];
    }];
}

@end
