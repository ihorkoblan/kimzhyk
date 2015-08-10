//
//  KZPlayingOperation.h
//  KimZhyk
//
//  Created by Ihor on 6/7/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBNote.h"

@interface KZPlayingOperation : NSOperation

- (instancetype)initWithNote:(DBNote *)note;

@end
