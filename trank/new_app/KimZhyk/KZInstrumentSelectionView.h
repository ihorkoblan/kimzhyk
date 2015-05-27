//
//  KZInstrumentSelectionView.h
//  KimZhyk
//
//  Created by Ihor on 5/27/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZInstrumentsHelper.h"

@protocol KZInstrumentSelectionViewDelegate <NSObject>


- (void)KZInstrumentSelectionView:(id)sender selectedInstrument:(Instrument)instrument;

@end

@interface KZInstrumentSelectionView : UIScrollView
@property (nonatomic, assign) Instrument selectedInstrument;
@property (nonatomic, weak) id<KZInstrumentSelectionViewDelegate> delegate_;

@end