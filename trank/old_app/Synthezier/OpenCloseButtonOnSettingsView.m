//
//  OpenCloseButtonOnSettingsView.m
//  Synthezier
//
//  Created by Lion User on 27/09/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenCloseButtonOnSettingsView.h"
#import "Global.h"
@implementation OpenCloseButtonOnSettingsView
@synthesize mMoveSettingsPanel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 
    if (mMoveSettingsPanel && [mMoveSettingsPanel respondsToSelector:@selector(beginTouchOnButton:)]) {
        [mMoveSettingsPanel performSelector:@selector(beginTouchOnButton:) withObject:event];
    } else {
        DLog(@"ERROR IN DELEGATE CODE");
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    if (mMoveSettingsPanel && [mMoveSettingsPanel respondsToSelector:@selector(moveTouchOnButton:)]) {
        [mMoveSettingsPanel performSelector:@selector(moveTouchOnButton:) withObject:event];
    } else {
        DLog(@"ERROR IN DELEGATE CODE");
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (mMoveSettingsPanel && [mMoveSettingsPanel respondsToSelector:@selector(endTouchOnButton:)]) {
        [mMoveSettingsPanel performSelector:@selector(endTouchOnButton:) withObject:event];
    } else {
        DLog(@"ERROR IN DELEGATE CODE");
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
