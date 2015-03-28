//
//  KZFileManager.m
//  KimZhyk
//
//  Created by Ihor Koblan on 3/26/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZFileManager.h"

#define DEFAULT_FOLDER_PATH @"voice_items_folder"

@implementation KZFileManager

+ (KZFileManager *)manager {
    static KZFileManager *lManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lManager = [KZFileManager new];
    });
    return lManager;
}

+ (NSString *)defaultFolderPath {
    NSString *lFolderPath = [DOCUMENTS stringByAppendingPathComponent:DEFAULT_FOLDER_PATH];
    if (![[NSFileManager defaultManager] fileExistsAtPath:lFolderPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:lFolderPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    return lFolderPath;
}

+ (NSArray *)itemsAtFolderPath:(NSString *)path {
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
}

+ (NSArray *)itemsAtDefaultFolder {
   return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[KZFileManager defaultFolderPath] error:nil];
}

+ (BOOL)saveToDefaultFolderWithTitle:(NSString *)title {
    return NO;
}

+ (BOOL)removeFileAtPath:(NSString *)path {
    NSError *error;
    return [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
}

+ (BOOL)removeFileWithTitle:(NSString *)fileTitle {
    return 0;
}

+ (BOOL)fileExistAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

@end
