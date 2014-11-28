//
//  UICustomSwitch.m
//  VK iOS UI SDK
//
//  Created by Oleg Sehelyn && Volodymyr Shevchyk on 04.07.11.
//  Copyright 2011 Vakoms. All rights reserved.
//  www.vakoms.com
//

#import "VKSwitch.h"
#import "Global.h"

@implementation VKSwitch

@synthesize on = mIsOn;
@synthesize tintColor = mTintColor;
@synthesize clippingView = mClippingView;
@synthesize leftLabel = mLeftLabel;
@synthesize rightLabel = mRightLabel;


+(VKSwitch *)switchWithLeftText:(NSString *)leftText andRight:(NSString *)rightText
{
	VKSwitch *switchView = [[VKSwitch alloc] initWithFrame:CGRectZero];
	
	return [switchView autorelease];
}

-(id)initWithFrame:(CGRect)frame {
	[self initWithFrame:frame andStyle:VKSwitchStyleWhite];
	return self;
}
- (id)initWithFrame:(CGRect)rect andStyle:(VKSwitchStyle)lStyle {
	if ((self=[super initWithFrame:CGRectMake(rect.origin.x,rect.origin.y,rect.size.width,rect.size.height)]))
	{
		if (lStyle == VKSwitchStyleWhite) {
			mStyle = YES;
		}
		[self awakeFromNib];
	}
	return self;
}

-(void)awakeFromNib
{
	[super awakeFromNib];
	
	self.backgroundColor = [UIColor clearColor];
	
	if (mStyle == YES) {

		UIImage* lThumbImage = [UIImage imageNamed:@"switchcircle.png"];
		CGSize newSize = CGSizeMake(self.frame.size.width/2,1.1*self.frame.size.height);
		UIGraphicsBeginImageContext(newSize); 
		[lThumbImage drawInRect:CGRectMake(0, 1, newSize.width, newSize.height)]; 
		
		UIImage *scaledThumbImage = UIGraphicsGetImageFromCurrentImageContext(); 
		UIGraphicsEndImageContext(); 
		
		UIImage* lMinImage = [UIImage imageNamed:@"switchbackside.png"];
		CGSize newMinSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
		UIGraphicsBeginImageContext(newMinSize); 
		[lMinImage drawInRect:CGRectMake(0, 0, newMinSize.width, newMinSize.height)]; 
		
		UIImage *scaledMinImage = UIGraphicsGetImageFromCurrentImageContext(); 
		UIGraphicsEndImageContext(); 
		
		UIImage* lMaxImage = [UIImage imageNamed:@"switchbackside.png"];
		CGSize newMaxSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
		UIGraphicsBeginImageContext(newMaxSize); 
		[lMaxImage drawInRect:CGRectMake(0, 0, newMaxSize.width, newMaxSize.height)]; 
							
		UIImage *scaledMaxImage = UIGraphicsGetImageFromCurrentImageContext(); 
		UIGraphicsEndImageContext(); 
							  
		[self setThumbImage:scaledThumbImage forState:UIControlStateNormal];
		[self setMinimumTrackImage:scaledMinImage forState:UIControlStateNormal];
		[self setMaximumTrackImage:scaledMaxImage forState:UIControlStateNormal];
		
	}
	else {
		
		UIImage* lThumbImage = [UIImage imageNamed:@"switchcircle.png"];
		CGSize newSliderSize = CGSizeMake(self.frame.size.width/2, self.frame.size.height);
		UIGraphicsBeginImageContext(newSliderSize); 
		[lThumbImage drawInRect:CGRectMake(0, 0, newSliderSize.width, newSliderSize.height)]; 
		
		UIImage *scaledThumbImage = UIGraphicsGetImageFromCurrentImageContext(); 
		UIGraphicsEndImageContext(); 
		
		UIImage* lMinImage = [UIImage imageNamed:@"switchbackside.png"];
		CGSize newSliderMinSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
		UIGraphicsBeginImageContext(newSliderMinSize); 
		[lMinImage drawInRect:CGRectMake(0, 0, newSliderMinSize.width, newSliderMinSize.height)]; 
		
		UIImage *scaledMinImage = UIGraphicsGetImageFromCurrentImageContext(); 
		UIGraphicsEndImageContext(); 
		
		UIImage* lMaxImage = [UIImage imageNamed:@"switchbackside.png"];
		CGSize newSliderMaxSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
		UIGraphicsBeginImageContext(newSliderMaxSize); 
		[lMaxImage drawInRect:CGRectMake(0, 0, newSliderMaxSize.width, newSliderMaxSize.height)]; 
							  
		UIImage *scaledMaxImage = UIGraphicsGetImageFromCurrentImageContext(); 
		UIGraphicsEndImageContext(); 
							  
		[self setThumbImage:scaledThumbImage forState:UIControlStateNormal];
		[self setMinimumTrackImage:scaledMinImage forState:UIControlStateNormal];
		[self setMaximumTrackImage:scaledMaxImage forState:UIControlStateNormal];
		
	}

	self.minimumValue = 0;
	self.maximumValue = 1;
	self.continuous = NO;
	
	self.on = NO;
	self.value = 0.0;
	
	self.clippingView = [[UIView alloc] initWithFrame:CGRectMake(4,2,87,23)];
	self.clippingView.clipsToBounds = YES;
	self.clippingView.userInteractionEnabled = NO;
	self.clippingView.backgroundColor = [UIColor clearColor];
	[self addSubview:self.clippingView];
	[self.clippingView release];
	
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	[self.clippingView removeFromSuperview];
	[self addSubview:self.clippingView];
	
	CGFloat thumbWidth = self.currentThumbImage.size.width;
	CGFloat switchWidth = self.bounds.size.width;
	CGFloat labelWidth = switchWidth - thumbWidth;
	CGFloat inset = self.clippingView.frame.origin.x;
	
	NSInteger xPos = self.value * labelWidth - labelWidth - inset;
	self.leftLabel.frame = CGRectMake(xPos, 0, labelWidth, 23);
	
	xPos = switchWidth + (self.value * labelWidth - labelWidth) - inset; 
	self.rightLabel.frame = CGRectMake(xPos, 0, labelWidth, 23);
	
}

