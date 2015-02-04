//
//  KZPianoKeyboard.m
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZPianoKeyboard.h"
#import "KZPianoKey.h"
#import "Common.h"

NSString const *constStr = @"const str";

#define NUMBER_OF_BLACK_KEYS_IN_OCTAVE 5
#define NUMBER_OF_WHITE_KEYS_IN_OCTAVE 7
#define NUMBER_OF_KEYS_IN_OCTAVE NUMBER_OF_BLACK_KEYS_IN_OCTAVE + NUMBER_OF_WHITE_KEYS_IN_OCTAVE

#define WHITE_KEY_WIDTH 50.0
#define WHITE_KEY_HEIGHT 200.0

#define BLACK_KEY_WIDTH 30.0
#define BLACK_KEY_HEIGHT 120.0

@interface KZPianoKeyboard()

@property (nonatomic, strong) NSArray *keysArray;
@property (nonatomic, strong) NSArray *blackKeysArray;

@property (nonatomic, strong) NSMutableArray *pressedkeysArray;
@property (nonatomic, strong) NSMutableArray *pressedBlackkeysArray;
@end;

@implementation KZPianoKeyboard
@synthesize keysArray = _keysArray;
@synthesize blackKeysArray = _blackKeysArray;

- (NSMutableArray *)pressedkeysArray {
    if (_pressedkeysArray == nil) {
        _pressedkeysArray = [NSMutableArray new];
    }
    return _pressedkeysArray;
}

- (NSMutableArray *)pressedBlackkeysArray {
    if (_pressedBlackkeysArray == nil) {
        _pressedBlackkeysArray = [NSMutableArray new];
    }
    return _pressedBlackkeysArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self mainInit];
    }
    return self;
}

- (void)mainInit {
    self.userInteractionEnabled = YES;
    CGFloat lMarginX = 0.0;
    CGFloat lMarginY = 0.0;
    
    NSUInteger lNumberOfKeys = 11;
    NSInteger lTagIndex = 0;
    for (NSUInteger keyIndex = 0; keyIndex < lNumberOfKeys; keyIndex++) {
        
        
        if ([KZKey isKeyBlack:keyIndex]) {
            KZKey *lBlackKey = [[KZKey alloc] initWithFrame:CGRectMake(-BLACK_KEY_WIDTH / 2.0 + keyIndex * ((WHITE_KEY_WIDTH)) , lMarginY, BLACK_KEY_WIDTH, BLACK_KEY_HEIGHT)];
            lBlackKey.tag = ++lTagIndex;
            NSLog(@"tagB: %li",(long)lBlackKey.tag);
            [lBlackKey setImage:[UIImage imageNamed:@"Black_key.png"]];
            [lBlackKey setHighlightedImage:[UIImage imageNamed:@"Black_key_active.png"]];
            lBlackKey.keyType = KZPianoKeyTypeBlack;
            lBlackKey.userInteractionEnabled = NO;
            lBlackKey.layer.zPosition = MAXFLOAT;
            [self addSubview:lBlackKey];
        }
        
        KZKey *lKey = [[KZKey alloc] initWithFrame:CGRectMake(lMarginX + keyIndex * (WHITE_KEY_WIDTH), lMarginY, WHITE_KEY_WIDTH, WHITE_KEY_HEIGHT)];
        [lKey setImage:[UIImage imageNamed:@"White_key.png"]];
        [lKey setHighlightedImage:[UIImage imageNamed:@"White_key_active.png"]];
        lKey.keyType = KZPianoKeyTypeWhite;
        lKey.tag = ++lTagIndex;
        NSLog(@"tagW: %li",(long)lKey.tag);
        lKey.userInteractionEnabled = NO;
        [self addSubview:lKey];
        
     
    }
}

#pragma mark - touch interruption handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    

    
    for (UITouch *touch in [event allTouches]) {
         CGPoint lTPoint = [touch locationInView:self];
        [self touchAtPoint:lTPoint];
    }
    
//    CGPoint lTouchPoint = [[touches anyObject] locationInView:self];
//    [self touchDownAtPoint:lTouchPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in [event allTouches]) {
        CGPoint lTPoint = [touch locationInView:self];
        [self touchAtPoint:lTPoint];
    }
//    CGPoint lTouchPoint = [[touches anyObject] locationInView:self];
//    [self touchDownAtPoint:lTouchPoint];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (__unused UITouch *touch in [event allTouches]) {
        [self touchUp];
    }
}

#pragma mark - touch handlers
- (NSInteger)tagForTouchPoint:(CGPoint)point {
    
    CGPoint lNewPoint = CGPointMake(point.x - BLACK_KEY_WIDTH, point.y);
    
    NSUInteger lKeyIndex = (lNewPoint.x ) / WHITE_KEY_WIDTH;
    
    UIView *lV = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, 2, 2)];
    
    lV.layer.zPosition = MAXFLOAT;
    [self addSubview:lV];
    
    if (CGRectContainsPoint(CGRectMake(WHITE_KEY_WIDTH * lKeyIndex , 0, BLACK_KEY_WIDTH, BLACK_KEY_HEIGHT), CGPointMake(lNewPoint.x  , lNewPoint.y))) {
        NSLog(@"black");
        lV.backgroundColor = [UIColor brownColor];
    } else {
        NSLog(@"white");
        lV.backgroundColor = [UIColor greenColor];
    }
    
    
    return lKeyIndex;
}
- (void)touchAtPoint:(CGPoint)touchPoint {
   
    KZKey *lKey = [[self.subviews filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"tag == %i",[self tagForTouchPoint:touchPoint]]] firstObject];
    
    if ([lKey isKindOfClass:[KZKey class]]) {
        lKey.highlighted = YES;
        if (![self.pressedkeysArray containsObject:lKey]) {
            [self.pressedkeysArray addObject:lKey];
        }
    }
    [self leaveKeyAndContinueMoving:YES];
}

- (void)touchUp {
    [self leaveKeyAndContinueMoving:NO];
}

- (void)leaveKeyAndContinueMoving:(BOOL)continueMove {
    if (self.pressedkeysArray.count > continueMove) {
        KZKey *lKey = self.pressedkeysArray.firstObject;
        lKey.highlighted = NO;
        [self.pressedkeysArray removeObject:lKey];
    }
}

@end

