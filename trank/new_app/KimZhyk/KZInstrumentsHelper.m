//
//  KZInstrumentsHelper.m
//  KimZhyk
//
//  Created by Ihor on 5/26/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZInstrumentsHelper.h"



@implementation KZInstrumentsHelper

+ (NSURL *)aupresetFileNameForInstrument:(Instrument)intrument {
    NSURL *lAupresetURL = nil;
    for (NSInteger insCount = 0; insCount < [KZInstrumentsHelper instrumentImageNames].count; insCount++) {
        
        DLog(@"%li__ %@",(long)insCount,[KZInstrumentsHelper instrumentImageNames][insCount][kInstrumentImageKey]);
        DLog(@"%li__ %@",(long)insCount,[KZInstrumentsHelper instrumentImageNames][insCount][kInstrumentAupresetKey]);
        DLog(@"%li__ %@",(long)insCount,[KZInstrumentsHelper instrumentImageNames][insCount][kInstrumentTypeKey]);
        
        if ([[KZInstrumentsHelper instrumentImageNames][insCount][kInstrumentTypeKey] integerValue] == intrument) {
            NSURL *lTempURL = [KZInstrumentsHelper instrumentImageNames][insCount][kInstrumentAupresetKey];
            if (lTempURL) {
                lAupresetURL = lTempURL;
                break;
            }
        }
    }
    return lAupresetURL;
}

+ (NSArray *)instrumentImageNames {
    
    return @[
                 @{
                     kInstrumentImageKey        : @"PIANO.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"piano" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentPiano)
                  },
                 @{
                     kInstrumentImageKey        : @"TRUMPET_1.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Trombone" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentTrombone)
                     },
                 @{
                     kInstrumentImageKey        : @"ACCORDEON.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"accordeon" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentAccordeon)
                     },
                 @{
                     kInstrumentImageKey        : @"TENOR_SAX.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tenor_sax" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentTennorSax)
                     },
                 @{
                     kInstrumentImageKey        : @"CHURCH_ORGAN.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"church_organ" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentChurchOrgan)
                     },
                 @{
                     kInstrumentImageKey        : @"FLUTE.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"flute" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentFlute)
                     },
                 @{
                     kInstrumentImageKey        : @"CELLO.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cello" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentCello)
                     },
                 @{
                     kInstrumentImageKey        : @"ACOUSTIC_GUITAR.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"acoustic_guitar" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentAcousticGuitar)
                     },
            ];
}

@end
