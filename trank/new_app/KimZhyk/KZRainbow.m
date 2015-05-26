//
//  KZRainbow.m
//  KimZhyk
//
//  Created by Ihor on 5/12/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZRainbow.h"

@implementation KZRainbow

- (instancetype)init {
    self = [super init];
    if (self) {
        self.filter = [KZFilter new];
        self.window = [KZWindow new];
        self.butterfly = [KZButterfly new];
        self.fftHelper = [KZFFTHelper new];
    }
    return self;
}

+ (KZRainbow *)instance {
    static KZRainbow *lManager = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        lManager = [KZRainbow new];
    });
    return lManager;
}

@end
