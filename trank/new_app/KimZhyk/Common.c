//
//  Common.c
//  KimZhyk
//
//  Created by Admin on 12.11.14.
//  Copyright (c) 2014 HostelDevelopers. All rights reserved.
//

#include <stdio.h>
#include <math.h>
#include "Common.h"

int mask_add(int mask, int value) {
    return mask | value;
}

int mask_remove(int mask, int value) {
    return mask & ~value;
}

int value_from_iterator(int i) {
    return (int)pow(2, i);
}

bool mask_has_value(int mask, int value) {
    return (mask & value) == value;
}

int mask_count(int mask) {
    int N = mask;
    int counter = 0;
    while (N > 0) {
        int a = (int)( log2f(N) );
        N = N - pow(2, a);
        counter ++;
    }

    return counter;
}
