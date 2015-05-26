//
//  RecordViewController.m
//  EZAudioRecordExample
//
//  Created by Syed Haris Ali on 12/15/13.
//  Copyright (c) 2013 Syed Haris Ali. All rights reserved.
//

#import "KZRecordViewController.h"
#import "KZRecordNavigationViewController.h"
#import "KZSongsListViewController.h"
#import "KZFileManager.h"
#import "KZTextAlert.h"
#import "KZRainbow.h"
@interface KZRecordViewController ()<KZTextAlertDelegate>
// Using AVPlayer for example
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, weak) IBOutlet UISwitch *microphoneSwitch;
@property (nonatomic, weak) IBOutlet UILabel *microphoneTextField;
@property (nonatomic, weak) IBOutlet UIButton *playButton;
@property (nonatomic, weak) IBOutlet UILabel *playingTextField;
@property (nonatomic, weak) IBOutlet UISwitch *recordSwitch;
@property (nonatomic, weak) IBOutlet UILabel *recordingTextField;
@property (nonatomic, weak) IBOutlet UIButton *recordBtn;
@property (nonatomic, weak) IBOutlet KZTextAlert *textAlert;
@property (nonatomic, strong) NSString *songPath;
@property (nonatomic, assign) BOOL isPlaying;
@end

@implementation KZRecordViewController

@synthesize audioPlot;
@synthesize microphone;
@synthesize microphoneSwitch;
@synthesize microphoneTextField;
@synthesize playButton;
@synthesize playingTextField;
@synthesize recorder;
@synthesize recordSwitch;
@synthesize recordingTextField;

#pragma mark - Initialization


#pragma mark - Initialize View Controller Here
- (void)initializeViewController {
    self.microphone = [EZMicrophone microphoneWithDelegate:self];
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [self initializeViewController];
        
    }
    return self;
}

#pragma mark - Customize the Audio Plot
-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.textAlert = [KZTextAlert textAlert];
    self.textAlert.delegate = self;
    [self.view addSubview:self.textAlert];
    self.textAlert.center = CGPointMake(self.view.bounds.size.width / 2.0f, -self.view.bounds.size.height / 2.0f);

//    [self.recordBtn setImage:[UIImage imageNamed:@"record_btn.png"] forState:UIControlStateNormal];
    /*
     Customizing the audio plot's look
     */
    // Background color
    self.audioPlot.backgroundColor = [UIColor colorWithRed: 0.984 green: 0.71 blue: 0.365 alpha: 1];
    // Waveform color
    self.audioPlot.color           = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    // Plot type
    self.audioPlot.plotType        = EZPlotTypeBuffer;
    // Fill
    self.audioPlot.shouldFill      = NO;
    // Mirror
    self.audioPlot.shouldMirror    = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.microphone startFetchingAudio];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    if (self.recorder)
//    {
//        [self.recorder closeAudioFile];
//    }
    [self.microphone stopFetchingAudio];
}

#pragma mark - Actions
- (void)playFile:(id)sender {
 
    [self.microphone stopFetchingAudio];
    self.isRecording = NO;
    
    // Create Audio Player
    if(self.audioPlayer)
    {
        if( self.audioPlayer.playing )
        {
            [self.audioPlayer stop];
        }
        self.audioPlayer = nil;
    }
    
    // Close the audio file
    if( self.recorder )
    {
        [self.recorder closeAudioFile];
    }
    
    NSError *err;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:self.songPath]
                                                              error:&err];
    [self.audioPlayer play];
    self.audioPlayer.delegate = self;
    
}

-(void)toggleRecording:(BOOL)isOn {

    self.isRecording = isOn;
    if(isOn) {
        
        self.recorder = [EZRecorder recorderWithDestinationURL:[NSURL URLWithString:self.songPath]
                                                  sourceFormat:self.microphone.audioStreamBasicDescription
                                           destinationFileType:EZRecorderFileTypeM4A];
    } else {
        [self.recorder closeAudioFile];
    }
}

