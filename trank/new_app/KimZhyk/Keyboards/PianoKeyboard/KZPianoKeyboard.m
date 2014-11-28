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
#define WHITE_KEY_HEIGHT 120.0

#define BLACK_KEY_WIDTH 30.0
#define BLACK_KEY_HEIGHT 80.0

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

- (NSArray *)keysArray {
    if (_keysArray == nil) {
        _keysArray = [NSArray new];
    }
    return _keysArray;
}

- (NSArray *)blackKeysArray {
    if (_blackKeysArray == nil) {
        _blackKeysArray = [NSArray new];
    }
    return _blackKeysArray;
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
    
    NSUInteger lNumberOfKeys = 10;

    NSMutableArray *lTempArray = [NSMutableArray new];
    
    NSMutableArray *lTempBlackKeysArray = [NSMutableArray new];
    
    for (NSUInteger keyIndex = 0; keyIndex < lNumberOfKeys; keyIndex++) {
        
        KZKey *lKey = [[KZKey alloc] initWithFrame:CGRectMake(lMarginX + keyIndex * (WHITE_KEY_WIDTH + 1.0), lMarginY, WHITE_KEY_WIDTH, WHITE_KEY_HEIGHT)];
        lKey.backgroundColor = [UIColor redColor];
        lKey.keyType = KZPianoKeyTypeWhite;
        lKey.userInteractionEnabled = NO;
        [lTempArray addObject:lKey];
        [self addSubview:lKey];
        
        if ([KZKey isKeyBlack:keyIndex]) {
            KZKey *lBlackKey = [[KZKey alloc] initWithFrame:CGRectMake(-BLACK_KEY_WIDTH / 2.0 + keyIndex * ((WHITE_KEY_WIDTH + 1.0)) , lMarginY, BLACK_KEY_WIDTH, BLACK_KEY_HEIGHT)];
            lBlackKey.keyType = KZPianoKeyTypeBlack;
            lBlackKey.backgroundColor = [UIColor yellowColor];
            lBlackKey.userInteractionEnabled = NO;
            [self addSubview:lBlackKey];
            [lTempBlackKeysArray addObject:lBlackKey];
        }
    }
    _blackKeysArray = lTempBlackKeysArray;
    _keysArray = lTempArray;
}

#pragma mark - touch interruption handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    DLog(@"%i",[event allTouches].count);
    
    for (UITouch *touch in [event allTouches]) {
         CGPoint lTPoint = [touch locationInView:self];
        [self touchDownAtPoint:lTPoint];
    }
    
//    CGPoint lTouchPoint = [[touches anyObject] locationInView:self];
//    [self touchDownAtPoint:lTouchPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in [event allTouches]) {
        CGPoint lTPoint = [touch locationInView:self];
        [self touchDownAtPoint:lTPoint];
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

- (void)touchDownAtPoint:(CGPoint)touchPoint {
   
    NSPredicate *lPredicate = [NSPredicate predicateWithBlock:^BOOL(KZKey *evaluatedObject, NSDictionary *bindings) {
        return CGRectContainsPoint(evaluatedObject.frame, touchPoint);
    }];
    NSArray *lBlackKeys = [self.blackKeysArray filteredArrayUsingPredicate:lPredicate];
    if (lBlackKeys.count > 0) {
        KZKey *lKey = lBlackKeys[0];
        lKey.backgroundColor = [UIColor grayColor];
        
        if (![self.pressedkeysArray containsObject:lKey]) {
            [self.pressedkeysArray addObject:lKey];
        }
    } else {
        NSUInteger lKeyIndex = touchPoint.x / WHITE_KEY_WIDTH;
        KZKey *lKey = self.keysArray[lKeyIndex];
        lKey.backgroundColor = [UIColor blackColor];
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
        if (lKey.keyType == KZPianoKeyTypeBlack) {
            lKey.backgroundColor = [UIColor greenColor];
        } else {
            lKey.backgroundColor = [UIColor brownColor];
        }
        [self.pressedkeysArray removeObject:lKey];
    }
}

@end

