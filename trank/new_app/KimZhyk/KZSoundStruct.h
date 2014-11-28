//
//  KZSoundStruct.h
//  KimZhyk
//
//  Created by Admin on 12.11.14.
//  Copyright (c) 2014 HostelDevelopers. All rights reserved.
//

#ifndef KimZhyk_KZSoundStruct_h
#define KimZhyk_KZSoundStruct_h

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

struct KZSoundStruct {
    KZNote note;
    KZOctave octave;
};


#endif
