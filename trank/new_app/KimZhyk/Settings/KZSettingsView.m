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

#define HOME_BTN_TAG 1
#define OPENCLOSE_BTN_TAG 2
#define RECORD_BTN_TAG 3

@interface KZSettingsView() {
    IBOutlet UILabel *_instrumentLabel;
    IBOutlet UILabel *_noteLabel;
    IBOutlet UIButton *_recorBtn;
}

@end

@implementation KZSettingsView
@synthesize delegate;

- (void)setInstrument:(NSString *)instrument {
    _instrument = instrument;
    if (_instrumentLabel) {
        _instrumentLabel.text = _instrument;
    }
}

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
    NSDictionary *instrumentDict = [KZInstrumentsHelper dictionaryForInstrument:instrumentPiano];
    if (instrumentDict) {
        _instrumentLabel.text = instrumentDict[kInstrumentNameKey];
    }
}

- (void)KZInstrumentSelectionView:(id)sender selectedInstrument:(Instrument)instrument {
    
    NSDictionary *instrumentDict = [KZInstrumentsHelper dictionaryForInstrument:instrument];
    if (instrumentDict) {
        _instrumentLabel.text = instrumentDict[kInstrumentNameKey];
    }
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
        case HOME_BTN_TAG: {

            if (self.delegate && [self.delegate respondsToSelector:@selector(KZSettingView:backBtnPressed:)]) {
                [self.delegate performSelector:@selector(KZSettingView:backBtnPressed:) withObject:self withObject:sender];
            }
            break;
        }
        case OPENCLOSE_BTN_TAG: {
            if (self.delegate && [self.delegate respondsToSelector:@selector(KZSettingView:openInstrumentsBtnPressed:)]) {
                [self.delegate performSelector:@selector(KZSettingView:openInstrumentsBtnPressed:) withObject:self withObject:sender];
            }
            break;
        }
            
        case RECORD_BTN_TAG: {
            if (self.delegate && [self.delegate respondsToSelector:@selector(KZSettingView:recordBtnPressed:)]) {
                [self.delegate performSelector:@selector(KZSettingView:recordBtnPressed:) withObject:self withObject:sender];
            }

            break;
        }
        default:
            break;
    }
}



@end
