//
//  KZPianoKeyboard.m
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZPianoKeyboard.h"
#import "KZPianoKey.h"

@interface KZPianoKeyboard() {
    NSUInteger _currentTouchNumber;
}

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSMutableArray *pressedkeysArray;

@property (nonatomic, assign) CGSize whiteKeySize;
@property (nonatomic, assign) CGSize blackKeySize;
@property (nonatomic, assign) NSUInteger numberOfWhiteKeys;
@end;

@implementation KZPianoKeyboard

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height )];
        _contentView.userInteractionEnabled = YES;
        _contentView.backgroundColor = [UIColor brownColor];
        [self addSubview:_contentView];
    }
    return _contentView;
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
        
        self.whiteKeySize = CGSizeMake(50, 200);
        self.blackKeySize = CGSizeMake(30, 120);
        self.numberOfWhiteKeys = 11;
        [self mainInit];
        _currentTouchNumber = 0;
    }
    return self;
}

- (void)mainInit {
    self.userInteractionEnabled = YES;
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
        NSLog(@"tagW: %li",(long)lKey.tag);
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

