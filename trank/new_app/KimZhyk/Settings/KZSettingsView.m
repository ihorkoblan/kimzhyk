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
    selectionView.delegate = self;
    [self addSubview:selectionView];
}

- (void)KZInstrumentSelectionView:(id)sender selectedInstrument:(Instrument)instrument {
    
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

- (void)instrumentBtnPressed:(id)sender {
    __weak UIButton *lBtn = sender;
    Instrument lMusicianInstrument = instrumentPiano;
    switch (lBtn.tag) {
        case 1000: {
            lMusicianInstrument = instrumentPiano;
            break;
        }
        case 1001: {
            lMusicianInstrument = instrumentTrombone;
            break;
        }
        case 1002: {
            lMusicianInstrument = instrumentAccordeon;
            break;
        }
        case 1003: {
            lMusicianInstrument = instrumentTennorSax;
            break;
        }
        case 1004: {
            lMusicianInstrument = instrumentChurchOrgan;
            break;
        }
        case 1005: {
            lMusicianInstrument = instrumentFlute;
            break;
        }
        case 1006: {
            lMusicianInstrument = instrumentCello;
            break;
        }
        case 1007: {
            lMusicianInstrument = instrumentAcousticGuitar;
            break;
        }

        default: {
            lMusicianInstrument = instrumentPiano;
            break;
        }
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(KZSettingView:instrumentChosen:)]) {
        [self.delegate KZSettingView:self instrumentChosen:lMusicianInstrument];
    }
    
    for (NSInteger i = 0; i < [KZInstrumentsHelper instrumentImageNames].count; i++) {
        __weak UIButton *lButton = (UIButton *)[_instrumentsScrollView viewWithTag:1000 + i];
        if (lBtn.tag == lButton.tag) {
            lButton.layer.borderColor = [UIColor blueColor].CGColor;
        } else {
            lButton.layer.borderColor = [UIColor greenColor].CGColor;
        }
    }
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
