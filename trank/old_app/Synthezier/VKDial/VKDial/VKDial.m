//
//  CustomDial.m
//  VK iOS UI SDK
//
//  Created by Oleg Sehelyn && Volodymyr Shevchyk on 04.07.11.
//  Copyright 2011 Vakoms. All rights reserved.
//  www.vakoms.com
//
#import "VKDial.h"
#import "VKDialDelegate.h"
#import "Global.h"

#define VOLUME_SIGMENTS_NUMBER 17

//private methods
@interface VKDial() 
-(void) showVolume:(NSInteger)pValue;
-(void) showPan:(NSString*)pValue;
-(void) showValue:(NSInteger)pValue;

- (CGFloat) updateRotation:(CGPoint) location;
@end


@implementation VKDial

@synthesize maxValue= mMaxValue;
@synthesize value   = mValue;
@synthesize delegate= mDelegate;
@synthesize labelHidden=mIsLabelHidden;
@synthesize style=mCurrentStyle;
@synthesize type=mCurrentType;


#pragma mark Properties
#pragma mark ------------------------
-(void) setType:(VKDialType)pType {
    CGFloat fontSize = 0;
    
    switch (pType) {
        case VKDialTypeChanel:
            [self setLabelHidden:NO];
            fontSize = mResultLabel.frame.size.height/3;
            [mResultLabel setFont:[UIFont fontWithName:@"Arial" size:fontSize]]; 
            mResultLabel.text = @"Pan:L";
            mMaxValue = 4;		
            break;
        case VKDialTypeVolume:
            [self setLabelHidden:NO];
            fontSize = mResultLabel.frame.size.height/2.5;
            [mResultLabel setFont:[UIFont fontWithName:@"Arial" size:fontSize]]; 
            mResultLabel.text = @"Vol:0";
            mMaxValue = 10;
            break;
        case VKDialTypeNone:
            mResultLabel.hidden = YES;
            mLabelBackgroundImageView.hidden = YES;
            mMaxValue = 10;
            break;
        case VKDialTypeDisplayDivisions:
            mResultLabel.hidden=YES;
            break;
        default:
            [self setLabelHidden:NO];
            fontSize = mResultLabel.frame.size.height/3;
            [mResultLabel setFont:[UIFont fontWithName:@"Arial" size:fontSize]]; 
            mResultLabel.text = @"0";
            mMaxValue = 4;		
            break;
            
    }
}

-(NSString*) getValue {
	NSString* result = [mResultLabel.text retain];
	return result;
}

- (void) setLabelHidden:(BOOL)pLabelHidden {
    if (mCurrentType == VKDialTypeNone) {
        DLog(@"WARNING: You can not change visibility of dial for VKDialTypeNone type!");
    } else {
        mIsLabelHidden = pLabelHidden;
        //hides label and image view located under the label
        mResultLabel.hidden = mIsLabelHidden;
        mLabelBackgroundImageView.hidden = mIsLabelHidden;
    }
}
#pragma mark Initializating methods
#pragma mark ------------------------
-(id)initWithFrame:(CGRect)pFrame {
    //inits with a standart style and standart type - VKDialTypeVolume
	self = [self initWithFrame:pFrame custonStyleBackgroundImage:[UIImage imageNamed:@"circleVolumer.png"] arrowImage:[UIImage imageNamed:@"RoundButton_.png"] labelImage:[UIImage imageNamed:@"PanVolButtonBackground.png"] type:VKDialTypeVolume]; 
	if (self) {
		mCurrentStyle = VKDialStyleStandart;
	}	
    return self;	
}


