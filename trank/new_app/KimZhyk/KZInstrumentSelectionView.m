//
//  KZInstrumentSelectionView.m
//  KimZhyk
//
//  Created by Ihor on 5/27/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZInstrumentSelectionView.h"
#import "UIButton+Custom.h"

@interface KZInstrumentSelectionView() {

}

@end


@implementation KZInstrumentSelectionView

- (instancetype)initWithFrame:(CGRect)frame selectedInstrument:(Instrument)instrument {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedInstrument = instrument;
        [self mainInitWithFrame:frame];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedInstrument = instrumentPiano;
        [self mainInitWithFrame:frame];
    }
    return self;
}

- (void)mainInitWithFrame:(CGRect)frame {
    self.layer.cornerRadius = 12.0;
    self.layer.borderWidth = 3.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor greenColor];
    NSUInteger instrumentsCount = [KZInstrumentsHelper instrumentImageNames].count;
    
    CGSize lInstrBtnSize = CGSizeMake(self.bounds.size.height * 0.7f, self.bounds.size.height * 0.7f);
    
    for (int i = 0; i < instrumentsCount; i++) {
        UIButton *lButton = [UIButton newInstrumentBtnWithSize:lInstrBtnSize];
        [lButton setImage:[UIImage imageNamed:[KZInstrumentsHelper instrumentImageNames][i][kInstrumentImageKey]] forState:UIControlStateNormal];
        lButton.tag = i;
        lButton.center = CGPointMake(i * (lButton.bounds.size.width + 10.0) + lButton.bounds.size.width/2.0 + 20.0, self.bounds.size.height / 2.0);
        [self addSubview:lButton];
        [lButton addTarget:self action:@selector(instrumentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.contentSize = CGSizeMake(instrumentsCount * (lInstrBtnSize.width + 10.0) + 30.0, lInstrBtnSize.height);
    [self updateInstruments];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)instrumentBtnPressed:(id)sender {
    UIButton * lBtn = sender;
    self.selectedInstrument = (Instrument)lBtn.tag;
    [self updateInstruments];
    
    if (self.delegate_ && [self.delegate_ respondsToSelector:@selector(KZInstrumentSelectionView:selectedInstrument:)]) {
        [self.delegate_ KZInstrumentSelectionView:self selectedInstrument:self.selectedInstrument];
    }
}

- (void)updateInstruments {
    for (int i = 0; i < self.subviews.count; i++) {
        if ([self.subviews[i] isKindOfClass:[UIButton class]] && (i == self.selectedInstrument)) {
            ((UIButton *)self.subviews[i]).layer.borderWidth = 3.0;
            ((UIButton *)self.subviews[i]).layer.borderColor = [UIColor blueColor].CGColor;
        } else {
            ((UIButton *)self.subviews[i]).layer.borderWidth = 3.0;
            ((UIButton *)self.subviews[i]).layer.borderColor = [UIColor brownColor].CGColor;
        }
    }
}

@end
