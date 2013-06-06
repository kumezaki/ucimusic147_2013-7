//
//  AQPlayer.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AQPlayer.h"

#import "Effect_BiQuad.h"
#import "Effect_Delay.h"
#import "Effect_Limiter.h"
#import "Voice_Sample.h"
#import "Voice_Synth.h"
#import "Voice_BLIT.h"
#import "Voice_BLITSaw.h"
#import "Voice_Line.h"

AQPlayer *aqp = nil;

void AQBufferCallback(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inAQBuffer);

void AQBufferCallback(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inAQBuffer)
{
    // compute the requested number of sample frames of audio
	const SInt32 numFrames = (inAQBuffer->mAudioDataBytesCapacity) / sizeof(SInt16);
    
    // create a temporary buffer of Float64 type samples
	Float64 buffer[numFrames];
    
    // set all sample values in buffer to zero (no sound)
    memset(buffer,0,sizeof(Float64)*numFrames);
	
    // call AQPlayer fillAudioBuffer method to get a new block of samples
	[aqp fillAudioBuffer:buffer:numFrames];
	
    // fill the outgoing buffer as SInt16 type samples
	for (SInt32 i = 0; i < numFrames; i++)
		((SInt16 *)inAQBuffer->mAudioData)[i] = buffer[i] * (SInt16)INT16_MAX;
	
    // set the mAudioDataByteSize and mPacketDescriptionCount AudioQueueBuffer fields (for some reason)
	inAQBuffer->mAudioDataByteSize = 512;
	inAQBuffer->mPacketDescriptionCount = 0;
    
	// queue the updated AudioQueueBuffer
	AudioQueueEnqueueBuffer(inAQ, inAQBuffer, 0, nil);
    
    [aqp reportElapsedFrames:numFrames];
}

@implementation AQPlayer

@synthesize sequencer;
@synthesize useDelay;
@synthesize useLimiter;
@synthesize useBiQuad;
@synthesize filterType;

- (void)dealloc {

	[self stop];
    for (UInt8 i = 0; i < kNumVoices; i++)
    {
        voice[i] = nil;
    }for (UInt8 i = 0; i < kNumEffects; i++)
    {
        effect[i] = nil;
    }for (UInt8 i = 0; i < kNumBuffers; i++)
    {
        buffers[i] = nil;
    }
    queue = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
	aqp = self;
    useDelay = false;
    useLimiter = false;
    
    for (int i = 0; i < kNumVoices; i++)
    {
        switch (i)
        {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
                voice[i] = [[Voice_BLIT alloc] init];
                break;
            case 7:
                voice[i] = [[Voice_Synth alloc] init];
                break;
            case 8:
                voice[i] = [[Voice_BLITSaw alloc] init];
                break;
            default:
                break;
        }
    }
    for (UInt8 i = 0; i < kNumEffects; i++)
    {
        switch (i) {
            case LIMITER_EFFECT:
                effect[i] = [[Effect_Limiter alloc] init];
                break;
            case DELAY_EFFECT:
                effect[i] = [[Effect_Delay alloc] init];
                break;
            case BIQUAD_EFFECT:
            {
                Effect_BiQuad* bq = [[Effect_BiQuad alloc] init];
                [bq biQuad_set:filterType :0.:5000.:kSR:1.0];
                effect[i] = bq;
                break;
            }
            default:
                break;
        }
    }

    
    sequencer = [[Sequencer alloc] init];
    
	[self start];
    
	return self;
}

-(void)setup
{
	dataFormat.mFormatID = kAudioFormatLinearPCM;
	dataFormat.mFormatFlags = kAudioFormatFlagIsSignedInteger;
	dataFormat.mChannelsPerFrame = 1;
	dataFormat.mSampleRate = kSR;
	dataFormat.mBitsPerChannel = 16;
	dataFormat.mFramesPerPacket = 1;
	dataFormat.mBytesPerPacket = sizeof(SInt16);
	dataFormat.mBytesPerFrame = sizeof(SInt16);

    OSStatus result = AudioQueueNewOutput(&dataFormat, AQBufferCallback, nil, nil, nil, 0, &queue);
	
	if (result != noErr)
		NSLog(@"AudioQueueNewOutput %ld\n",result);
	
    for (SInt32 i = 0; i < kNumBuffers; i++)
	{
		result = AudioQueueAllocateBuffer(queue, 512, &buffers[i]);
		if (result != noErr)
			NSLog(@"AudioQueueAllocateBuffer %ld\n",result);
	}
}

-(OSStatus)start
{
	OSStatus result = noErr;

    // if we have no queue, create one now
    if (queue == nil)
        [self setup];
    
    // prime the queue with some data before starting
    for (SInt32 i = 0; i < kNumBuffers; ++i)
        AQBufferCallback(nil, queue, buffers[i]);
	
    result = AudioQueueStart(queue, nil);
		
	return result;
}

-(OSStatus)stop
{
	OSStatus result = noErr;

    result = AudioQueueStop(queue, true);
	
	return result;
}


-(Voice*)getVoice:(UInt8)pos
{
    return voice[pos];
}

-(Voice*)getSynthVoice
{
    return voice[2+synthVoice];
}

-(void)setSynthVoice:(UInt8)pos
{
    synthVoice = pos;
}

-(void)reportElapsedFrames:(UInt32)num_frames
{
    [sequencer advanceScoreTime:num_frames/kSR];
    

//    NSLog(@"%f",num_frames/kSR);
}


-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples
{
    for (int i = 0; i < kNumVoices; i++)
    {
        [voice[i] addToAudioBuffer:buffer:num_samples];
    }
    
//    [effect[effectID] processAudioBuffer:buffer:num_samples];
    
        if(useDelay)
            [effect[DELAY_EFFECT] processAudioBuffer:buffer:num_samples];
        if(useLimiter)
            [effect[LIMITER_EFFECT] processAudioBuffer:buffer:num_samples];
        if(useBiQuad)
            [effect[LIMITER_EFFECT] processAudioBuffer:buffer:num_samples];
}

@end
