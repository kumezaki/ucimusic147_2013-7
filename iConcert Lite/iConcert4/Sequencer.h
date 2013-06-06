//
//  Sequencer.h
//  Music147_2013
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Sequence.h"

@interface Sequencer : NSObject {
    Sequence* seq;
    Float64 scoreTime;
    Float64 bpm;
    BOOL playing;
}

@property (readwrite) Float64 scoreTime;
@property (readwrite) Float64 bpm;

-(void)advanceScoreTime:(Float64)elapsed_seconds;

-(void)play;
-(void)stop;
-(void)rewind;

@end
