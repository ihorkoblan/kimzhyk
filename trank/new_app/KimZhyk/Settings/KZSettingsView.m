//
//  KZSettins.m
//  KimZhyk
//
//  Created by Администратор on 8/3/13.
//  Copyright (c) 2013 HostelDevelopers. All rights reserved.
//

#import "KZSettingsView.h"
#import "KZStaveView.h"
#import "UIButton+Custom.h"
#import "KZInstrumentsHelper.h"
#import "KZInstrumentSelectionView.h"

@implementation KZSettingsView
@synthesize delegate;



- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {


    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    KZInstrumentSelectionView *selectionView = [[KZInstrumentSelectionView alloc] initWithFrame:CGRectMake(10.0, 10.0, self.bounds.size.width - 20.0, 130.0)];
    selectionView.delegate_ = self;
    [self addSubview:selectionView];
}

- (void)KZInstrumentSelectionView:(id)sender selectedInstrument:(Instrument)instrument {
    if (self.delegate && [self.delegate respondsToSelector:@selector(KZSettingView:instrumentChosen:)]) {
        [self.delegate KZSettingView:self instrumentChosen:instrument];
    }
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

            if (self.delegate && [self.delegate respondsToSelector:@selector(KZSettingView:backBtnPressed:)]) {
                [self.delegate performSelector:@selector(KZSettingView:backBtnPressed:) withObject:self withObject:sender];
            }
            break;
        }
        case 2: {
            if (self.delegate && [self.delegate respondsToSelector:@selector(KZSettingView:openInstrumentsBtnPressed:)]) {
                [self.delegate performSelector:@selector(KZSettingView:openInstrumentsBtnPressed:) withObject:self withObject:sender];
            }
            break;
        }
        default:
            break;
    }
}



@end
