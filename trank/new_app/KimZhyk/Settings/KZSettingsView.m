//
//  KZSettins.m
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZSettingsView.h"

@implementation KZSettingsView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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

- (IBAction)listeningBtnPressed:(id)sender {
    UIButton *currentBtn = sender;
    switch (currentBtn.tag) {
        case 1:{
            SEL selector = @selector(KZSettingView:startListeningBtnPressed:);
            if (self.delegate && [self.delegate respondsToSelector:selector]) {
                [self.delegate KZSettingView:self startListeningBtnPressed:sender];
            }
            break;
        }
        case 2:{
            SEL selector = @selector(KZSettingView:stopListeningBtnPressed:);
            if (self.delegate && [self.delegate respondsToSelector:selector]) {
                [self.delegate KZSettingView:self stopListeningBtnPressed:sender];
            }
            break;
        }
        case 3: {
            SEL selector = @selector(KZSettingView:recordBtnPressed:);
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
