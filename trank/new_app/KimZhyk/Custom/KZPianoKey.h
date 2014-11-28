//
//  KZPianoKey.h
//  KimZhyk
//
//  Created by Igor Koblan on 4/30/14.
//  Copyright (c) 2014 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZKey.h"

@protocol KZPianoKeyDelegate <NSObject>

- (void)KZPianoKeyDidDragAndLeave;

@end

@interface KZPianoKey : KZKey

@property (nonatomic,assign) id<KZPianoKeyDelegate> delegate;

@end