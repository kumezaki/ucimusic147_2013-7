//
//  Voice_Line.m
//  iConcert
//
//  Created by App Jam on 5/24/13.
//
//

#import "Voice_Line.h"
#import "Globals.h"
#import "AQPlayer.h"

@implementation Voice_Line

-(void)setFreq:(Float64)_freq
{
    [super setFreq:_freq];
}

-(void)addToAudioBuffer:(Float64*)buffer:(UInt32)num_samples
{
    // compute normalized angular frequency
    Float64 deltaNormPhase = freq / kSR;
    
    // iterate through each element in the buffer
    for (UInt32 i = 0; i < num_samples; i++)
    {
        // assign value of sinusoid at phase position to buffer element
		if (soundChoice==0)
            buffer[i] += amp * normPhase * i / num_samples;
        else if (soundChoice==1)
            buffer[i] += amp * normPhase * (i%10)/10;
        
        // advance the phase position
		normPhase += deltaNormPhase;
    }
}


@end
