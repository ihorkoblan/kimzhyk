//
//  KZInstrumentsHelper.h
//  KimZhyk
//
//  Created by Ihor on 5/26/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, Instrument) {
    instrumentPiano,
    instrumentTrombone,
    instrumentAccordeon,
    instrumentTennorSax,
    instrumentChurchOrgan,
    instrumentFlute,
    instrumentCello,
    instrumentAcousticGuitar,
};

@interface KZInstrumentsHelper : NSObject
+ (NSURL *)aupresetFileNameForInstrument:(Instrument)intrument;
+ (NSArray *)instrumentImageNames;
@end
