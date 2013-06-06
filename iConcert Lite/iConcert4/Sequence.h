//
//  Sequence.h
//  Music147_2013
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 Kojiro Umezaki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Event.h"

#define kMaxNumSeqEvents 100

@interface Sequence : NSObject {
    Event* events[kMaxNumSeqEvents];
    UInt32 numEvents;
}

@property (readwrite) UInt32 numEvents;

-(Event*)getEvent:(UInt32)pos;

@end