- (id) initWithFrame:(CGRect)pFrame custonStyleBackgroundImage:(UIImage*)pBackgroundImage arrowImage:(UIImage*) pArrowImage labelImage:(UIImage*) pLabelImage type:(VKDialType) pType {
    self = [super initWithFrame:pFrame];
    if (self) {		
        mCurrentType = pType;
        mCurrentStyle = VKDialStyleCustom;
        mDelegate = nil;
        
		self.frame = pFrame;
		pFrame.origin.x -= pFrame.origin.x+4;
		pFrame.origin.y -= pFrame.origin.y+4;
		pFrame.size.width +=10;
		pFrame.size.height +=8;
		
        //arrow image
		UIImage* lTimeChangeImage = pArrowImage;
		
		CGSize newSize = CGSizeMake(pFrame.size.width, pFrame.size.height);
		UIGraphicsBeginImageContext(newSize); 
		[lTimeChangeImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)]; 
		
		UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext(); 
		UIGraphicsEndImageContext(); 
        //background image
		UIImage* lTimeChangeImageBackground = pBackgroundImage;
		
		CGSize newSizeBackground = CGSizeMake(scaledImage.size.width+7, scaledImage.size.height+7);
		UIGraphicsBeginImageContext(newSizeBackground); 
		[lTimeChangeImageBackground drawInRect:CGRectMake(0, 0, newSizeBackground.width, newSizeBackground.height)]; 
		
		UIImage *scaledImageBackground = UIGraphicsGetImageFromCurrentImageContext(); 
		UIGraphicsEndImageContext(); 
        
		UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:pFrame];
		backgroundImageView.image = scaledImageBackground;
		[self addSubview:backgroundImageView];
		[backgroundImageView release];
		
		mTimeChange = [[UIImageView alloc] initWithFrame:pFrame];
		
		mTimeChange.image = scaledImage;
		
		[self addSubview:mTimeChange];
		
        //labels background image
		mLabelBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(pFrame.origin.x + 7,
                                                                                  pFrame.origin.y+ pFrame.size.height,
                                                                                  pFrame.size.width - 15, 
                                                                                  pFrame.size.height/2)];
		
		[mLabelBackgroundImageView setImage:pLabelImage];
		[self addSubview:mLabelBackgroundImageView];
		
		CGAffineTransform cgaRotate = CGAffineTransformMakeRotation(mNewAngle);
		mTimeChange.transform = cgaRotate;
        
        //defining result label
        mResultLabel = [[UILabel alloc] initWithFrame:CGRectMake(pFrame.origin.x + 7,
                                                                 pFrame.origin.y+ pFrame.size.height,
                                                                 pFrame.size.width - 15, 
                                                                 pFrame.size.height/2)]; 
        
        [mResultLabel setBackgroundColor:[UIColor clearColor]];
        mResultLabel.textAlignment = 1;
        mResultLabel.textColor = [UIColor colorWithRed:0.05f green:0.99f blue:0.99f alpha:1.0f];
        
        [self addSubview:mResultLabel];
        [self setType:pType];
        
		mStartLocation = YES;}
    return self;
}

- (id) initWithFrame:(CGRect) pFrame type:(VKDialType)pType{
    //inits with a standart style and defined type
	self = [self initWithFrame:pFrame custonStyleBackgroundImage:[UIImage imageNamed:@"circleVolumer.png"] arrowImage:[UIImage imageNamed:@"RoundButton_.png"] labelImage:[UIImage imageNamed:@"PanVolButtonBackground.png"] type:pType]; 
    mCurrentStyle=VKDialStyleStandart;
    if (pType==VKDialTypeDisplayDivisions) {

        UIImageView *img1=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"0_img.png"]];
        UIImageView *img2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1_img.png"]];
        UIImageView *img3=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2_img.png"]];
        UIImageView *img4=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3_img.png"]];
        UIImageView *img5=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4_img.png"]];
        UIImageView *img6=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5_img.png"]];
        UIImageView *img7=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6_img.png"]];
        UIImageView *img8=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"7_img.png"]];
        UIImageView *img9=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"8_img.png"]];
        UIImageView *img10=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"9_img.png"]];
        UIImageView *img11=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"10_img.png"]];
        UIImageView *img12=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"11_img.png"]];
        UIImageView *img13=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"12_img.png"]];
        UIImageView *img14=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"13_img.png"]];
        UIImageView *img15=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"14_img.png"]];
        UIImageView *img16=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"15_img.png"]];
        UIImageView *img17=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"16_img.png"]];
        UIImageView *img18=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"17_img.png"]];
        
        mImageNamesArray =[[NSArray alloc] initWithObjects:img1,img2,img3,img4,img5,img6,img7,img8,img9,img10,img11,img12,img13,img14,img15,img16,img17,img18,nil];
            
        [self putVolumeSegments];
       // DLog(@"mNumbSegmentsDisp=%i",mNumbSegmentsDisp);
        [self setHiddenForDisplayVolumeSegments:YES];
        [self setHiddenForDisplayGroupVolumeSegments:(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"VolumeValue"]*(VOLUME_SIGMENTS_NUMBER)/127];   
        mMaxValue=127.0f;
    [self setCurrentValue:[[NSUserDefaults standardUserDefaults] integerForKey:@"VolumeValue"]];
    }
	if (self) {
		
	}	
    return self;	
}

- (void)dealloc {
    [mTimeChange release];
    [mLabelBackgroundImageView release];
	[mResultLabel release];
    [mImageNamesArray release]; 

    [super dealloc];
}

