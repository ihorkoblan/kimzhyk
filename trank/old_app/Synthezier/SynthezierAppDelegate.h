//
//  SynthezierAppDelegate.h
//  Synthezier
//
//  Created by Vakoms on 7/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SynthezierViewController;

@interface SynthezierAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SynthezierViewController *viewController;

@end