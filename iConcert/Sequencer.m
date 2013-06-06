//
//  Sequencer.m
//  Music147_2013
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import "Sequencer.h"

@implementation Sequencer

@synthesize scoreTime;
@synthesize bpm;

-(id)init
{
    self = [super init];
    
    seq = [[Sequence alloc] init];
    scoreTime = 0.;
    bpm = 60.;
    playing = NO;
    
    return self;
}

-(void)advanceScoreTime:(Float64)elapsed_seconds
{
    if (!playing) return;
    
    Float64 elapsed_beats = bpm / 60. * elapsed_seconds;
    scoreTime += elapsed_beats;
    
    for (UInt32 i = 0; i < seq.numEvents; i++)
    {
        Event* event = [seq getEvent:i];

        if (scoreTime < event.startTime)
        {
            // WAIT
            if (event.on)
                [event doOff];
        }
        else if (scoreTime >= event.startTime + event.duration)
        {
            // DONE
            if (event.on)
                [event doOff];
        }
        else
        {
            // PLAYING
            if (!event.on)
                [event doOn];
        }
    }
         
}

-(void)play
{
    playing = YES;
}

-(void)stop
{
    playing = NO;

    for (UInt32 i = 0; i < seq.numEvents; i++)
    {
        Event* event = [seq getEvent:i];
        [event doOff];
    }
}

-(void)rewind
{
    scoreTime = 0.;
}

@end
