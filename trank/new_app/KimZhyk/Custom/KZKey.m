//
//  KZKey.m
//  KimZhyk
//
//  Created by Igor Koblan on 4/30/14.
//  Copyright (c) 2014 HostelDevelopers. All rights reserved.
//

#import "KZKey.h"

@implementation KZKey
@synthesize keyType = _keyType;
@synthesize sound = _sound;
@synthesize pressedNow = _pressedNow;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (id)initWithKeyType:(KZPianoKeyType)pKeyType {
    self = [super init];
    if (self) {
        _keyType = pKeyType;
        self.pressedNow = NO;
        self.exclusiveTouch = NO;
    }
    return self;
}

- (void)startPlayingSound {
    self.pressedNow = YES;
}

- (void)stopPlayingSound {
    self.pressedNow = NO;
}

+ (BOOL)isKeyBlack:(NSInteger)keyTag {
    return !((keyTag % 7 == 0) || ((keyTag - 3) % 7 == 0));
}
@end
