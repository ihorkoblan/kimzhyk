//
//  ImageKey.h
//  Synthezier
//
//  Created by Lion User on 06/09/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
@protocol PianoKeyDelegate <NSObject>
@optional
-(void)beginTouch:(UIEvent *)event ;
-(void)moveTouch:(UIEvent *)event;
-(void)endTouch:(UIEvent *)event;
@end
@interface PianoKey : UIImageView {   
    id <PianoKeyDelegate,UIGestureRecognizerDelegate> mPianoKeyDelegate;
     
}
@property (nonatomic, assign) id<PianoKeyDelegate> mPianoKeyDelegate;

@end
