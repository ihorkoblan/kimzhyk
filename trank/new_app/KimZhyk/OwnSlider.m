//
//  OwnSlider.m
//  KimZhyk
//
//  Created by Admin on 20.08.15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "OwnSlider.h"
#import "KZSettingsView.h"
#import "PianoView.h"
CGFloat delta;
CGFloat scrollerIndicatorWidth;
CGFloat indicatorPosition;

@implementation OwnSlider

@synthesize lSliderIndicator, delegate, touchLocation, pianowidth = _pianowidth ;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
    
        NSUserDefaults *valueOfKeyWidth = [ NSUserDefaults standardUserDefaults];
        scrollerIndicatorWidth = (self.bounds.size.width * self.bounds.size.width ) /
                                 ([ valueOfKeyWidth floatForKey:@"ValueOfSlider"] * TOTAL_WHITE_KEYS);
        [self layoutOwnSlider];
    }
    return self;
}

- (void)setPianowidth:(CGFloat)pianowidth {
    
    
    _pianowidth = pianowidth;
    scrollerIndicatorWidth = (self.bounds.size.width * self.bounds.size.width )/_pianowidth;
   
    
    if ((indicatorPosition + lSliderIndicator.frame.size.width) >= self.bounds.size.width)
    {
        indicatorPosition = self.bounds.size.width - scrollerIndicatorWidth;
    }
    
        lSliderIndicator.frame = CGRectMake(indicatorPosition , 0.0f, scrollerIndicatorWidth, 40.0f);
    NSUserDefaults *ownSliderValue = [ NSUserDefaults standardUserDefaults];
    [ ownSliderValue setFloat: indicatorPosition forKey:@"OwnSliderValue"];
    [ ownSliderValue synchronize];

    
}


- (void)layoutOwnSlider {
    
    
    UIImageView *lSliderBackImage = [[UIImageView alloc] initWithFrame: CGRectMake (0.0, 0.0 , self.bounds.size.width, 40.0f )  ];
    lSliderBackImage.image = [UIImage imageNamed:@"Scroller1.jpg"];
    [self addSubview:lSliderBackImage];
    

    lSliderIndicator = [[UIView alloc] initWithFrame: CGRectMake( 0.0f,
                                                                  0.0f,
                                                                  scrollerIndicatorWidth,
                                                                  40.0f)];
    
    lSliderIndicator.backgroundColor = [UIColor blackColor];
    lSliderIndicator.alpha = 0.3f;
    lSliderIndicator.userInteractionEnabled = YES;
    [self addSubview:lSliderIndicator];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    
    touchLocation = [touch locationInView:self];
    
    if (touch.view == lSliderIndicator) {
  
        
        CGFloat k = touchLocation.x / self.bounds.size.width;
         delta = k * self.bounds.size.width  - lSliderIndicator.center.x;
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    touchLocation = [touch locationInView: self];
    

    
    if (touch.view == lSliderIndicator) {
        
        
        
        CGFloat k = touchLocation.x / self.bounds.size.width;
        CGFloat lLeftEdge = ((lSliderIndicator.frame.size.width*0.5 - delta  ) / self.bounds.size.width);
        CGFloat lRightEdge = ((lSliderIndicator.frame.size.width*0.5 + delta  ) / self.bounds.size.width);
        k = (k > (1.0 - lLeftEdge)) ? (1.0 - lLeftEdge) : k;
        k = (k < lRightEdge) ? lRightEdge : k;
        
        
        lSliderIndicator.center = CGPointMake(k * self.bounds.size.width - delta, 20.0f);
        indicatorPosition = lSliderIndicator.center.x - lSliderIndicator.frame.size.width / 2.0 ;
        
        [self.delegate OwnSlider: self
                    changedvalue: indicatorPosition
               whithscrollersize: lSliderIndicator.frame.size.width ];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self];
    
    
}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
