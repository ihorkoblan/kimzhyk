//
//  KZGlobal.h
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#ifndef KimZhyk_KZGlobal_h
#define KimZhyk_KZGlobal_h

#define VKSafeTimerRelease(Timer) \
if (Timer != nil) {\
if ([Timer isValid]) {\
[Timer invalidate];\
Timer = nil;\
} \
}

#define XSafeRelease(Object) \
if (Object != nil) {\
[Object release];\
Object = nil;\
}

//debug log
#ifdef DEBUG
# define DLog(...) NSLog(__VA_ARGS__)
#else
# define DLog(...) /* */
#endif
#define ALog(...) NSLog(__VA_ARGS__)

#define IS_IPHONE_5 ([UIScreen mainScreen].bounds.size.height == 568.0)

#endif

