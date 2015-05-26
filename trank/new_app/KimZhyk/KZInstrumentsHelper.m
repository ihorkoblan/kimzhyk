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
    
    switch (intrument) {
        case instrumentPiano: {
            lAupresetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"piano" ofType:@"aupreset"]];
            break;
        }
        case instrumentTrombone: {
            lAupresetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Trombone" ofType:@"aupreset"]];
            break;
        }
        case instrumentAccordeon: {
            lAupresetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"accordeon" ofType:@"aupreset"]];
            break;
        }
        case instrumentTennorSax: {
            lAupresetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tennor_sax" ofType:@"aupreset"]];
            break;
        }
        case instrumentChurchOrgan: {
            lAupresetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"church_organ" ofType:@"aupreset"]];
            break;
        }
        case instrumentFlute: {
            lAupresetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"flute" ofType:@"aupreset"]];
            break;
        }
        case instrumentCello: {
            lAupresetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cello" ofType:@"aupreset"]];
            break;
        }
        case instrumentAcousticGuitar: {
            lAupresetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"acoustic_guitar" ofType:@"aupreset"]];
            break;
        }
        default:
            break;
    }
    return lAupresetURL;
}

+ (NSArray *)instrumentImageNames {
    return @[@"PIANO.png",@"TRUMPET_1.png",@"ACCORDEON.png",@"TENOR_SAX.png",@"CHURCH_ORGAN.png",@"FLUTE.png",@"CELLO.png",@"ACOUSTIC_GUITAR.png"];;
}

@end
