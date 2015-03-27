//
//  KZSettins.m
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZSettingsView.h"
#import "KZStaveView.h"

@implementation KZSettingsView
@synthesize delegate;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {


    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _instrumentsScrollView.layer.cornerRadius = 15.0f;
    _instrumentsScrollView.layer.masksToBounds = YES;
    _instrumentsScrollView.layer.borderWidth = 3.0f;
    _instrumentsScrollView.layer.borderColor = [UIColor whiteColor].CGColor;
}

+ (KZSettingsView *)settingsView {
    KZSettingsView *resultView = nil;
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"KZSettingsView" owner:nil options:nil];
    for (KZSettingsView *view in nibs) {
        if (view) {
            resultView = view;
            break;
        }
    }
    return resultView;
}

- (IBAction)buttonPressed:(id)sender {
    UIButton *currentBtn = sender;
    switch (currentBtn.tag) {
        case 1: {
            SEL selector = @selector(KZSettingView:backBtnPressed:);
            if (self.delegate && [self.delegate respondsToSelector:selector]) {
                [self.delegate performSelector:selector withObject:self withObject:sender];
            }
            break;
        }
        case 2: {
            SEL selector = @selector(KZSettingView:openInstrumentsBtnPressed:);
            if (self.delegate && [self.delegate respondsToSelector:selector]) {
                [self.delegate performSelector:selector withObject:self withObject:sender];
            }
            break;
        }
        default:
            break;
    }
}

@end
