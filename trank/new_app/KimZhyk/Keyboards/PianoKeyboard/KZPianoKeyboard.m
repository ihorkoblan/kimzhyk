//
//  KZPianoKeyboard.m
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZPianoKeyboard.h"
#import "KZPianoKey.h"
#import "KZPianoSlider.h"

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

- (void)startPlayingSound:(KZSound *)sound {
    KZKey *lKey = (KZKey *)[self viewWithTag:sound.tone.octave * 12 + sound.tone.note];
    lKey.highlighted = YES;
}

- (void)stopPlayingSound:(KZSound *)sound {
    KZKey *lKey = (KZKey *)[self viewWithTag:sound.tone.octave * 12 + sound.tone.note];
    lKey.highlighted = NO;
}

- (NSMutableArray *)pressedkeysArray {
    if (_pressedkeysArray == nil) {
        _pressedkeysArray = [NSMutableArray new];
    }
    return _pressedkeysArray;
}

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
        self.numberOfWhiteKeys = 35;
        
        [self mainInit];
        _currentTouchNumber = 0;
    }
    return self;
}

- (void)mainInit {

    CGFloat lMarginX = 0.0;
    CGFloat lMarginY = 0.0;
    NSInteger lTagIndex = 0;
    
    self.contentSize = CGSizeMake(self.numberOfWhiteKeys * self.whiteKeySize.width - self.bounds.size.width, self.whiteKeySize.height);
    
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(KZPianoView:pressedKey:)]) {
                [self.delegate performSelector:@selector(KZPianoView:pressedKey:) withObject:self withObject:lKey];
            }
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
        _pianoView.delegate = self;
        [self addSubview:_pianoView];
        
        KZPianoSlider *lPianoSlider = [[KZPianoSlider alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, lOffset)];
        lPianoSlider.delegate = self;
        lPianoSlider.thumbWidth = self.bounds.size.width * self.bounds.size.width / _pianoView.contentSize.width;
        lPianoSlider.backgroundColor = [UIColor greenColor];
        [self addSubview:lPianoSlider];
    }
    return self;
}

- (void)KZPianoSlider:(id)sender valueChanged:(CGFloat)value {
    _pianoView.contentOffset = CGPointMake(value * (_pianoView.contentSize.width ), 0);
}

- (void)KZPianoView:(id)pianoView pressedKey:(KZKey *)key {
    NSLog(@"key.tag: %i",key.tag);
}

- (void)startPlayingSound:(KZSound *)sound {
    [_pianoView startPlayingSound:sound];
}

- (void)stopPlayingSound:(KZSound *)sound {
    [_pianoView stopPlayingSound:sound];
}

@end