//
//  KZButton+Custom.m
//  KimZhyk
//
//  Created by Ihor on 5/26/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "UIButton+Custom.h"

@implementation UIButton(Custom)

+ (UIButton *)newInstrumentBtnWithSize:(CGSize)size {
    UIButton *lButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, size.width, size.height)];
    lButton.backgroundColor = [UIColor redColor];
    lButton.layer.cornerRadius = 10.0;
    lButton.layer.borderColor = [UIColor greenColor].CGColor;
    lButton.layer.borderWidth = 2.0;
    lButton.layer.masksToBounds = YES;
    return lButton;
}

@end
