//
//  SoundGeneration.m
//  Synthezier
//
//  Created by Lion User on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SoundGeneration.h"
#import <AssertMacros.h>
#import "Global.h"

enum {
	kMIDIMessage_NoteOn    = 0x9,
	kMIDIMessage_NoteOff   = 0x8,
};

// private class extension
@interface SoundGeneration ()
@property (readwrite) Float64   graphSampleRate;
@property (readwrite) AUGraph   processingGraph;
@property (readwrite) AudioUnit samplerUnit;
@property (readwrite) AudioUnit ioUnit;

- (OSStatus)    loadSynthFromPresetURL:(NSURL *) presetURL;
- (void)        registerForUIApplicationNotifications;
- (BOOL)        createAUGraph;
- (void)        configureAndStartAudioProcessingGraph: (AUGraph) graph;
- (void)        stopAudioProcessingGraph;
- (void)        restartAudioProcessingGraph;
@end

@implementation SoundGeneration
@synthesize graphSampleRate     = _graphSampleRate;
@synthesize samplerUnit         = _samplerUnit;
@synthesize ioUnit              = _ioUnit;
@synthesize processingGraph     = _processingGraph;

#pragma mark -
#pragma mark Audio setup
- (BOOL) createAUGraph {
    DLog(@"\n\n1_CreateAUGraph\n\n");
	OSStatus result = noErr;
	AUNode samplerNode, ioNode;
    
    // Specify the common portion of an audio unit's identify, used for both audio units
    // in the graph.
	AudioComponentDescription cd = {};
	cd.componentManufacturer     = kAudioUnitManufacturer_Apple;
	cd.componentFlags            = 0;
	cd.componentFlagsMask        = 0;
    
    // Instantiate an audio processing graph
	result = NewAUGraph (&_processingGraph);
    NSCAssert (result == noErr, @"Unable to create an AUGraph object. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	//Specify the Sampler unit, to be used as the first node of the graph
	cd.componentType = kAudioUnitType_MusicDevice;
	cd.componentSubType = kAudioUnitSubType_Sampler;
	
    // Add the Sampler unit node to the graph
	result = AUGraphAddNode (self.processingGraph, &cd, &samplerNode);
    NSCAssert (result == noErr, @"Unable to add the Sampler unit to the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	// Specify the Output unit, to be used as the second and final node of the graph	
	cd.componentType = kAudioUnitType_Output;
	cd.componentSubType = kAudioUnitSubType_RemoteIO;  
    
    // Add the Output unit node to the graph
	result = AUGraphAddNode (self.processingGraph, &cd, &ioNode);
    NSCAssert (result == noErr, @"Unable to add the Output unit to the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    // Open the graph
	result = AUGraphOpen (self.processingGraph);
    NSCAssert (result == noErr, @"Unable to open the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    // Connect the Sampler unit to the output unit
	result = AUGraphConnectNodeInput (self.processingGraph, samplerNode, 0, ioNode, 0);
    NSCAssert (result == noErr, @"Unable to interconnect the nodes in the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	// Obtain a reference to the Sampler unit from its node
	result = AUGraphNodeInfo (self.processingGraph, samplerNode, 0, &_samplerUnit);
    NSCAssert (result == noErr, @"Unable to obtain a reference to the Sampler unit. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	// Obtain a reference to the I/O unit from its node
	result = AUGraphNodeInfo (self.processingGraph, ioNode, 0, &_ioUnit);
    NSCAssert (result == noErr, @"Unable to obtain a reference to the I/O unit. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    return YES;
}

// Starting with instantiated audio processing graph, configure its 
// audio units, initialize it, and start it.
- (void) configureAndStartAudioProcessingGraph: (AUGraph) pGraph {
    DLog(@"\n\n2_configureAndStartAudioProcessingGraph\n\n");
    OSStatus result = noErr;
    UInt32 framesPerSlice = 0;
    UInt32 framesPerSlicePropertySize = sizeof (framesPerSlice);
    UInt32 sampleRatePropertySize = sizeof (self.graphSampleRate);
    
    result = AudioUnitInitialize (self.ioUnit);
    NSCAssert (result == noErr, @"Unable to initialize the I/O unit. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    // Set the I/O unit's output sample rate.
    result =    AudioUnitSetProperty (
                                      self.ioUnit,
                                      kAudioUnitProperty_SampleRate,
                                      kAudioUnitScope_Output,
                                      0,
                                      &_graphSampleRate,
                                      sampleRatePropertySize
                                      );
    
    NSAssert (result == noErr, @"AudioUnitSetProperty (set Sampler unit output stream sample rate). Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    // Obtain the value of the maximum-frames-per-slice from the I/O unit.
    result =    AudioUnitGetProperty (
                                      self.ioUnit,
                                      kAudioUnitProperty_MaximumFramesPerSlice,
                                      kAudioUnitScope_Global,
                                      0,
                                      &framesPerSlice,
                                      &framesPerSlicePropertySize
                                      );
    
    NSCAssert (result == noErr, @"Unable to retrieve the maximum frames per slice property from the I/O unit. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    // Set the Sampler unit's output sample rate.
    result =    AudioUnitSetProperty (
                                      self.samplerUnit,
                                      kAudioUnitProperty_SampleRate,
                                      kAudioUnitScope_Output,
                                      0,
                                      &_graphSampleRate,
                                      sampleRatePropertySize
                                      );
    
    NSAssert (result == noErr, @"AudioUnitSetProperty (set Sampler unit output stream sample rate). Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    // Set the Sampler unit's maximum frames-per-slice.
    result =    AudioUnitSetProperty (
                                      self.samplerUnit,
                                      kAudioUnitProperty_MaximumFramesPerSlice,
                                      kAudioUnitScope_Global,
                                      0,
                                      &framesPerSlice,
                                      framesPerSlicePropertySize
                                      );
    
    NSAssert( result == noErr, @"AudioUnitSetProperty (set Sampler unit maximum frames per slice). Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    
    if (pGraph) {
        
        // Initialize the audio processing graph.
        result = AUGraphInitialize (pGraph);
        NSAssert (result == noErr, @"Unable to initialze AUGraph object. Error code: %d '%.4s'", (int) result, (const char *)&result);
        
        // Start the graph
        result = AUGraphStart (pGraph);
        NSAssert (result == noErr, @"Unable to start audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
        
        // Print out the graph to the console
        CAShow (pGraph); 
    }
}

-(void)loadPresetInstrument:(NSNumber *)pInstrumentNumber{
    DLog(@"\n\n3_loadPresetInstrument\n\n");
    NSURL *presetURL= nil;
    switch ([pInstrumentNumber integerValue]) {
        case 0:
            DLog(@"PIANO");
            presetURL=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"PIANO" ofType:@"aupreset"]];
            break;
        case 1:
            DLog(@"ACCORDEON");
            presetURL=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ACCORDEON" ofType:@"aupreset"]];
            break;
        case 2:
            DLog(@"CHURCH ORGAN");
            presetURL=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CHURCH_ORGAN" ofType:@"aupreset"]];
            break;
        case 3:
            DLog(@"ACOUSTIC GUITAR");
            presetURL=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ACOUSTIC_GUITAR" ofType:@"aupreset"]];

            break;
        case 4:
            DLog(@"ELECTRIC GUITAR");
            presetURL=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ELECTRIC_GUITAR" ofType:@"aupreset"]];
            break;
        case 5:
            DLog(@"FLUTE");
            presetURL=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"FLUTE" ofType:@"aupreset"]];
            break;
        case 6:
            DLog(@"TENOR SAX");
            presetURL=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"TENNOR_SAX" ofType:@"aupreset"]];
            break;
        case 7:
            DLog(@"CELLO");
            presetURL=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CELLO" ofType:@"aupreset"]];
            break;
        case 8:
            DLog(@"VIOLIN");
            presetURL=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"VIOLIN" ofType:@"aupreset"]];
            break;
        case 9:
            DLog(@"TRUMPET_1");
            presetURL=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"TROMBONE" ofType:@"aupreset"]];
            break;
        case 10:
            DLog(@"STRINGS_1");
            presetURL=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"STRINGS1" ofType:@"aupreset"]];
            break;
        default:
            DLog(@"Error instrument number");
            break;
    }
    DLog(@"Attempting to load preset '%@'\n", presetURL);

	[self loadSynthFromPresetURL: presetURL];
}
// Load a synthesizer preset file and apply it to the Sampler unit
- (OSStatus) loadSynthFromPresetURL: (NSURL *) pPresetURL {
    DLog(@"\n\n5_loadSynthFromPresetURL\n\n");
	CFDataRef propertyResourceData = 0;
	Boolean status;
	SInt32 errorCode = 0;
	OSStatus result = noErr;
	
	// Read from the URL and convert into a CFData chunk
//    NSURL *presetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"TROMBONE" ofType:@"aupreset"]];
    
	status = CFURLCreateDataAndPropertiesFromResource (
                                                       kCFAllocatorDefault,
                                                       (__bridge CFURLRef) pPresetURL,
                                                       &propertyResourceData,
                                                       NULL,
                                                       NULL,
                                                       &errorCode
                                                       );
    
    NSAssert (status == YES && propertyResourceData != 0, @"Unable to create data and properties from a preset. Error code: %d '%.4s'", (int) errorCode, (const char *)&errorCode);
   	
	// Convert the data object into a property list
	CFPropertyListRef presetPropertyList = 0;
	CFPropertyListFormat dataFormat = 0;
	CFErrorRef errorRef = 0;
	presetPropertyList = CFPropertyListCreateWithData (
                                                       kCFAllocatorDefault,
                                                       propertyResourceData,
                                                       kCFPropertyListImmutable,
                                                       &dataFormat,
                                                       &errorRef
                                                       );
   // DLog(@"presetPropertyList %@", presetPropertyList);
    if ([(id)presetPropertyList isKindOfClass:[NSDictionary class]]) {
        NSDictionary *lConverFiles = (NSDictionary*)presetPropertyList;
        NSDictionary *lSoundList = [lConverFiles objectForKey:@"file-references"]; 
        NSArray *lKeyList = [lSoundList allKeys];
        for (NSInteger i = 0; i < [lKeyList count]; i++) {
            NSString *lFileName = [lSoundList objectForKey:[lKeyList objectAtIndex:i]];
            NSString *lBundleString = [[NSBundle mainBundle] bundlePath];
            [lSoundList setValue:[lBundleString stringByAppendingFormat:@"/%@", lFileName] forKey:[lKeyList objectAtIndex:i]];
        }
    }
    //DLog(@"presetPropertyList %@", presetPropertyList);
    // Set the class info property for the Sampler unit using the property list as the value.
	if (presetPropertyList != 0) {
		
		result = AudioUnitSetProperty(
                                      self.samplerUnit,
                                      kAudioUnitProperty_ClassInfo,
                                      kAudioUnitScope_Global,
                                      0,
                                      &presetPropertyList,
                                      sizeof(CFPropertyListRef)
                                      );
        
		CFRelease(presetPropertyList);
	}
    
    if (errorRef) CFRelease(errorRef);
	CFRelease (propertyResourceData);
    
	return result;
}

// Set up the audio session for this app.
- (BOOL) setupAudioSession {
    DLog(@"\n\n6_setupAudioSession\n\n");
    AVAudioSession *mySession = [AVAudioSession sharedInstance];
    
    // Specify that this object is the delegate of the audio session, so that
    //    this object's endInterruption method will be invoked when needed.
    [mySession setDelegate: self];
    
    // Assign the Playback category to the audio session. This category supports
    //    audio output with the Ring/Silent switch in the Silent position.
    NSError *audioSessionError = nil;
    [mySession setCategory: AVAudioSessionCategoryPlayback error: &audioSessionError];
    if (audioSessionError != nil) {DLog (@"Error setting audio session category."); return NO;}    
    
    // Request a desired hardware sample rate.
    self.graphSampleRate = 44100.0;    // Hertz
    
    [mySession setPreferredHardwareSampleRate: self.graphSampleRate error: &audioSessionError];
    if (audioSessionError != nil) {DLog (@"Error setting preferred hardware sample rate."); return NO;}
    
    // Activate the audio session
    [mySession setActive: YES error: &audioSessionError];
    if (audioSessionError != nil) {DLog (@"Error activating the audio session."); return NO;}
    
    // Obtain the actual hardware sample rate and store it for later use in the audio processing graph.
    self.graphSampleRate = [mySession currentHardwareSampleRate];
    
    return YES;
}

#pragma mark -
#pragma mark Audio control
- (void) startPlayNote:(NSInteger)pNote {
    OSStatus result = noErr;
    DLog(@"\n\n7_startPlayNote\n\n");
	NSInteger onVelocity =[[NSUserDefaults standardUserDefaults] integerForKey:@"VolumeValue"];

    
	UInt32 noteCommand = kMIDIMessage_NoteOn << 4 | 0;
    
	require_noerr (result = MusicDeviceMIDIEvent (self.samplerUnit, noteCommand, pNote+[KZSettings settings].transpose, onVelocity, 0), logTheError);
logTheError:
    if (result != noErr) DLog (@"Unable to start playing the low note. Error code: %d '%.4s'\n", (int) result, (const char *)&result);    
}

- (void) stopPlayNote:(NSInteger)pNote{
    DLog(@"\n\n8_stopPlayLowNote\n\n");
	
	UInt32 noteCommand = 	kMIDIMessage_NoteOff << 4 | 0;
    OSStatus result = noErr;
	require_noerr (result = MusicDeviceMIDIEvent (self.samplerUnit, noteCommand, pNote+[KZSettings settings].transpose, 0, 0), logTheError);
    
logTheError:
    if (result != noErr) DLog (@"Unable to stop playing the low note. Error code: %d '%.4s'\n", (int) result, (const char *)&result);
}

// Stop the audio processing graph
- (void) stopAudioProcessingGraph {
    DLog(@"\n\n9_stopAudioProcessingGraph\n\n");
    OSStatus result = noErr;
	if (self.processingGraph) result = AUGraphStop(self.processingGraph);
    NSAssert (result == noErr, @"Unable to stop the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
}

// Restart the audio processing graph
- (void) restartAudioProcessingGraph {
    DLog(@"\n\n10_restartAudioProcessingGraph\n\n");
    OSStatus result = noErr;
	if (self.processingGraph) result = AUGraphStart (self.processingGraph);
    NSAssert (result == noErr, @"Unable to restart the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
}

#pragma mark -
#pragma mark Audio session delegate methods

// Respond to an audio interruption, such as a phone call or a Clock alarm.
- (void) beginInterruption:(NSInteger)pNote {
    DLog(@"\n\n11_beginInterraption\n\n");
    // Stop any notes that are currently playing.
    [self stopPlayNote: pNote];
    
    // Interruptions do not put an AUGraph object into a "stopped" state, so
    //    do that here.
    [self stopAudioProcessingGraph];
}

// Respond to the ending of an audio interruption.
- (void) endInterruptionWithFlags: (NSUInteger) pFlags {
    DLog(@"\n\n12_endInterraptionWithFlags\n\n");
    NSError *endInterruptionError = nil;
    [[AVAudioSession sharedInstance] setActive: YES
                                         error: &endInterruptionError];
    if (endInterruptionError != nil) {
        
        DLog (@"Unable to reactivate the audio session.");
        return;
    }
    if (pFlags & AVAudioSessionInterruptionFlags_ShouldResume) {
        /*
         In a shipping application, check here to see if the hardware sample rate changed from 
         its previous value by comparing it to graphSampleRate. If it did change, reconfigure 
         the ioInputStreamFormat struct to use the new sample rate, and set the new stream 
         format on the two audio units. (On the mixer, you just need to change the sample rate).
         
         Then call AUGraphUpdate on the graph before starting it.
         */
        [self restartAudioProcessingGraph];
    }
}


#pragma mark - Application state management

// The audio processing graph should not run when the screen is locked or when the app has 
//  transitioned to the background, because there can be no user interaction in those states.
//  (Leaving the graph running with the screen locked wastes a significant amount of energy.)
//
// Responding to these UIApplication notifications allows this class to stop and restart the 
//    graph as appropriate.
- (void) registerForUIApplicationNotifications {
    DLog(@"\n\n13_registerForUIApplicationNotification\n\n");
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver: self
                           selector: @selector (handleResigningActive:)
                               name: UIApplicationWillResignActiveNotification
                             object: [UIApplication sharedApplication]];
    
    [notificationCenter addObserver: self
                           selector: @selector (handleBecomingActive:)
                               name: UIApplicationDidBecomeActiveNotification
                             object: [UIApplication sharedApplication]];
    
}


- (void) handleResigningActive: (NSInteger) pNote {
    DLog(@"\n\n14_handleResignActive\n\n");
    [self stopPlayNote: pNote];
    [self stopAudioProcessingGraph];
}


- (void) handleBecomingActive: (id) pNotification {
    DLog(@"\n\n15_handleBecommingActive\n\n");
    [self restartAudioProcessingGraph];
}

-(NSNumber*)returnInstrumentNumber:(NSNumber*)pInstrumentNumber{
    DLog(@"returninstrumentNumber = %@",pInstrumentNumber);
    [self loadPresetInstrument:pInstrumentNumber];
    return pInstrumentNumber;
}

-(void)prepareToUse{
    DLog(@"\n\nprepareToUse\n\n");
    BOOL audioSessionActivated = [self setupAudioSession];
    NSAssert (audioSessionActivated == YES, @"Unable to set up audio session.");
    [self createAUGraph];
    [self configureAndStartAudioProcessingGraph: self.processingGraph];
	[self loadSynthFromPresetURL: [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"PIANO" ofType:@"aupreset"]]];
    [self registerForUIApplicationNotifications];
}
- (void)dealloc
{
//    [delegate release];
//    [mSettingsViewDelegate release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
   // [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

@end
