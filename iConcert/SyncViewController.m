//
//  SyncViewController.m
//  iConcert
//
//  Created by App Jam on 5/14/13.
//
//
#import "Voice_Synth.h"
#import "SyncViewController.h"
#import "AQPlayer.h"
extern AQPlayer *aqp;
@interface SyncViewController ()

@end

@implementation SyncViewController
@synthesize keyKitty;
@synthesize keyDoraemon;
@synthesize keyPacman;
@synthesize keyScoobyDoo;
@synthesize keyTomJerry;
@synthesize keyKirby;
@synthesize keyPikachu;
@synthesize keyPowerpuff;
BOOL change;
int orientation;
int delta;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(aqp==nil)
        aqp = [[AQPlayer alloc] init];
    [aqp start];
    orientation = 0;
    delta = 1;
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    [self mute];
    [aqp dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mute{
    [aqp getVoice:7].amp = 0;
    [aqp getVoice:7].freq = 0;
    [aqp getVoice:7].speed= 0;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [aqp getVoice:7].amp = 0.5;
    if([self isTouched:touches :keyKitty]){
        [aqp getVoice:7].freq = bpmArray[offset + smallStepArray[4]];
    }else if([self isTouched:touches :keyTomJerry]){
        [aqp getVoice:7].freq = bpmArray[offset + smallStepArray[3]];
    }else if([self isTouched:touches :keyDoraemon]){
        [aqp getVoice:7].freq = bpmArray[offset + smallStepArray[2]];
    }else if([self isTouched:touches :keyPacman]){
        [aqp getVoice:7].freq = bpmArray[offset + smallStepArray[1]];
    }else if([self isTouched:touches :keyScoobyDoo]){
        [aqp getVoice:7].freq = bpmArray[offset + smallStepArray[0]];
    }else if([self isTouched:touches :keyPowerpuff]){
        toonChoice = 0;
        [self mute];
    }
    else if([self isTouched:touches :keyPikachu]){
        toonChoice = 1;
        [self mute];
    }
    else if([self isTouched:touches :keyKirby]){
        toonChoice = 2;
        [self mute];
    }
    else {
        [self mute];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(orientation>10) delta = -1;
    if (orientation< -10) delta = 1;
    orientation += delta;
    [aqp getVoice:7].freq += orientation;
    
}

-(BOOL)isTouched:(NSSet *)touches:(UIImageView *)imv
{
    for (UITouch* t in touches)
    {
        CGPoint pt = [t locationInView:imv];
        Float64 x = pt.x/imv.bounds.size.width;
        Float64 y = pt.y/imv.bounds.size.height;
        
        if(x>0 && x<1 && y>0 && y<1)
            return true;
    }
    return false;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(mute) userInfo:nil repeats:NO];

}

- (IBAction)menuButton:(UIBarButtonItem *)sender
{
    [self mute];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
