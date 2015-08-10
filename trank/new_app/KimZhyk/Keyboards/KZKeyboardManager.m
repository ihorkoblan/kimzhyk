//
//  KZKeyboardManager.m
//  KimZhyk
//
//  Created by Ihor on 5/22/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZKeyboardManager.h"
#import "EPSSampler.h"
#import "PianoView.h"
#import "KZNoteRecorder.h"
@interface KZKeyboardManager() <PianoViewDelegate> {
    KZNoteRecorder *_noteRecorder;
}
@property (nonatomic, strong) EPSSampler *sampler;
@end

@implementation KZKeyboardManager

- (instancetype)initWithPiano:(PianoView *)pianoView {
    self = [super init];
    if (self) {
        pianoView.delegate = self;
        
        NSURL *presetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Trombone" ofType:@"aupreset"]];
        self.sampler = [[EPSSampler alloc] initWithPresetURL:presetURL];
    }
    return self;
}

- (void)setInstrument:(Instrument)instrument {
    _instrument = instrument;
    
    self.sampler.presetURL = [KZInstrumentsHelper aupresetFileNameForInstrument:instrument];
}

- (void)pianoView:(PianoView *)piano keyDown:(short)key {
    [self.sampler startPlayingNote:key withVelocity:1.0];
    
}

- (void)pianoView:(PianoView *)piano keyUp:(short)key {
    [self.sampler stopPlayingNote:key];
    
}

@end
