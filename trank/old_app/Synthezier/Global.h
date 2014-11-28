//
//  Global.h
//  Resume
//
//  Created by Volodymyr Shevchyk on 2/7/12.
//  Copyright (c) 2012 Vakoms. All rights reserved.
//

#ifndef Resume_Global_h
#define Resume_Global_h

#define VKSafeRelease(object) \
if (object != nil) { \
    [object release]; \
    object = nil; \
}
#define SafeTimerRelease(Timer) if (Timer != nil) {if ([Timer isValid]) {[Timer invalidate];} Timer = nil;}
#ifdef DEBUG 
# define DLog(...) NSLog(__VA_ARGS__) 
#else 
# define DLog(...) /* */
#endif 
#define ALog(...) NSLog(__VA_ARGS__)

#define START_VOLUME_VALUE 60
#define START_TRANSPOSE_VALUE 0
#define STANDART_TRANSPOSE_VALUE 47
#define WHITE_KEY_WIDTH 51
#define BLACK_KEY_WIDTH 40
#define BLACK_KEY_HEIGHT 120
#define WHITE_KEY_HEIGHT 200
#define START_X_POSITION_TO_WHITE_KEY 0
#define START_X_POSITION_TO_BLACK_KEY 80
#define WHITE_KEYS_SUM 35
#define WHITE_KEYS_IN_OCTAVA 7
#define BLACK_KEYS_IN_OCTAVA 5

//Getting device name
#define IPHONE @"iPhone"
#define IPAD @"iPad"

CG_INLINE NSString *deviceType()
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
	if( UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM() )
		return IPAD;
	else
		return IPHONE;
#else
	return IPHONE;
#endif
}

#endif
