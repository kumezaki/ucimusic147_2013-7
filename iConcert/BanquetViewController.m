//
//  BanquetViewController.m
//  iConcert
//
//  Created by App Jam on 5/14/13.
//
//

#import "BanquetViewController.h"

#import "AQPlayer.h"
extern AQPlayer *aqp;
@interface BanquetViewController ()

@end

@implementation BanquetViewController

@synthesize table;

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
    aqp.useDelay = true;
    [aqp start];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButton:(UIBarButtonItem *)sender
{
    [self mute];
    aqp.useDelay = false;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)play:(int)slideID :(Float64)pos{
    [aqp getVoice:slideID].amp = 1-(pos-200)/120;
    [aqp getVoice:slideID].speed = bpm;
    [aqp getVoice:slideID].freq = bpmArray[offset + stepArray[slideID]];
}

-(void)mute{
    for(int i=0; i<7;i++){
        [aqp getVoice:i].amp = 0;
        [aqp getVoice:i].freq = 0;
        [aqp getVoice:i].speed = 0;
    }
    
}

-(void)muteAllButOne:(int)pos{
    for(int i=0; i<7;i++){
        if(i != pos)
            [aqp getVoice:i].freq = 0;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch* t in touches)
    {
        CGPoint pt = [t locationInView:table];
        Float64 x = pt.x;
        
        int y = (int) (pt.y-20)/60;
        
        if(y>=0 && y<=6 && x>=195 && x<=320){
            y = 6-y;
            [self muteAllButOne:y];
            [self play:y :x];
            if(x>315)
                [aqp getVoice:y].amp = 0;
        }else [self mute];
    //    touch = t;
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesBegan:touches withEvent:event];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self mute];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self mute];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    aqp.useDelay = false;
    [self mute];
    [aqp dealloc];
}
@end
