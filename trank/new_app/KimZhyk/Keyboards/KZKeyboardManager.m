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

@interface KZKeyboardManager() <PianoViewDelegate>
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
    
    id lURL = [[KZInstrumentsHelper instrumentImageNames] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%@ == %@",kInstrumentTypeKey,@(_instrument)]];
    DLog(@"url: %@",lURL);
    
    
    self.sampler.presetURL = [KZInstrumentsHelper aupresetFileNameForInstrument:instrument];
}

- (void)pianoView:(PianoView *)piano keyDown:(short)key {
    DLog(@"key pressed :%i",key);
    [self.sampler startPlayingNote:key withVelocity:1.0];
}

- (void)pianoView:(PianoView *)piano keyUp:(short)key {
    DLog(@"key released: %i",key);
    [self.sampler stopPlayingNote:key];
}

@end
