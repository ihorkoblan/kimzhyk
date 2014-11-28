//
//  KZSettings.m
//  Synthezier
//
//  Created by ihor on 07.07.14.
//
//

#import "KZSettings.h"

@implementation KZSettings

@synthesize volume = _volume;
@synthesize transpose = _transpose;
@synthesize instrumentType = _instrumentType;

+ (KZSettings *)settings {
    static KZSettings *lInstance = nil;
    static dispatch_once_t lOnceToken;
    dispatch_once(&lOnceToken, ^{
        lInstance = [self new];
    });
    return lInstance;
}

@end
