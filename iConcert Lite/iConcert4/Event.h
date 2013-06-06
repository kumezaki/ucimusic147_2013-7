//
//  Event.h
//  Music147_2013
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Voice.h"

@interface Event : NSObject {
    Float64 startTime;
    Float64 duration;
    SInt16 noteNum;
    BOOL on;
    Voice* voice;    
}

@property (readwrite) Float64 startTime;
@property (readwrite) Float64 duration;
@property (readwrite) SInt16 noteNum;
@property (readwrite) BOOL on;

-(void)doOn;
-(void)doOff;

@end
