//
//  VKDialDelegate.h
//  VK iOS UI SDK
//
//  Created by Oleg Sehelyn && Volodymyr Shevchyk on 04.07.11.
//  Copyright 2011 Vakoms. All rights reserved.
//  www.vakoms.com
//

@protocol VKDialDelegate <NSObject>
@optional
- (void) volumeChanged:(NSInteger) pVolumeValue;
- (void) panChanged:(NSString*) pPanValue;
- (void) valueChanged:(NSInteger) pValueChanged;
@end
