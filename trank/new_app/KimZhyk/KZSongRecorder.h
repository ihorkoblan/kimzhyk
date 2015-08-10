//
//  KZSongRecorder.h
//  KimZhyk
//
//  Created by Ihor on 6/6/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZSongRecorder : NSObject

@property (nonatomic, assign) BOOL isSongLoaded;

- (BOOL)saveSongWithName:(NSString *) name;
- (void)startRecord;
- (void)stopRecord;
@end
