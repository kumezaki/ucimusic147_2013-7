//
//  Globals.h
//  iConcert
//
//  Created by App Jam on 5/18/13.
//
//

#import <Foundation/Foundation.h>

#define BIQUAD_EFFECT 2
#define DELAY_EFFECT 1
#define LIMITER_EFFECT 0


@interface Globals : NSObject

extern NSInteger bpm;
extern NSInteger offset;
extern int bpmArray[];
extern int stepArray[];
extern int smallStepArray[];
extern int toonChoice;
extern int soundChoice;
extern BOOL playMetronome;

@end