#pragma mark Rotation handlers
#pragma mark ------------------------
CGFloat wrapd(CGFloat val, CGFloat min, CGFloat max) {
	CGFloat result = val;
    if(val < min) { 
		result = max - (min - val);
	}	
    if(val > max) { 
		result = min - (max - val);
	}	
    return result;
}

- (CGFloat) updateRotation:(CGPoint) pLocation {
	CGAffineTransform lCgaRotate;
    CGFloat lFromAngle = atan2(mLocationBegan.y- mTimeChange.center.y, mLocationBegan.x- mTimeChange.center.x);
    CGFloat lToAngle = atan2(pLocation.y- mTimeChange.center.y, pLocation.x-mTimeChange.center.x);
	
	if ((mSaveAngle !=0) && (mStartLocation == YES)) {
		mCurrentAngle = mSaveAngle;
	}
	mNewAngle = wrapd(mCurrentAngle + (lToAngle - lFromAngle), 0, 2*M_PI);
	DLog(@"mNewAngle=%f",mNewAngle);
    if(mNewAngle>=2*M_PI) 
        mNewAngle=2*M_PI;
    if(mNewAngle<=0.0) 
        mNewAngle=0.0;
	lCgaRotate = CGAffineTransformMakeRotation(mNewAngle);
	mTimeChange.transform = lCgaRotate;

    NSInteger lState = mNewAngle/(M_PI/(mMaxValue+1));
    if (lState>=mMaxValue) lState=mMaxValue;
    if(lState<=1) lState=1;
        
    DLog(@"diallState=%i",lState);
    [self showValue:lState];
	
	if (mCurrentType == VKDialTypeVolume) {
		DLog(@"%i",lState);
		[self showVolume:lState];
		mResultLabel.text = [NSString stringWithFormat:@"Vol:%i",lState];
		mValue = [NSString stringWithFormat:@"%i",lState];
	}
	else if (mCurrentType == VKDialTypeChanel){
		NSInteger chanel = mNewAngle/(2*M_PI/(mMaxValue+1));
		DLog(@"NA:%f",mNewAngle);
		if (chanel == 0) {
			mResultLabel.text = [NSString stringWithFormat:@"Pan:L"];
       		[self showPan:@"L"];
		} else {
			if (chanel == 1) {
				mResultLabel.text = [NSString stringWithFormat:@"Pan:LC"];
                [self showPan:@"LC"];
			} else {
				if (chanel == 2) {
					mResultLabel.text = [NSString stringWithFormat:@"Pan:C"];
                    [self showPan:@"C"];
				} else {
					if (chanel == 3) {
						mResultLabel.text = [NSString stringWithFormat:@"Pan:RC"];
                        [self showPan:@"RC"];
					} else {
						mResultLabel.text = [NSString stringWithFormat:@"Pan:R"];
                        [self showPan:@"R"];
					}
				}
			}
		}
		mValue = mResultLabel.text;
	}
    if(mCurrentType==VKDialTypeDisplayDivisions){ 
      mNumbSegmentsDisp=lState;
    } 
    return mNewAngle;
}

#pragma mark Inastance Appearance
#pragma mark ------------------------
-(void) setTextColor:(UIColor*)pColor {
	mResultLabel.textColor = pColor;
}

-(void) setCurrentValue:(CGFloat) pValue {    
	if (pValue < 0 )  pValue = 0;
	if (pValue > mMaxValue) pValue = mMaxValue;	
	mSaveAngle = (M_PI/mMaxValue)*pValue;
    DLog(@"*mSaveAngle = %f",mSaveAngle);
	mCurrentAngle = mSaveAngle;
	CGAffineTransform cgaRotate = CGAffineTransformMakeRotation(mSaveAngle);
    
	mTimeChange.transform = cgaRotate;	
	mResultLabel.text = [NSString stringWithFormat:@"Vol:%i",(NSInteger)pValue];
	mValue = [NSString stringWithFormat:@"%i",pValue];	
	if (mCurrentType == VKDialTypeChanel) {
		if (pValue <0)  pValue = 0;
		if (pValue > mMaxValue) pValue = mMaxValue;		
		mSaveAngle = (M_PI/mMaxValue)*pValue;
		mCurrentAngle = mSaveAngle;
		CGAffineTransform cgaRotate = CGAffineTransformMakeRotation(mSaveAngle);
		mTimeChange.transform = cgaRotate;
		if (pValue == 0) {
			mResultLabel.text = [NSString stringWithFormat:@"Pan:L"];
		} else {
			if (pValue == 1) {
				mResultLabel.text = [NSString stringWithFormat:@"Pan:LC"];
			} else {
				if (pValue == 2) {
					mResultLabel.text = [NSString stringWithFormat:@"Pan:C"];
				} else {
					if (pValue == 3) {
						mResultLabel.text = [NSString stringWithFormat:@"Pan:RC"];
					} else {
						mResultLabel.text = [NSString stringWithFormat:@"Pan:R"];
					}
                }
            }
        }
	}
}	

