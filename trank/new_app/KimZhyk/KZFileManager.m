//
//  KZFileManager.m
//  KimZhyk
//
//  Created by Ihor Koblan on 3/26/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZFileManager.h"

@implementation KZFileManager

+ (KZFileManager *)manager {
    static KZFileManager *lManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lManager = [KZFileManager new];
    });
    return lManager;
}

@end
