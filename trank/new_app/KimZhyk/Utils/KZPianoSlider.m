//
//  KZPianoSlider.m
//  KimZhyk
//
//  Created by Ihor Koblan on 3/19/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//
#import "KZPianoSlider.h"

@implementation KZPianoSlider
@synthesize delegate;

- (void)setThumbWidth:(CGFloat)thumbWidth {
    _thumbWidth = thumbWidth;
    _thumb.frame = CGRectMake(0.0, 0.0, thumbWidth, 30);
}

- (void)setPosition:(CGFloat)position {
    assert(position >= 0);
    assert(position <= 1);
    
    _position = position;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(KZPianoSlider:valueChanged:)]) {
        [self.delegate KZPianoSlider:self valueChanged:_position];
    }
    
    if (_thumb) {
        _thumb.center = CGPointMake(_position * (self.bounds.size.width -_thumb.bounds.size.width) + _thumb.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint lTouchLocation = [event.allTouches.anyObject locationInView:self];
    _deltaX = - lTouchLocation.x + _thumb.frame.origin.x;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint lTouchLocation = [event.allTouches.anyObject locationInView:self];
    CGFloat lNewPosition = ((lTouchLocation.x + _deltaX) / (self.bounds.size.width - _thumb.bounds.size.width));
    if (lNewPosition > 1) {
        lNewPosition = 1;
    }
    if (lNewPosition < 0) {
        lNewPosition = 0;
    }
    self.position = lNewPosition;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        _thumb = [[UIImageView alloc] initWithFrame: CGRectMake(0.0, 0.0, 30.0, 30.0)];
        _thumb.backgroundColor = [UIColor blackColor];
        _thumb.alpha = 0.7;
        
        self.position = 0.0;
        [self addSubview:_thumb];
    }
    return self;
}

@end