//
//  DrumsViewController.m
//  iConcert
//
//  Created by App Jam on 5/13/13.
//
//

#import "DrumsViewController.h"
#import "AQPlayer.h"
extern AQPlayer *aqp;
@interface DrumsViewController ()
@end

@implementation DrumsViewController
@synthesize drum1;
@synthesize drum2;
@synthesize drum3;
@synthesize drum4;
@synthesize drum5;

//AQPlayer *aqp;


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
    [aqp getVoice:9].freq = 440;
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




- (void)playDrum1{
    
    [self playOneDrum:@"Tom 1" :@"wav"];
}
- (void)playDrum2{
    
    [self playOneDrum:@"Bass Drum" :@"wav"];
}
- (void)playDrum3{
    
    [self playOneDrum:@"Close Pedal Hi Hat" :@"wav"];
}
- (void)playDrum4{
    
    [self playOneDrum:@"Center Hit Ride" :@"wav"];
}
- (void)playDrum5{
    
    [self playOneDrum:@"Snare Drum" :@"wav"];
}


-(void)playOneDrum:(NSString *)name:(NSString *)filetype
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name
                                                     ofType:filetype];
    
    SystemSoundID soundID;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:path], &soundID);
    //   AudioServicesCreateSystemSoundID(mSoundFileURLRef, &soundID);
    AudioServicesPlaySystemSound (soundID);
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if([self isTouched:touches :drum1])
        [self playDrum1];
    else if([self isTouched:touches :drum2])
        [self playDrum2];
    else if([self isTouched:touches :drum3])
        [self playDrum3];
    else if([self isTouched:touches :drum4])
        [self playDrum4];
    else if([self isTouched:touches :drum5])
        [self playDrum5];
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

- (IBAction)returnMenu:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
