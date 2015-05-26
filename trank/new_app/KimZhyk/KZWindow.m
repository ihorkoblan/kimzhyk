//
//  KZRainbow.m
//  KimZhyk
//
//  Created by Ihor on 5/12/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZWindow.h"

const double Q = 0.5;
@implementation KZWindow

- (double)Gausse:(double)n:(double)frameSize {
    double a = (frameSize - 1)/2;
    double t = (n - a)/(Q*a);
    t = t*t;
    return exp(-t/2);
}

- (double)Hamming:(double)n :(double)frameSize {
    return 0.54 - 0.46*cos((2*M_PI*n)/(frameSize - 1));
}

- (double)Hann:(double)n :(double)frameSize {
    return 0.5*(1 - cos((2*M_PI*n)/(frameSize - 1)));
}

- (double)BlackmannHarris:(double)n :(double)frameSize {
    return 0.35875 - (0.48829*cos((2*M_PI*n)/(frameSize - 1))) +
    (0.14128*cos((4*M_PI*n)/(frameSize - 1))) - (0.01168*cos((4*M_PI*n)/(frameSize - 1)));
}

@end
