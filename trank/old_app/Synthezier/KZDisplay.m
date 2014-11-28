//
//  KZDisplay.m
//  Synthezier
//
//  Created by ihor on 08.07.14.
//
//

#import "KZDisplay.h"

@implementation KZDisplay

@synthesize volume = _volume;
@synthesize transpose = _transpose;
@synthesize note = _note;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        UIImageView *lBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"screen@2x.png"]];
        [lBackground setFrame:frame];
        [self addSubview:lBackground];

        UILabel *lNoteTextAtInfoDisplay=[[UILabel alloc] initWithFrame:CGRectMake(35.0f, frame.size.height / 3, 56.0f, 10.0f)];
        [lNoteTextAtInfoDisplay setText:@"NOTE"];
        [lNoteTextAtInfoDisplay setBackgroundColor:[UIColor clearColor]];
        lNoteTextAtInfoDisplay.transform = CGAffineTransformMakeRotation(90.0 / 180 * M_PI);
        [lNoteTextAtInfoDisplay setFont:[UIFont fontWithName:@"Crystal" size:10]] ;
        [self addSubview:lNoteTextAtInfoDisplay];

        UILabel *lTransposeTextInInfoDisplay = [[UILabel alloc] initWithFrame:CGRectMake(35.0f, 2 * frame.size.height / 3, 56, 10)];
        [lTransposeTextInInfoDisplay setText:@"TRANSPOSE"];
        [lTransposeTextInInfoDisplay setBackgroundColor:[UIColor clearColor]];
        lTransposeTextInInfoDisplay.transform = CGAffineTransformMakeRotation(90.0 / 180 * M_PI);
        [lTransposeTextInInfoDisplay setFont:[UIFont fontWithName:@"Crystal" size:10]] ;
        [self addSubview:lTransposeTextInInfoDisplay];

        UILabel *lVolumeTextInInfoDisplay = [[UILabel alloc] initWithFrame:CGRectMake(35.0f, frame.size.height, 56, 10)];
        [lVolumeTextInInfoDisplay setText:@"VOLUME"];
        [lVolumeTextInInfoDisplay setBackgroundColor:[UIColor clearColor]];
        lVolumeTextInInfoDisplay.transform = CGAffineTransformMakeRotation(90.0/180*M_PI);
        [lVolumeTextInInfoDisplay setFont:[UIFont fontWithName:@"Crystal" size:10]] ;
        [self addSubview:lVolumeTextInInfoDisplay];

        
        _noteValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, frame.size.height / 3, 40, 21)];
        [_noteValueLabel setBackgroundColor:[UIColor clearColor ]];
        _noteValueLabel.transform = CGAffineTransformMakeRotation(90.0 / 180 * M_PI);
        [_noteValueLabel setFont:[UIFont fontWithName:@"Crystal" size:19.0f]];
        [self addSubview:_noteValueLabel];


        //add transpose value to info display
        _transposeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 2 * frame.size.height / 3, 40, 21)];
        [_transposeValueLabel setBackgroundColor:[UIColor clearColor ]];
        _transposeValueLabel.transform=CGAffineTransformMakeRotation(90.0 / 180 * M_PI);
        [ _transposeValueLabel setFont:[UIFont fontWithName:@"Crystal" size:19.0f]] ;
        [self addSubview:_transposeValueLabel];
        
        _volumeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, frame.size.height , 40, 20)];
        [_volumeValueLabel setBackgroundColor:[UIColor clearColor ]];
        _volumeValueLabel.transform=CGAffineTransformMakeRotation(90.0 / 180 * M_PI);
        [ _volumeValueLabel setFont:[UIFont fontWithName:@"Crystal" size:19]] ;
        [self addSubview:_volumeValueLabel];

    }
    return self;
}

- (void)setVolume:(NSUInteger)volume {
    _volume = volume;
    if (_volumeValueLabel) {
        [_volumeValueLabel setText:[NSString stringWithFormat:@"%i", volume]];
    }
}

- (void)setTranspose:(NSInteger)transpose {
    _transpose = transpose;
    if (_transposeValueLabel) {
        [_transposeValueLabel setText:[NSString stringWithFormat:@"%i", transpose]];
    }
}

- (void)setNote:(NSString *)note {
    [note retain];
    [_note release];
    _note = note;
    
    if (_noteValueLabel) {
        [_noteValueLabel setText:note];
    }
}

@end
