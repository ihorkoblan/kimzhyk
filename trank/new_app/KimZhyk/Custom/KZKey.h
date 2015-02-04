//
//  KZKey.h
//  KimZhyk
//
//  Created by Igor Koblan on 4/30/14.
//  Copyright (c) 2014 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZSound.h"
typedef enum {
    KZPianoKeyTypeWhite = 0,
    KZPianoKeyTypeBlack = 1,
}KZPianoKeyType;

@interface KZKey : UIImageView

@property (assign) KZPianoKeyType keyType;
- (id)initWithKeyType:(KZPianoKeyType)pKeyType;

@property (retain) KZSound *sound;
@property (assign) BOOL pressedNow;

- (void)startPlayingSound;
- (void)stopPlayingSound;

+ (BOOL)isKeyBlack:(NSInteger)keyTag;

@end
