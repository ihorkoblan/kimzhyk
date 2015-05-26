//
//  KZKeyboardManager.h
//  KimZhyk
//
//  Created by Ihor on 5/22/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PianoView.h"
#import "KZInstrumentsHelper.h"

@interface KZKeyboardManager : NSObject
@property (nonatomic, assign) Instrument instrument;
- (instancetype)initWithPiano:(PianoView *)pianoView;

//+ (KZKeyboardManager *)manager;

@end