//
//  KZPianoKeyboard.m
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZPianoKeyboard.h"
#import "KZPianoKey.h"

// - - - - - - - - KZPianoKeyboard - - - - - - -

@interface KZPianoView() {
    NSUInteger _currentTouchNumber;
}

@property (nonatomic, strong) NSMutableArray *pressedkeysArray;
@property (nonatomic, assign) CGSize whiteKeySize;
@property (nonatomic, assign) CGSize blackKeySize;
@property (nonatomic, assign) NSUInteger numberOfWhiteKeys;

@end;

@implementation KZPianoView


- (NSMutableArray *)pressedkeysArray {
    if (_pressedkeysArray == nil) {
        _pressedkeysArray = [NSMutableArray new];
    }
    return _pressedkeysArray;
}

//- (void)setNumberOfWhiteKeys:(NSUInteger)numberOfWhiteKeys {
//    _numberOfWhiteKeys = numberOfWhiteKeys;
//    for (UIView *view in self.subviews) {
//        [view removeFromSuperview];
//    }
//    [self mainInit];
//}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setClipsToBounds:YES];
        self.gestureRecognizers = nil;
        self.userInteractionEnabled = YES;
        
        self.whiteKeySize = CGSizeMake(50, frame.size.height);
        self.blackKeySize = CGSizeMake(30, frame.size.height * 0.7);
        self.numberOfWhiteKeys = 55;
        
        [self mainInit];
        _currentTouchNumber = 0;
    }
    return self;
}

- (void)mainInit {

    CGFloat lMarginX = 0.0;
    CGFloat lMarginY = 0.0;

    NSInteger lTagIndex = 0;
    
    for (NSUInteger keyIndex = 0; keyIndex < self.numberOfWhiteKeys; keyIndex++) {
        
        if ([KZKey isKeyBlack:keyIndex]) {
            KZKey *lBlackKey = [[KZKey alloc] initWithFrame:CGRectMake(-self.blackKeySize.width / 2.0 + keyIndex * ((self.whiteKeySize.width)) , lMarginY, self.blackKeySize.width, self.blackKeySize.height)];
            lBlackKey.tag = lTagIndex + 1000;
            [lBlackKey setImage:[UIImage imageNamed:@"Black_key.png"]];
            [lBlackKey setHighlightedImage:[UIImage imageNamed:@"Black_key_active.png"]];
            lBlackKey.keyType = KZPianoKeyTypeBlack;
            lBlackKey.userInteractionEnabled = NO;
            lBlackKey.layer.zPosition = MAXFLOAT;
            [self addSubview:lBlackKey];
        }
        
        KZKey *lKey = [[KZKey alloc] initWithFrame:CGRectMake(lMarginX + keyIndex * (self.whiteKeySize.width), lMarginY, self.whiteKeySize.width, self.whiteKeySize.height)];
        [lKey setImage:[UIImage imageNamed:@"White_key.png"]];
        [lKey setHighlightedImage:[UIImage imageNamed:@"White_key_active.png"]];
        lKey.keyType = KZPianoKeyTypeWhite;
        lKey.tag = ++lTagIndex;
        lKey.userInteractionEnabled = NO;
        [self addSubview:lKey];
    }
    self.contentSize = CGSizeMake(self.numberOfWhiteKeys * self.whiteKeySize.width, self.whiteKeySize.height);
}

#pragma mark - Touch interruption handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _currentTouchNumber = [event allTouches].count;
    for (UITouch *touch in [event allTouches]) {
        [self touchAtPoint:[touch locationInView:self]];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    _currentTouchNumber = [event allTouches].count;
    for (UITouch *touch in [event allTouches]) {
        [self touchAtPoint:[touch locationInView:self]];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _currentTouchNumber = 0;
    for (__unused UITouch *touch in [event allTouches]) {
        [self leaveKeys];
    }
}

#pragma mark - Local

- (NSInteger)tagForTouchAtPoint:(CGPoint)point {
    CGPoint lNewPoint = CGPointMake(point.x - self.blackKeySize.width, point.y);
    NSUInteger lKeyIndex = lNewPoint.x / self.whiteKeySize.width;

    if ((CGRectContainsPoint(CGRectMake(self.whiteKeySize.width * lKeyIndex + 5.0, 0, self.blackKeySize.width, self.blackKeySize.height), CGPointMake(lNewPoint.x , lNewPoint.y))) && ([KZKey isKeyBlack:lKeyIndex + 1002])) {
            return lKeyIndex + 1001;
    }
    return point.x / self.whiteKeySize.width + 1;
}

- (void)touchAtPoint:(CGPoint)touchPoint {
    KZKey *lKey = [[self.subviews filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"tag == %i",[self tagForTouchAtPoint:touchPoint]]] firstObject];
    
    if ([lKey isKindOfClass:[KZKey class]]) {
        lKey.highlighted = YES;
        if (![self.pressedkeysArray containsObject:lKey]) {
            [self.pressedkeysArray addObject:lKey];
        }
    }
    [self leaveKeys];
}

- (void)leaveKeys {
    if (self.pressedkeysArray.count > _currentTouchNumber) {
        KZKey *lKey = self.pressedkeysArray.firstObject;
        lKey.highlighted = NO;
        [self.pressedkeysArray removeObject:lKey];
    }
}

@end



// - - - - - - - - KZPianoKeyboard - - - - - - -

@implementation KZPianoKeyboard

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat lOffset = 30;

        _pianoView = [[KZPianoView alloc] initWithFrame:CGRectMake(0, lOffset, self.bounds.size.width, frame.size.height - lOffset)];
        [self addSubview:_pianoView];
        
        KZPianoSlider *lPianoSlider = [[KZPianoSlider alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, lOffset)];
        lPianoSlider.delegate = self;
        lPianoSlider.thumbWidth = self.bounds.size.width * self.bounds.size.width / _pianoView.bounds.size.width;
        lPianoSlider.backgroundColor = [UIColor greenColor];
        [self addSubview:lPianoSlider];
    }
    return self;
}

- (void)KZPianoSlider:(id)sender valueChanged:(CGFloat)value {
//    _pianoView.center = CGPointMake(self.bounds.size.width * value, self.bounds.size.height / 2.0 + 15.0);
    _pianoView.contentOffset = CGPointMake(value * _pianoView.contentSize.width, 0);
}

@end

// - - - - - - - - KZPianoSlider - - - - - - -

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
        _thumb.center = CGPointMake(_position * self.bounds.size.width, self.bounds.size.height / 2.0);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint lTouchLocation = [event.allTouches.anyObject locationInView:self];
    _positionXDelta = _thumb.center.x - lTouchLocation.x;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint lTouchLocation = [event.allTouches.anyObject locationInView:self];
    CGFloat lNewPosition = (lTouchLocation.x + _positionXDelta) / self.bounds.size.width ;
    if (lNewPosition > 1) {
        lNewPosition = 1;
    }
    if (lNewPosition < 0) {
        lNewPosition = 0;
    }
    self.position = lNewPosition;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint lTouchLocation = [event.allTouches.anyObject locationInView:self];
    _positionXDelta = lTouchLocation.x;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        _thumb = [[UIImageView alloc] initWithFrame: CGRectMake(0.0, 0.0, 30.0, 30.0)];
        _thumb.backgroundColor = [UIColor blackColor];
        _thumb.alpha = 0.5;

        self.position = 0.5;
        [self addSubview:_thumb];
    }
    return self;
}

@end