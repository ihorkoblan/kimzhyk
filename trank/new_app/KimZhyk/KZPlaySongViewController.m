//
//  KZPlaySongViewController.m
//  KimZhyk
//
//  Created by Ihor on 6/7/15.
//  Copyright (c) 2015 HostelDevelopers. All rights reserved.
//

#import "KZPlaySongViewController.h"
#import "EPSSampler.h"
#import "KZInstrumentsHelper.h"

@interface KZPlaySongViewController () {
    BOOL _isPlaying;
}
@property (nonatomic, strong) DBSong *song;
@property (nonatomic, strong) EPSSampler *sampler;
@property (nonatomic, strong) NSMutableArray *notes;
@end

@implementation KZPlaySongViewController

- (instancetype)initWithSong:(DBSong *)song {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        _isPlaying = NO;
        self.navigationController.navigationBarHidden = NO;
        self.sampler = [[EPSSampler alloc] initWithPresetURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Trombone" ofType:@"aupreset"]]];
        self.song = song;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.song.name;
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"start_playing" ascending:YES];
    self.notes =  [NSMutableArray arrayWithArray:[self.song.notes sortedArrayUsingDescriptors:@[descriptor]]];
}

- (void)playNote:(DBNote *)note {
    [self.sampler startPlayingNote:note.note_value withVelocity:255.0];
}

- (void)stopNote:(DBNote *)note {
    [self.sampler stopPlayingNote:note.note_value];
}

- (IBAction)playSoundBtnPressed:(id)sender {
    _isPlaying = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    for (DBNote *note in self.notes) {
        [self performSelector:@selector(playNote:) withObject:note afterDelay:note.start_playing];
        [self performSelector:@selector(stopNote:) withObject:note afterDelay:note.start_playing + note.duration];
    }
}

- (IBAction)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end