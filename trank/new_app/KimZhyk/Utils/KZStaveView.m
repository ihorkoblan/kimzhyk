//
//  KZStaveView.m
//  KimZhyk
//
//  Created by Пользователь on 20.03.15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZStaveView.h"
#import "KZSound.h"

// - - - - - -- - - -- - - - - -- - - - -- -

@implementation KZStaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor yellowColor]];
        _thumb = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10, 10)];
        _thumb.layer.cornerRadius = _thumb.bounds.size.width / 2.0;
        _thumb.backgroundColor = [UIColor blackColor];
        _thumb.alpha = 0.7f;
        [_thumb.layer masksToBounds];
        [self addSubview:_thumb];
        _thumb.hidden = YES;
    }
    return self;
}

- (void)showThumbAtPosition:(CGPoint)point {
    _thumb.center = point;
    [UIView animateWithDuration:0.3 animations:^{
        if (![_thumb isDescendantOfView:self]) {
            [self addSubview:_thumb];
        }
        _thumb.hidden = NO;
    }];
}

- (void)hideThumb {
    [UIView animateWithDuration:0.3 animations:^{
        _thumb.hidden = YES;
    } completion:^(BOOL finished) {
        if ([_thumb isDescendantOfView:self]) {
            [_thumb removeFromSuperview];
        }
    }];
}

- (void)showSound:(KZSound *)sound {
    CGPoint thumbPosition = CGPointMake(0.0, 0.0);
    [self showThumbAtPosition:thumbPosition];
}

- (void)hideSound {
    [self hideThumb];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGFloat lineWidth = 1.0;
    CGContextSetLineWidth(contextRef, lineWidth);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.0f, 0.0f, 1.0f, 1.0f};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(contextRef, color);
    float freeSpace = 10.0;
    float offset = rect.size.height / 2.0f - 5.0 * (freeSpace - lineWidth) / 2.0;
    for (int i = 0; i < 5; i++) {
        CGContextMoveToPoint(contextRef, 0.0, i * freeSpace + offset);
        CGContextAddLineToPoint(contextRef, self.bounds.size.width, i * freeSpace + offset);
    }
    CGContextStrokePath(contextRef);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
}

@end
