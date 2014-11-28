//
//  ImageKey.m
//  Synthezier
//
//  Created by Lion User on 06/09/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PianoKey.h"

@implementation PianoKey

@synthesize mPianoKeyDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];

    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];    
    DLog(@"x = %f y = %f",location.x,location.y);
    [self OnOffPlaying:@selector(beginTouch:) withObject:event setHighLighted:YES];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self OnOffPlaying:@selector(endTouch:) withObject:event setHighLighted:NO];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    DLog(@"touchesCancelled");
}

-(void)OnOffPlaying:(SEL)pSelector withObject:(UIEvent*)pEvent  setHighLighted:(BOOL)pHighlighted{
    if (mPianoKeyDelegate && [mPianoKeyDelegate respondsToSelector:pSelector]) {
        [mPianoKeyDelegate performSelector:pSelector withObject:pEvent];
        self.highlighted = pHighlighted;
    } else {
        DLog(@"ERROR IN DELEGATE CODE");
    }
}

@end
