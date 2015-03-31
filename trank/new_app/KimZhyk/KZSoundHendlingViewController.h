//
//  KZSoundHendlingViewController.h
//  KimZhyk
//
//  Created by Ihor Koblan on 3/31/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

@interface KZSoundHendlingViewController : UIViewController

@property (nonatomic, strong, readonly) NSURL *pathURL;
- (instancetype)initWithSoundPathURL:(NSURL *)url;

@end
