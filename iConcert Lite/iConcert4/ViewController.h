//
//  ViewController.h
//  iConcert4
//
//  Created by Lab User on 6/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectScale;
@property (weak, nonatomic) IBOutlet UIButton *buttonE3;
@property (weak, nonatomic) IBOutlet UIButton *buttonA4;
@property (weak, nonatomic) IBOutlet UIButton *buttonB4;
@property (weak, nonatomic) IBOutlet UIButton *buttonE4;
@property (weak, nonatomic) IBOutlet UIButton *buttonA5;
@property (weak, nonatomic) IBOutlet UIButton *buttonB5;
@property (weak, nonatomic) IBOutlet UIButton *limitButt;

- (IBAction)button1:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)button3:(id)sender;
- (IBAction)button4:(id)sender;
- (IBAction)button5:(id)sender;
- (IBAction)button6:(id)sender;
- (IBAction)button7:(id)sender;
- (IBAction)button8:(id)sender;
- (IBAction)button9:(id)sender;
- (IBAction)button10:(id)sender;
- (IBAction)button11:(id)sender;
- (IBAction)button12:(id)sender;
- (IBAction)button13:(id)sender;
- (IBAction)button14:(id)sender;
- (IBAction)button15:(id)sender;
- (IBAction)button16:(id)sender;
-(IBAction)toggleDelay:(id)sender;
-(IBAction)toggleLimit:(id)sender;
- (IBAction)changeSegment:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *delayButt;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlide;
-(IBAction)changeVol:(id)sender;

@end
