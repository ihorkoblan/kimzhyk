//
//  KZKeyboard.m
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZKeyboard.h"
#import "KZViewController.h"

@implementation KZKeyboard

@synthesize contentView = _contentView;

#pragma mark - life cicle

- (void)dealloc{
    [super dealloc];
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width - 20, self.bounds.size.height  - 50)];
        _contentView.userInteractionEnabled = YES;
        _contentView.backgroundColor = [UIColor brownColor];
//        [self addSubview:_contentView];
    }
    return _contentView;
}



@end