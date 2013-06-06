//
//  ViewController.m
//  iConcert
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "QuartzCore/QuartzCore.h"

@implementation ViewController
@synthesize sidebar;
@synthesize changeText;
@synthesize changeTitle;
@synthesize conductorView;
@synthesize feedbackView;
//@synthesize doneButton;
//@synthesize inputAccView;
@synthesize tempo = _tempo;
@synthesize chord = _chord;
@synthesize beat = _beat;
@synthesize pick;
@synthesize bpmLabel;
@synthesize chordLabel;
@synthesize insLabel;
@synthesize beater;
@synthesize cmtText;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    playMetronome = false;
    _tempo = [[NSArray alloc] initWithObjects:@"80",@"85",@"90",@"95",@"100",@"105",@"110",@"115",@"120",@"125",@"130",@"135",@"140",@"145",@"150",@"155",@"160", nil];
    _chord = [[NSArray alloc] initWithObjects:@"C",@"C#/Db",@"D",@"D#/Eb",@"E",@"F",@"F#/Gb", @"G",@"G#/Ab",@"A",@"A#/Bb",@"B",nil];
    _beat = [[NSArray alloc] initWithObjects:@"2/4",@"3/4",@"4/4",nil];
    speed = 60.00/bpm;
    timer = [NSTimer scheduledTimerWithTimeInterval:speed target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    //Somehow make UITextView look like UITextField
    //The below fails to do this:
    [feedbackView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [feedbackView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [feedbackView.layer setBorderWidth: 1.0];
    [feedbackView.layer setCornerRadius:8.0f];
    [feedbackView.layer setMasksToBounds:YES];
    cmtText.delegate = self;
}

- (void)viewDidUnload
{
    [self setSidebar:nil];
    [self setChangeText:nil];
    [self setChangeTitle:nil];
    [self setConductorView:nil];
    [self setFeedbackView:nil];
    [self setPick:nil];
    [self setSetButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)update{
    if(!playMetronome) return;
    beatCount +=1;
    switch (beater) {
        case 0:
            if(beatCount>2) beatCount = 1;
            break;
        case 1:
            if(beatCount>3) beatCount = 1;
            break;
        case 2:
            if(beatCount>4) beatCount = 1;
            break;
        default:
            break;
    }
    
  //  if(beatCount==1) [self playTockSound];
  //  else [self playTickSound];
    
    [self playTickSound];
    
    
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

-(void)cancelEdit:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)showHide:(id)sender
{
    if ([sidebar isHidden])
    {
        [changeTitle setTitle:@"iConcert"];
        [changeText setTitle:@"Stage"];
        [sidebar setHidden:false];
    }
    else
    {
        [changeTitle setTitle:@"Conductor"];
        [changeText setTitle:@"Menu"];
        [sidebar setHidden:true];
    }
}

- (IBAction)conductor:(id)sender
{
    playMetronome = false;
    [changeTitle setTitle:@"Conductor"];
    [changeText setTitle:@"Menu"];
    [sidebar setHidden:true];
    [feedbackView setHidden:true];
    [conductorView setHidden:false];
}

- (IBAction)feedback:(UIButton *)sender
{
    playMetronome = false;
    [changeTitle setTitle:@"Feedback"];
    [changeText setTitle:@"Menu"];
    [sidebar setHidden:true];
    [conductorView setHidden:true];
    [feedbackView setHidden:false];
}

- (IBAction)submitFeedback:(UIButton *)sender
{
    NSString* message =[[NSString alloc] initWithFormat:@"Your comment has been submitted.\nThank you for your feedback"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Feedback" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [changeTitle setTitle:@"iConcert"];
    [changeText setTitle:@"Stage"];
    [conductorView setHidden:false];
    [sidebar setHidden:false];
    [feedbackView setHidden:true];
}

//HUY LOOK AT THIS BELOW IF YOU HAVE TIME
//Supposed to make a toolbar above keyboard so
//I could have a done key... it seems to fail
//and a textview can't just change the key
//like a textfield can... but a text field can
//omly have one line :(

/*-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self createInputAccessoryView];
    [textView setInputAccessoryView:inputAccView];
}

-(void)createInputAccessoryView
{
    inputAccView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 310.0, 40.0)];
    [inputAccView setBackgroundColor:[UIColor lightGrayColor]];
    [inputAccView setAlpha: 0.8];
    
    doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setFrame:CGRectMake(240.0, 0.0f, 80.0f, 40.0f)];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setBackgroundColor:[UIColor greenColor]];
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneTyping) forControlEvents:UIControlEventTouchUpInside];
    
    [inputAccView addSubview:doneButton];
}

-(void)doneTyping
{
    [feedbackTextField resignFirstResponder];
}*/

- (IBAction)drumins:(id)sender
{
    [insLabel setText:[NSString stringWithFormat:@"Drum"]];
    [self performSegueWithIdentifier:@"drumsSegue" sender:self];
}

- (IBAction)windins:(id)sender
{
    [insLabel setText:[NSString stringWithFormat:@"Banquet"]];
    [self performSegueWithIdentifier:@"banquetSegue" sender:self];
}

- (IBAction)stringins:(id)sender
{
    [insLabel setText:[NSString stringWithFormat:@"Heavenly Star"]];
    [self performSegueWithIdentifier:@"starSegue" sender:self];
}

- (IBAction)keyins:(id)sender
{
    [insLabel setText:[NSString stringWithFormat:@"Toon Sync"]];
    [self performSegueWithIdentifier:@"syncSegue" sender:self];
}

// implement metronome
// ask Huy for reference
-(void)playTickSound
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tick"
                                                     ofType:@"caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:path], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

-(void)playTockSound
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tock"
                                                     ofType:@"caf"];
    
    SystemSoundID soundID;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:path], &soundID);
 //   AudioServicesCreateSystemSoundID(mSoundFileURLRef, &soundID);
    AudioServicesPlaySystemSound (soundID);
    
}

// define and implement PickerView
// ask Huy for reference
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==bpm_col) return _tempo.count;
    else if(component==chord_col) return _chord.count;
    else return _beat.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==bpm_col) return [_tempo objectAtIndex:row];
    else if(component==chord_col) return [_chord objectAtIndex:row];
    else return [_beat objectAtIndex:row];
}

-(IBAction)buttonPressed:(id)sender
{
    NSInteger bpm_row = [pick selectedRowInComponent:bpm_col];
    NSInteger chord_row = [pick selectedRowInComponent:chord_col];
    beater = [pick selectedRowInComponent:beat_col];
    printf("%d",beater);
    NSString* bpm_item = [_tempo objectAtIndex:bpm_row];
    NSString* chord_item = [_chord objectAtIndex:chord_row];
    bpm = [bpm_item integerValue];
    speed = 60.00/bpm;
    offset = chord_row;
    playMetronome = true;
    timer = [NSTimer scheduledTimerWithTimeInterval:speed target:self selector:@selector(update) userInfo:nil repeats:YES];
    NSString* message =[[NSString alloc] initWithFormat:@"You have set tempo to %@ bmp on %@ chord",bpm_item, chord_item];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Concert Setting" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [bpmLabel setText:bpm_item];
    [chordLabel setText:chord_item];
    [alert show];
    [self setConductorView:false];
}

@end