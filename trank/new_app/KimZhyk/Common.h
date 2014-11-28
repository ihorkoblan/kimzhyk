//
//  Common.h
//  KimZhyk
//
//  Created by Admin on 12.11.14.
//  Copyright (c) 2014 HostelDevelopers. All rights reserved.
//

#ifndef KimZhyk_Comon_h
#define KimZhyk_Comon_h


#include <stdbool.h>

int mask_add(int mask, int value);
int mask_remove(int mask, int value);
int value_from_iterator(int i);
bool mask_has_value(int mask, int value);
int mask_count(int mask);
#endif
