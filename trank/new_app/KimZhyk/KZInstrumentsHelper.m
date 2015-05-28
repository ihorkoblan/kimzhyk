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

+ (NSDictionary *)dictionaryForInstrument:(Instrument)instrument {
    NSDictionary *resDict = nil;
    for (NSInteger insCount = 0; insCount < [KZInstrumentsHelper instrumentImageNames].count; insCount++) {
        
        if ([[KZInstrumentsHelper instrumentImageNames][insCount][kInstrumentTypeKey] integerValue] == instrument) {
            NSDictionary *lTempDict = [KZInstrumentsHelper instrumentImageNames][insCount];
            if (lTempDict) {
                resDict = lTempDict;
                break;
            }
        }
    }
    return resDict;
}

+ (NSArray *)instrumentImageNames {
    return @[
                 @{
                     kInstrumentImageKey        : @"PIANO.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"piano" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentPiano),
                     kInstrumentNameKey         : @"Piano"
                  },
                 @{
                     kInstrumentImageKey        : @"TRUMPET_1.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Trombone" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentTrombone),
                     kInstrumentNameKey         : @"Trombone"
                     },
                 @{
                     kInstrumentImageKey        : @"ACCORDEON.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"accordeon" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentAccordeon),
                     kInstrumentNameKey         : @"Accordion"
                     },
                 @{
                     kInstrumentImageKey        : @"TENOR_SAX.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tenor_sax" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentTennorSax),
                     kInstrumentNameKey         : @"Sax"
                     },
                 @{
                     kInstrumentImageKey        : @"CHURCH_ORGAN.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"church_organ" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentChurchOrgan),
                     kInstrumentNameKey         : @"Organ"
                     },
                 @{
                     kInstrumentImageKey        : @"FLUTE.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"flute" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentFlute),
                     kInstrumentNameKey         : @"Flute"
                     },
                 @{
                     kInstrumentImageKey        : @"CELLO.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cello" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentCello),
                     kInstrumentNameKey         : @"Cello"
                     },
                 @{
                     kInstrumentImageKey        : @"ACOUSTIC_GUITAR.png",
                     kInstrumentAupresetKey     : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"acoustic_guitar" ofType:@"aupreset"]],
                     kInstrumentTypeKey         : @(instrumentAcousticGuitar),
                     kInstrumentNameKey         : @"Guitar"
                     },
            ];
}

@end
