//
//  KZRainbow.h
//  KimZhyk
//
//  Created by Ihor on 5/12/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>


@interface KZWindow : NSObject

- (double)Gausse:(CGFloat)n: frameSize:(CGFloat)frameSize;
- (double)Hamming:(CGFloat)n: frameSize:(CGFloat)frameSize;
- (double)Hann:(CGFloat)n: frameSize:(CGFloat)frameSize;
- (double)BlackmannHarris:(CGFloat)n: frameSize:(CGFloat)frameSize;

@end
