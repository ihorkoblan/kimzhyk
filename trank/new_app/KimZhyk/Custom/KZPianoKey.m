//
//  KZPianoKey.m
//  KimZhyk
//
//  Created by Igor Koblan on 4/30/14.
//  Copyright (c) 2014 HostelDevelopers. All rights reserved.
//

#import "KZPianoKey.h"

@implementation KZPianoKey

@synthesize delegate = _delegate;

- (id)initWithKeyType:(KZPianoKeyType)pKeyType {
    self = [super initWithKeyType:pKeyType];
    if (self) {
        [self defaultKeyView];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)defaultKeyView {
    if (self.keyType == KZPianoKeyTypeWhite) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor blackColor];
    }
}

- (void)highlightedKeyView {
    if (self.keyType == KZPianoKeyTypeWhite) {
        self.backgroundColor = [UIColor grayColor];
    } else {
        self.backgroundColor = [UIColor grayColor];
    }
}

- (void)startPlayingSound {
    [super startPlayingSound];
    [self highlightedKeyView];
}

- (void)stopPlayingSound {
    [super stopPlayingSound];
    [self defaultKeyView];
}

@end
