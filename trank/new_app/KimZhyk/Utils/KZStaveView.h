//
//  KZStaveView.h
//  KimZhyk
//
//  Created by Пользователь on 20.03.15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZSound.h"

@interface KZStaveView : UIView {
    UIImageView *_thumb;
    
}
- (void)showSound:(KZSound *)sound;
- (void)hideSound;
@end
