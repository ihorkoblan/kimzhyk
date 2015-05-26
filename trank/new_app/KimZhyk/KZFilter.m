//
//  KZFilter.m
//  KimZhyk
//
//  Created by Ihor on 5/12/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZFilter.h"
#import <math.h>
#import <complex.h>

const double SinglePi = M_PI;
const double DoublePi = 2*M_PI;

@implementation KZFilter

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSDictionary *)GetJoinedSpectrum:(NSArray *)spectrum0:(NSArray *)spectrum1:(double)shiftsPerFrame:(double)sampleRate {
    double frameSize = spectrum0.count;
    double frameTime = frameSize/sampleRate;
    double shiftTime = frameTime/shiftsPerFrame;
    double binToFrequancy = sampleRate/frameSize;
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    for (int bin = 0; bin < frameSize; bin++) {
        double omegaExpected = DoublePi*(bin*binToFrequancy); // ω=2πf
        double omegaActual = ( [((NSNumber *)spectrum1[bin][@"Phase"]) doubleValue] - [spectrum0[bin][@"Phase"] doubleValue])/shiftTime; // ω=∂φ/∂t
        double omegaDelta = [self alignWithAngle:(omegaActual - omegaExpected) period:DoublePi];// Δω=(∂ω + π)%2π - π
        double binDelta = omegaDelta/(DoublePi*binToFrequancy);
        
        double frequancyActual = (bin + binDelta)*binToFrequancy;
        double magnitude = [(NSNumber *)spectrum1[bin][@"Magnitude"] doubleValue] + [(NSNumber *)spectrum0[bin][@"Magnitude"] doubleValue];
        [dictionary setObject:@(frequancyActual) forKey:@(magnitude*(0.5 + fabs(binDelta)))];
    }
    return dictionary;
}

- (double) alignWithAngle:(double)angle period:(double)period {
    int qpd = (int) (angle/period);
    if (qpd >= 0) {
        qpd += qpd & 1;
    } else {
        qpd -= qpd & 1;
    }
    angle -= period * qpd;
    return angle;
}

- (NSDictionary *)antialiasing:(NSDictionary *)spectrum {
    NSMutableDictionary *result = [NSMutableDictionary new];

    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:spectrum];
    
    for (int j = 0; j < spectrum.count - 4; j++) {
        int i = j;
        double x0 = [data.allKeys[i] doubleValue];
        double x1 = [data.allKeys[i + 1] doubleValue];
        double y0 = [data.allValues[i] doubleValue];
        double y1 = [data.allValues[i + 1] doubleValue];

        double a = (y1 - y0)/(x1 - x0);
        double b = y0 - a*x0;

        i += 2;
        double u0 = [data.allKeys[i] doubleValue];
        double u1 = [data.allKeys[i + 1] doubleValue];
        double v0 = [data.allValues[i] doubleValue];
        double v1 = [data.allValues[i + 1] doubleValue];

        double c = (v1 - v0)/(u1 - u0);
        double d = v0 - c*u0;

        double x = (d - b)/(a - c);
        double y = (a*d - b*c)/(a - c);

        if (y > y0 && y > y1 && y > v0 && y > v1 &&
            x > x0 && x > x1 && x < u0 && x < u1) {
            [result setObject:@(x1) forKey:@(y1)];
            [result setObject:@(x) forKey:@(y)];
            
        } else {
            [result setObject:@(x1) forKey:@(y1)];
        }
    }
    
    return result;
}

@end
