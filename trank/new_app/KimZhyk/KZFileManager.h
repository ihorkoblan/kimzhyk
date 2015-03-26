//
//  KZFileManager.h
//  KimZhyk
//
//  Created by Ihor Koblan on 3/26/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@interface KZFileManager : NSObject

+ (KZFileManager *)manager;

@end
