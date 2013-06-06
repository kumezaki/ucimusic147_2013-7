//
//  ViewController.m
//  iConcert4
//
//  Created by Lab User on 6/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AQPlayer.h"
extern AQPlayer *aqp;

@implementation ViewController
@synthesize delayButt;
@synthesize volumeSlide;
@synthesize selectScale;
@synthesize buttonE3;
@synthesize buttonA4;
@synthesize buttonB4;
@synthesize buttonE4;
@synthesize buttonA5;
@synthesize buttonB5;
@synthesize limitButt;
bool isMajor;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (aqp == nil)
    {
        aqp = [[AQPlayer alloc] init];
    }
    isMajor = true;
    aqp.useDelay = false;
    aqp.useLimiter = false;
    [aqp start];
    for(int i=0; i<16; i++){
        [aqp getVoice:i].amp = 0.5;
        [aqp getVoice:i].freq = 0;
    }
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"Major"]){
        selectScale.selectedSegmentIndex = 0;
    }
        
    else selectScale.selectedSegmentIndex = 0;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSelectScale:nil];
    [self setDelayButt:nil];
    [self setVolumeSlide:nil];
    [self setButtonE3:nil];
    [self setButtonA4:nil];
    [self setButtonB4:nil];
    [self setButtonE4:nil];
    [self setButtonA5:nil];
    [self setButtonB5:nil];
    [self setLimitButt:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)stopOne{
    for(int i=0; i<16; i++)
        [aqp getVoice:i].freq = 0;
}


-(void)playASound:(int)pos{
    if(selectScale.selectedSegmentIndex == 0)
		[aqp getVoice:pos].freq = majorKeys[pos];
	else [aqp getVoice:pos].freq = minorKeys[pos];
	[NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(stopOne) userInfo:nil repeats:NO];
    
}


- (IBAction)button1:(id)sender
{
    [self playASound:0];

    
}

- (IBAction)button2:(id)sender
{
    [self playASound:1];    
}

- (IBAction)button3:(id)sender
{
    
    [self playASound:2];
    
}

- (IBAction)button4:(id)sender
{
    [self playASound:3];
    
}

- (IBAction)button5:(id)sender
{
    
    [self playASound:4];
    
}

- (IBAction)button6:(id)sender
{
    [self playASound:5];
    
}

- (IBAction)button7:(id)sender
{
    
    [self playASound:6];
    
}

- (IBAction)button8:(id)sender
{
    [self playASound:7];
    
}

- (IBAction)button9:(id)sender
{
    [self playASound:8];
}

- (IBAction)button10:(id)sender
{
    [self playASound:9];
}

- (IBAction)button11:(id)sender
{
    [self playASound:10];
    
}

- (IBAction)button12:(id)sender
{
   [self playASound:11];
}

- (IBAction)button13:(id)sender
{
   [self playASound:12];
}

- (IBAction)button14:(id)sender
{
    [self playASound:13];
}

- (IBAction)button15:(id)sender
{
    [self playASound:14];
}

- (IBAction)button16:(id)sender
{
    [self playASound:15];
}

-(IBAction)toggleDelay:(id)sender{
    aqp.useDelay = !aqp.useDelay;
}
-(IBAction)toggleLimit:(id)sender{
    aqp.useLimiter = !aqp.useLimiter;
}
- (IBAction)changeSegment:(id)sender
{
    if(selectScale.selectedSegmentIndex==1){
        [buttonE3 setTitle:@"E3b" forState:UIControlStateNormal];
        [buttonA4 setTitle:@"A4b" forState:UIControlStateNormal];
        [buttonB4 setTitle:@"B4b" forState:UIControlStateNormal];
        [buttonE4 setTitle:@"E4b" forState:UIControlStateNormal];
        [buttonA5 setTitle:@"A5b" forState:UIControlStateNormal];
        [buttonB5 setTitle:@"B5b" forState:UIControlStateNormal];
    }else{
        [buttonE3 setTitle:@"E3" forState:UIControlStateNormal];
        [buttonA4 setTitle:@"A4" forState:UIControlStateNormal];
        [buttonB4 setTitle:@"B4" forState:UIControlStateNormal];
        [buttonE4 setTitle:@"E4" forState:UIControlStateNormal];
        [buttonA5 setTitle:@"A5" forState:UIControlStateNormal];
        [buttonB5 setTitle:@"B5" forState:UIControlStateNormal];
    }
}

-(IBAction)changeVol:(id)sender{
    for(int i=0; i<16; i++)
        [aqp getVoice:i].amp = volumeSlide.value;
}
@end
