//
//  KZSound.h
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kNoteA          = 1,
    kNoteADies      = 2,
    kNoteB          = 3,
    kNoteC          = 4,
    kNoteCDies      = 5,
    kNoteD          = 6,
    kNoteDDies      = 7,
    kNoteE          = 8,
    kNoteF          = 9,
    kNoteFDies      = 10,
    kNoteG          = 11,
    kNoteGDies      = 12,
} KZNote;

typedef enum {
    kOctaveSubKontr = 1,
    kOctaveKontr    = 2,
    kOctaveBig      = 3,
    kOctaveSmall    = 4,
    kOctaveFirst    = 5,
    kOctaveSecond   = 6,
    kOctaveThird    = 7,
    kOctaveFourth   = 8,
    kOctaveFifth    = 9,
} KZOctave;

typedef struct  {
    KZOctave octave;
    KZNote note;
}KZTone;

@interface KZSound : NSObject{
   
}

@property (nonatomic, assign) KZTone tone;
@property (nonatomic, assign) CGFloat frequency;
@property (nonatomic, assign) NSInteger noteNumber;

+ (KZSound *)soundWithTone:(KZTone)tone;
+ (KZSound *)soundWithFreq:(CGFloat)freq;
- (KZSound *)initSoundWithNoteNumber:(NSInteger)noteNumber;

@end
