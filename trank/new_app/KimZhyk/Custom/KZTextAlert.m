//
//  KZTextAlert.m
//  KimZhyk
//
//  Created by Ihor Koblan on 3/30/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZTextAlert.h"

@implementation KZTextAlert

+ (KZTextAlert *)textAlert {
    KZTextAlert *lResTextAlert = nil;
    NSArray *lNibs = [[NSBundle mainBundle] loadNibNamed:@"KZTextAlert" owner:nil options:nil];
    if (lNibs.count > 0) {
        lResTextAlert = lNibs[0];
    }
    return lResTextAlert;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
}

- (IBAction)buttonPressed:(id)sender {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(KZTextAlert:gotText:)]) {
//        [self.delegate KZTextAlert:self gotText:((UITextField *)sender).text];
//    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleField.text = @"";
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(KZTextAlert:gotText:)]) {
        [self.delegate KZTextAlert:self gotText:textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];
    return YES;
}

@end
