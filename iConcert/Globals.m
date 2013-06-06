//
//  Globals.m
//  iConcert
//
//  Created by App Jam on 5/18/13.
//
//

#import "Globals.h"

@implementation Globals

NSInteger bpm = 80;
NSInteger offset = 0;
int bpmArray[] = {523.2511, 554.365262, 587.3295358, 622.2539674, 659.2551138, 698.4564629, 739.9888454, 783.990872, 830.6093952, 880, 932.327523, 987.7666025, 1046.502261, 1108.730524, 1174.659072, 1244.507935, 1318.510228, 1396.912926, 1479.977691, 1567.981744, 1661.21879, 1760, 1864.655046, 1975.533205, 2093.004522};

int stepArray[] = {0,2,4,5,7,9,11};
int smallStepArray[] = {1,3,6,8,10};
int toonChoice = 0;
int soundChoice = 0;
BOOL playMetronome = false;

@end
