//
//  Voice_Synth.m
//  Music147_2013
//
//  Created by Kojiro Umezaki on 4/26/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "Voice_Synth.h"
#import "Globals.h"

#import "AQPlayer.h"

@implementation Voice_Synth

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
		if(toonChoice == 0)
            buffer[i] += amp * fabs(sin(normPhase * 2 * M_PI));
        else if (toonChoice ==1)
            buffer[i] += amp * sin(normPhase * 2 * M_PI);
        else
            buffer[i] += amp * sin(normPhase * M_PI);
        
        // advance the phase position
		normPhase += deltaNormPhase;
    }
}

@end
