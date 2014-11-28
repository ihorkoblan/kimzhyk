//
//  KZVolumerView.m
//  Synthezier
//
//  Created by ihor on 08.07.14.
//
//

#import "KZVolumerView.h"

@implementation KZVolumerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUserInteractionEnabled:YES];
        
        _circledImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RoundButton.png"]];
        _circledImageView.frame = frame;
        
        UIImageView *lDotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RoundButton_.png"]];
        lDotImageView.frame  = frame;
        
        [self addSubview:_circledImageView];
        [self addSubview:lDotImageView];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint lTouchLocation = [self locationOnViewWithEvent:event];
    _circledImageView.transform = CGAffineTransformMakeRotation(2 * M_PI);
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint lTouchLocation = [self locationOnViewWithEvent:event];

    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint lTouchLocation = [self locationOnViewWithEvent:event];
    
}

- (CGPoint)locationOnViewWithEvent:(UIEvent *)event {
    UITouch *touch = [[event touchesForView:self] anyObject];
    return [touch locationInView:touch.view];
}

@end