#pragma mark Delegating
#pragma mark ------------------------
-(void) showValue:(NSInteger)pValue {
    DLog(@"Value:%i",pValue);
    if (mDelegate != nil) {
        if ([mDelegate respondsToSelector:@selector(valueChanged:)]) {
            [mDelegate valueChanged:pValue];
        }
    }
}

-(void) showVolume:(NSInteger)pValue {
  	DLog(@"Volume:%i",pValue);
    if (mDelegate != nil) {
        if ([mDelegate respondsToSelector:@selector(volumeChanged:)]) {
            [mDelegate volumeChanged:pValue];
        }
    }
}

-(void) showPan:(NSString*)pValue {
	DLog(@"Chanel:%@",pValue);
    if (mDelegate != nil) {
        if ([mDelegate respondsToSelector:@selector(panChanged:)]) {
            [mDelegate panChanged:pValue];
        }
    }
}
#pragma mark VolumeSegments
#pragma mark ------------------------
//returns the point on the circle, depending on the angle and radius
-(CGPoint)locationOfCirclePoint:(CGPoint)pLocation:(CGFloat)pAngle:(CGFloat)pRadius{
    CGPoint lDivisionLocation;
    lDivisionLocation.x=pLocation.x-pRadius*cos(pAngle);   
    lDivisionLocation.y=-sqrt(pRadius*pRadius-(lDivisionLocation.x-pLocation.x)*(lDivisionLocation.x-pLocation.x))+pLocation.y;
    return lDivisionLocation;
}
//set hidden to all segments
-(void)setHiddenForDisplayVolumeSegments:(BOOL)hidden{
    for (int i=0; i<=VOLUME_SIGMENTS_NUMBER; i++) {
        [[mImageNamesArray objectAtIndex:i] setHidden:hidden];
    }  
}
//set hidden to choosed segment
-(void)setHiddenForDisplayVolumeSegments:(BOOL)hidden:(NSInteger)index{
    [[mImageNamesArray objectAtIndex:index] setHidden:hidden];         
}
//set hidden NO to one side , and YES - to other side 
-(void)setHiddenForDisplayGroupVolumeSegments:(NSInteger)pMidPoint{//////////////////
    for (int i=0; i<=pMidPoint; i++) {
        [[mImageNamesArray objectAtIndex:i] setHidden:NO];
    }
    for (int i=VOLUME_SIGMENTS_NUMBER; i>pMidPoint; i--) {
        [[mImageNamesArray objectAtIndex:i ] setHidden:YES];
    }
}
-(void)putVolumeSegments{
    int i=0;
    for (float alpha=0; alpha<=M_PI+0.0001; alpha+=M_PI/(VOLUME_SIGMENTS_NUMBER)) {
        [[mImageNamesArray objectAtIndex:i] setFrame:CGRectMake([self locationOfCirclePoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2):alpha :self.bounds.size.width/2+12].x, [self locationOfCirclePoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2):alpha :self.bounds.size.width/2+12].y, 5, 5)];
        [self addSubview:[mImageNamesArray objectAtIndex:i++]];
    }
}
#pragma mark Event handlers
#pragma mark ------------------------
- (void) touchesBegan:(NSSet *)pTouches withEvent:(UIEvent *)pEvent {
    UITouch* lTouch = [pTouches anyObject];
    CGPoint lLocation = [lTouch locationInView: self];
    mLocationBegan = lLocation;    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];    
    [self updateRotation:location];
    [self setHiddenForDisplayGroupVolumeSegments:(int)mNumbSegmentsDisp*(VOLUME_SIGMENTS_NUMBER)/127];    
}

- (void) touchesEnded:(NSSet *)pTouches withEvent:(UIEvent *)pEvent {	
    UITouch* lTouch = [pTouches anyObject];
    CGPoint lLocation = [lTouch locationInView:self];
    mCurrentAngle = [self updateRotation:lLocation];
	mStartLocation = NO;
}

@end
