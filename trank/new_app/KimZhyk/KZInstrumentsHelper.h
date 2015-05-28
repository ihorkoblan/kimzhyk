//
//  KZInstrumentsHelper.h
//  KimZhyk
//
//  Created by Ihor on 5/26/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString  * const kInstrumentImageKey    = @"instrument_image_key";
static NSString  * const kInstrumentAupresetKey = @"instrument_aupreset_key";
static NSString  * const kInstrumentTypeKey     = @"instrument_type_key";
static NSString  * const kInstrumentNameKey     = @"instrument_name_key";

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

+ (NSDictionary *)dictionaryForInstrument:(Instrument)instrument;
+ (NSURL *)aupresetFileNameForInstrument:(Instrument)intrument;
+ (NSArray *)instrumentImageNames;

@end