#pragma mark - EZMicrophoneDelegate
#warning Thread Safety
// Note that any callback that provides streamed audio data (like streaming microphone input) happens on a separate audio thread that should not be blocked. When we feed audio data into any of the UI components we need to explicity create a GCD block on the main thread to properly get the UI to work.
-(void)microphone:(EZMicrophone *)microphone
 hasAudioReceived:(float **)buffer
   withBufferSize:(UInt32)bufferSize
withNumberOfChannels:(UInt32)numberOfChannels {
    
    __weak KZRecordViewController *lWeakSelf_ = self;
    dispatch_async(dispatch_get_main_queue(),^{
        [lWeakSelf_.audioPlot updateBuffer:buffer[0] withBufferSize:bufferSize];
    });
}

-(void)microphone:(EZMicrophone *)microphone
    hasBufferList:(AudioBufferList *)bufferList
   withBufferSize:(UInt32)bufferSize
withNumberOfChannels:(UInt32)numberOfChannels {
    
    if(self.recorder && self.isRecording) {
        [self.recorder appendDataFromBufferList:bufferList withBufferSize:bufferSize];
    }
}

#pragma mark - AVAudioPlayerDelegate
/*
 Occurs when the audio player instance completes playback
 */
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
}

#pragma mark - Interruption handlers
- (IBAction)homeBtnPressed:(id)sender {
    __weak KZRecordViewController *lWeakSelf_ = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [lWeakSelf_.navigationController popToRootViewControllerAnimated:YES];
    });
}

- (IBAction)recordBtnPressed:(id)sender {
    if (_isRecording) {
        
        UIActionSheet *lActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Delete" destructiveButtonTitle:nil otherButtonTitles:@"Save", nil];
        [lActionSheet showInView:self.view];
    } else {
        self.textAlert.center = CGPointMake(self.view.bounds.size.width / 2.0f, self.view.bounds.size.height / 2.0f);
    }
}

- (IBAction)detailedReviewBtnPressed:(id)sender {
    
}

- (IBAction)listOfSongsBtnPressed:(id)sender {
    KZSongsListViewController *lSongsListVC = [[KZSongsListViewController alloc] initWithNibName:@"KZSongsListViewController" bundle:nil];
    [self.navigationController pushViewController:lSongsListVC animated:YES];
}

- (IBAction)goNextBtnPressed:(id)sender {
    KZRecordNavigationViewController *lGoNextNavVC = [[KZRecordNavigationViewController alloc] initWithNibName:@"KZRecordNavigationViewController" bundle:nil];
    [self.navigationController pushViewController:lGoNextNavVC animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self.recordBtn setTitle:@"Record" forState:UIControlStateNormal];
    self.isRecording = NO;
    if (actionSheet.tag == 0) {
        switch (buttonIndex) {
            case 0:{//save
                
                if (self.recorder)
                {
                    [self.recorder closeAudioFile];
                }
                [self.microphone stopFetchingAudio];
                break;
            }
            case 1:{//cancel delete
                
                [KZFileManager removeFileAtPath:self.songPath];
                
                break;
            }
            default:
                break;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    DLog(@"actionSheet: %li",(long)buttonIndex);
    if (alertView.tag == 0) {
        switch (buttonIndex) {
            case 0:{
                break;
            }
            case 1:{
                break;
            }
            case 2:{
                break;
            }
            default:
                break;
        }
    }
}

- (void)KZTextAlert:(KZTextAlert *)textAlert gotText:(NSString *)text {
    [UIView animateWithDuration:0.3f animations:^{
       textAlert.center = CGPointMake(self.view.bounds.size.width / 2.0f, -self.view.bounds.size.height / 2.0f);
    }];
    self.songPath = [NSString stringWithFormat:@"%@/%@.m4a",[KZFileManager defaultFolderPath], text];
    self.isRecording = YES;
    [self toggleRecording:YES];
    [self.recordBtn setTitle:@"Stop" forState:UIControlStateNormal];
}

@end
