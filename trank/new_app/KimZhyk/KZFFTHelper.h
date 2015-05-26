//
//  KZFFTHelper.h
//  KimZhyk
//
//  Created by Ihor on 5/12/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accelerate/Accelerate.h>

@interface KZFFTHelper : NSObject

-(DSPSplitComplex)createFFTWithBufferSize:(float)bufferSize withAudioData:(float*)data fftSetup:(FFTSetup*)fftSetup;

-(void)updateFFTWithBufferSize:(float)bufferSize withAudioData:(float*)data fftSetup:(FFTSetup*)fftSetup result:(DSPSplitComplex*)resultA;

@end
