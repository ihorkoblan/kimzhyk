//
//  KZRainbow.h
//  KimZhyk
//
//  Created by Ihor on 5/12/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZFilter.h"
#import "KZWindow.h"
#import "KZButterfly.h"
#import "KZFFTHelper.h"

@interface KZRainbow : NSObject
@property (nonatomic, strong) KZFilter *filter;
@property (nonatomic, strong) KZWindow *window;
@property (nonatomic, strong) KZButterfly *butterfly;
@property (nonatomic, strong) KZFFTHelper *fftHelper;
+ (KZRainbow *)instance;
@end
