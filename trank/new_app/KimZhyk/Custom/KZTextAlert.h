//
//  KZTextAlert.h
//  KimZhyk
//
//  Created by Ihor Koblan on 3/30/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KZTextAlert;
@protocol KZTextAlertDelegate <NSObject>


- (void)KZTextAlert:(KZTextAlert *)textAlert gotText:(NSString *)text;

@end


@interface KZTextAlert : UIView<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *titleField;
@property (nonatomic, weak) id<KZTextAlertDelegate> delegate;

+ (KZTextAlert *)textAlert;
@end
