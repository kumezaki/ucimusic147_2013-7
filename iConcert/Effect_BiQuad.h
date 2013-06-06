//
//  Effect_BiQuad.h
//  iConcert
//
//  Created by App Jam on 5/25/13.
//
//

#import "Effect.h"
enum {
    LPF, /* low pass filter */
    HPF, /* high pass filter */
    BPF, /* band pass filter */
    NOTCH, /* notch filter */
    PEQ, /* peaking band EQ filter */
    LSH, /* low shelf filter */
    HSH /* high shelf filter */
};

/* whatever sample type you want */
typedef Float64 smp_type;

/* this holds the data required to update samples thru a filter */
typedef struct {
    Float64 a0, a1, a2, a3, a4;
    Float64 x1, x2, y1, y2;
}
biquad;

@interface Effect_BiQuad : Effect {
    biquad* b;
}

-(smp_type) biQuad:(smp_type)sample;

-(void) biQuad_set:(int)type:(Float64)dbGain:(Float64)freq:(Float64)srate:(Float64)bandwidth;


@end
