//
//  AQPlayer.h
//  Music147_2013
//
//  Created by Kojiro Umezaki on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <Foundation/Foundation.h>
#import "Sequencer.h"
#import "Voice.h"
#import "Globals.h"

@class Effect;

// number of buffers used by system
#define kNumBuffers     3

// number of possible voices
#define kNumVoices      16

// number of possible effects
#define kNumEffects      2

// sample rate
#define kSR				22050.

@interface AQPlayer : NSObject {

	AudioQueueRef				queue;
	AudioQueueBufferRef			buffers[kNumBuffers];
	AudioStreamBasicDescription	dataFormat;
    
    UInt8 synthVoice;
    
    Voice* voice[kNumVoices];
    Effect* effect[kNumEffects];
    
    Sequencer* sequencer;
    
    int effectID;
}

@property (readonly) Sequencer* sequencer;
@property (readwrite) BOOL useDelay;
@property (readwrite) BOOL useLimiter;


-(void)setup;

-(OSStatus)start;
-(OSStatus)stop;

-(Voice*)getVoice:(UInt8)pos;

-(Voice*)getSynthVoice;
-(void)setSynthVoice:(UInt8)pos;
-(void)reportElapsedFrames:(UInt32)num_frames;

-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples;
@end
