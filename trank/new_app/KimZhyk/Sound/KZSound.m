//
//  KZSound.m
//  KimZhyk
//
//  Created by Admin on 12.11.14.
//  Copyright (c) 2014 HostelDevelopers. All rights reserved.
//

#import "KZSound.h"

@implementation KZSound

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (KZSound *)initSoundWithNoteNumber:(NSInteger)noteNumber {
    self = [super init];
    if (self) {
        self.noteNumber = noteNumber;
    }
    return self;
}

@end
