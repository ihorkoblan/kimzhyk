//
//  KZFFTHelper.m
//  KimZhyk
//
//  Created by Ihor on 5/12/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZFFTHelper.h"
#import "EZAudio.h"

@implementation KZFFTHelper

-(DSPSplitComplex)createFFTWithBufferSize:(float)bufferSize withAudioData:(float*)data fftSetup:(FFTSetup*)fftSetup {
    
    // Setup the length
    vDSP_Length log2n = log2f(bufferSize);
    
    // Calculate the weights array. This is a one-off operation.
    *fftSetup = vDSP_create_fftsetup(log2n, FFT_RADIX2);
    
    // For an FFT, numSamples must be a power of 2, i.e. is always even
    int nOver2 = bufferSize/2;
    
    // Populate *window with the values for a hamming window function
    float *window = (float *)malloc(sizeof(float)*bufferSize);
    vDSP_hamm_window(window, bufferSize, 0);
    // Window the samples
    vDSP_vmul(data, 1, window, 1, data, 1, bufferSize);
    free(window);
    
    DSPSplitComplex A;
    // Define complex buffer
    A.realp = (float *) malloc(nOver2*sizeof(float));
    A.imagp = (float *) malloc(nOver2*sizeof(float));
    return A;
}

-(float*)updateFFTWithBufferSize:(float)bufferSize withAudioData:(float*)data fftSetup:(FFTSetup*)fftSetup result:(DSPSplitComplex*)resultA normalize: (BOOL)normalize {
    
    // For an FFT, numSamples must be a power of 2, i.e. is always even
    int nOver2 = bufferSize/2;
    
    // Pack samples:
    // C(re) -> A[n], C(im) -> A[n+1]
    vDSP_ctoz((COMPLEX*)data, 2, resultA, 1, nOver2);
    
    // Perform a forward FFT using fftSetup and A
    // Results are returned in A
    vDSP_Length log2n = log2f(bufferSize);
    vDSP_fft_zrip(*fftSetup, resultA, 1, log2n, FFT_FORWARD);
    
    // Convert COMPLEX_SPLIT A result to magnitudes
    float amp[nOver2];
    float maxMag = 0;
    
    NSInteger bin = -1;
    for(int i=0; i<nOver2; i++) {
        // Calculate the magnitude
        float mag = resultA->realp[i]*resultA->realp[i]+resultA->imagp[i]*resultA->imagp[i];
        if (mag > maxMag) {
            maxMag = mag;
            bin = i;
        }
    }

    //    float freq = bin*(THIS->sampleRate/bufferCapacity);
//    float freq = bin * (44100 / 1024);
    
    for(int i=0; i<nOver2; i++) {
        float mag = resultA->realp[i]*resultA->realp[i]+resultA->imagp[i]*resultA->imagp[i];
        if (normalize) {
            amp[i] = [EZAudio MAP:mag leftMin:0.0 leftMax:maxMag rightMin:0.0 rightMax:1.0];
        } else {
            amp[i] = mag;
        }
    }

    return amp;
}


@end