- (void)scaleSwitch:(CGSize)newSize 
{
	self.transform = CGAffineTransformMakeScale(newSize.width,newSize.height);
}

- (UIImage *)image:(UIImage*)image tintedWithColor:(UIColor *)tint 
{	
	
    if (tint != nil) 
	{
		UIGraphicsBeginImageContext(image.size);

		CGContextRef currentContext = UIGraphicsGetCurrentContext();
		CGImageRef maskImage = [image CGImage];
		CGContextClipToMask(currentContext, CGRectMake(0, 0, image.size.width, image.size.height), maskImage);
		CGContextDrawImage(currentContext, CGRectMake(0,0, image.size.width, image.size.height), image.CGImage);
		
		[image drawAtPoint:CGPointMake(0,0)];
		[tint setFill];
		UIRectFillUsingBlendMode(CGRectMake(0,0,image.size.width,image.size.height),kCGBlendModeColor);
		UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
				
        return newImage;
    }
    else 
	{
        return image;
    }
}


-(void)setTintColor:(UIColor*)pColor
{
	if (pColor != mTintColor)
	{
		[mTintColor release];
		mTintColor = [pColor retain];
		
	}
	
}

- (void)setOn:(BOOL)turnOn animated:(BOOL)animated;
{
	mIsOn = turnOn;
	
	if (animated)
	{
		[UIView	 beginAnimations:@"UICustomSwitch" context:nil];
		[UIView setAnimationDuration:0.2];
	}
	
	if (mIsOn)
	{
		self.value = 1.0;
	}
	else 
	{
		self.value = 0.0;
	}
	
	if (animated)
	{
		[UIView	commitAnimations];	
	}
	DLog(@"vvvv:%i",self.on);
}

- (void)setOn:(BOOL)turnOn
{
	[self setOn:turnOn animated:NO];
}


- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	[super endTrackingWithTouch:touch withEvent:event];
	mIsSelfTouched = YES;
	
	[self setOn:mIsOn animated:YES];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	[super touchesBegan:touches withEvent:event];
	mIsSelfTouched = NO;
	mIsOn = !mIsOn;
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	[super touchesEnded:touches withEvent:event];
	
	if (!mIsSelfTouched)
	{
		[self setOn:mIsOn animated:YES];
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
}

-(void)dealloc
{
	[mTintColor release];
	[mClippingView release];
	[mRightLabel release];
	[mLeftLabel release];
	
	[super dealloc];
}

@end
