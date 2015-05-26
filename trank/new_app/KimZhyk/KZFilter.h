//
//  KZFilter.h
//  KimZhyk
//
//  Created by Ihor on 5/12/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <complex.h>

@interface KZFilter : NSObject

- (NSDictionary *)GetJoinedSpectrum:(NSArray *)spectrum0:(NSArray *)spectrum1:(double)shiftsPerFrame:(double)sampleRate;
- (NSDictionary *)antialiasing:(NSDictionary *)spectrum;
@end
