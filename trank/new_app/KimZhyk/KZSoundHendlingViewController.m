//
//  KZSoundHendlingViewController.m
//  KimZhyk
//
//  Created by Ihor Koblan on 3/31/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZSoundHendlingViewController.h"
#import "EZAudio/EZAudio.h"
#import "KZFileManager.h"

@interface KZSoundHendlingViewController ()  {
    AudioBufferList *readBuffer;
    
    COMPLEX_SPLIT _A;
    FFTSetup      _FFTSetup;
    BOOL          _isFFTSetup;
    vDSP_Length   _log2n;
    NSMutableArray *_frequencies;
}
#pragma mark - Components
/**
 The EZAudioFile representing of the currently selected audio file
 */
@property (nonatomic,strong) EZAudioFile *audioFile;

/**
 The CoreGraphics based audio plot
 */
@property (nonatomic,weak) IBOutlet EZAudioPlot *audioPlot;
@property (nonatomic,weak) IBOutlet EZAudioPlot *audioPlotFreq;
/**
 A BOOL indicating whether or not we've reached the end of the file
 */
@property (nonatomic,assign) BOOL eof;

@end


#define kAudioFileDefault [[NSBundle mainBundle] pathForResource:@"simple-drum-beat" ofType:@"wav"]
@implementation KZSoundHendlingViewController
@synthesize pathURL = _pathURL;
@synthesize audioPlot = _audioPlot;
@synthesize audioFile = _audioFile;
@synthesize eof = _eof;

- (instancetype)initWithSoundPathURL:(NSURL *)url {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        _pathURL = url;
        _frequencies = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     Customizing the audio plot's look
     */
    // Background color
    self.audioPlot.backgroundColor = [UIColor colorWithRed: 0.169 green: 0.643 blue: 0.675 alpha: 1];
    // Waveform color
    self.audioPlot.color           = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    // Plot type
    self.audioPlot.plotType        = EZPlotTypeBuffer;
    // Fill
    self.audioPlot.shouldFill      = YES;
    // Mirror
    self.audioPlot.shouldMirror    = YES;
    
    /*
     Load in the sample file
     */
    
    [self openFileWithFilePathURL:[[NSURL alloc] initFileURLWithPath:_pathURL.path]];
    
    // Setup frequency domain audio plot
    self.audioPlotFreq.backgroundColor = [UIColor colorWithRed: 0.984 green: 0.471 blue: 0.525 alpha: 1];
    self.audioPlotFreq.color           = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.audioPlotFreq.shouldFill      = YES;
    self.audioPlotFreq.plotType        = EZPlotTypeBuffer;
}

#pragma mark - Action Extensions
-(void)openFileWithFilePathURL:(NSURL*)filePathURL {
    
    self.audioFile          = [EZAudioFile audioFileWithURL:filePathURL];
    self.eof                = NO;

    DLog(@"file: %@",filePathURL.lastPathComponent);
    // Plot the whole waveform
    self.audioPlot.plotType        = EZPlotTypeBuffer;
    self.audioPlot.shouldFill      = YES;
    self.audioPlot.shouldMirror    = YES;
    [self.audioFile getWaveformDataWithCompletionBlock:^(float *waveformData, UInt32 length) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.audioPlot updateBuffer:waveformData withBufferSize:length];
      
            
            // Setup the FFT if it's not already setup
            if( !_isFFTSetup ){
                [self createFFTWithBufferSize:length withAudioData:waveformData];
                _isFFTSetup = YES;
            }
            
            // Get the FFT data
            [self updateFFTWithBufferSize:length withAudioData:waveformData];
            
        });

    }];
    
}

#pragma mark - FFT
/**
 Adapted from http://batmobile.blogs.ilrt.org/fourier-transforms-on-an-iphone/
 */
-(void)createFFTWithBufferSize:(float)bufferSize withAudioData:(float*)data {
    
    // Setup the length
    _log2n = log2f(bufferSize);
    
    // Calculate the weights array. This is a one-off operation.
    _FFTSetup = vDSP_create_fftsetup(_log2n, FFT_RADIX2);
    
    // For an FFT, numSamples must be a power of 2, i.e. is always even
    int nOver2 = bufferSize/2;
    
    // Populate *window with the values for a hamming window function
    float *window = (float *)malloc(sizeof(float)*bufferSize);
    vDSP_hamm_window(window, bufferSize, 0);
    // Window the samples
    vDSP_vmul(data, 1, window, 1, data, 1, bufferSize);
    free(window);
    
    // Define complex buffer
    _A.realp = (float *) malloc(nOver2*sizeof(float));
    _A.imagp = (float *) malloc(nOver2*sizeof(float));
    
}

-(void)updateFFTWithBufferSize:(float)bufferSize withAudioData:(float*)data {
    
    // For an FFT, numSamples must be a power of 2, i.e. is always even
    int nOver2 = bufferSize/2;
    
    // Pack samples:
    // C(re) -> A[n], C(im) -> A[n+1]
    vDSP_ctoz((COMPLEX*)data, 2, &_A, 1, nOver2);
    
    // Perform a forward FFT using fftSetup and A
    // Results are returned in A
    vDSP_fft_zrip(_FFTSetup, &_A, 1, _log2n, FFT_FORWARD);
    
    // Convert COMPLEX_SPLIT A result to magnitudes
    float amp[nOver2];
    float maxMag = 0;
    
    NSInteger bin = -1;
    for(int i=0; i<nOver2; i++) {
        // Calculate the magnitude
        float mag = _A.realp[i]*_A.realp[i]+_A.imagp[i]*_A.imagp[i];
        if (mag > maxMag) {
            maxMag = mag;
            bin = i;
        }
    }
    
    CGFloat delta = 100.0;
    for (int i=0; i<nOver2; i++) {
        float mag = _A.realp[i]*_A.realp[i]+_A.imagp[i]*_A.imagp[i];
        if (mag > fabsf(maxMag * 0.8)) {
            [_frequencies addObject:@(mag)];
        }
    }
    
    DLog(@"_frequencies: %@",_frequencies);
//    float freq = bin*(THIS->sampleRate/bufferCapacity);
    float freq = bin * (44100 / 1024);
    
    
    for(int i=0; i<nOver2; i++) {
        // Calculate the magnitude
        float mag = _A.realp[i]*_A.realp[i]+_A.imagp[i]*_A.imagp[i];
        // Bind the value to be less than 1.0 to fit in the graph
        amp[i] = [EZAudio MAP:mag leftMin:0.0 leftMax:maxMag rightMin:0.0 rightMax:1.0];
    }
    
    // Update the frequency domain plot
    [self.audioPlotFreq updateBuffer:amp
                      withBufferSize:nOver2];
}

@end
