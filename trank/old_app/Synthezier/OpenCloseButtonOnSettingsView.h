//
//  OpenCloseButtonOnSettingsView.h
//  Synthezier
//
//  Created by Lion User on 27/09/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MoveSettingsPanelDelegate <NSObject>
@optional
-(void)beginTouchOnButton:(UIEvent *)event ;
-(void)moveTouchOnButton:(UIEvent *)event;
-(void)endTouchOnButton:(UIEvent *)event;
@end


@interface OpenCloseButtonOnSettingsView : UIButton{
id <MoveSettingsPanelDelegate,UIGestureRecognizerDelegate> mMoveSettingsPanel;

}
@property (nonatomic, assign) id<MoveSettingsPanelDelegate> mMoveSettingsPanel;

@end
