//
//  ViewController.h
//  iConcert
//
//  Created by Lab User on 5/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#define bpm_col 0
#define chord_col 1
#define beat_col 2

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    //UIButton *doneButton;
    //UIView *inputAccView;
    IBOutlet UIPickerView *pick;
    NSArray *tempo;
    NSArray *chord;
    NSTimer *timer;
    int beatCount;
    float speed;
    UITextField *cmtText;
}

//@property (nonatomic, retain) UIButton *doneButton;
//@property (nonatomic, retain) UIView *inputAccView;
@property (strong, nonatomic) IBOutlet UILabel *bpmLabel;
@property (strong, nonatomic) IBOutlet UILabel *chordLabel;
@property (strong, nonatomic) IBOutlet UILabel *insLabel;
@property (readwrite) int beater;

- (IBAction)showHide:(id)sender;
- (IBAction)conductor:(id)sender;
- (IBAction)feedback:(UIButton *)sender;
- (IBAction)drumins:(id)sender;
- (IBAction)windins:(id)sender;
- (IBAction)stringins:(id)sender;
- (IBAction)keyins:(id)sender;
- (IBAction)buttonPressed:(id)sender;
- (IBAction)submitFeedback:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *cmtText;

-(void)update;
@property (strong, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (strong, nonatomic) IBOutlet UIButton *setButton;
@property (strong, nonatomic) IBOutlet UIView *sidebar;               // entire bar
@property (strong, nonatomic) IBOutlet UIBarButtonItem *changeText;
@property (strong, nonatomic) IBOutlet UINavigationItem *changeTitle;
@property (strong, nonatomic) IBOutlet UIView *conductorView;
@property (strong, nonatomic) IBOutlet UIView *feedbackView;

@property (nonatomic, retain) IBOutlet UIPickerView *pick;
@property (strong, nonatomic) NSArray *tempo;
@property (strong, nonatomic) NSArray *chord;
@property (strong, nonatomic) NSArray *beat;
@end
