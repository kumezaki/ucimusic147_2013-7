//
//  StarViewController.m
//  iConcert
//
//  Created by App Jam on 5/14/13.
//
//

#import "StarViewController.h"
#import "AQPlayer.h"
extern AQPlayer *aqp;
@interface StarViewController ()

@end

@implementation StarViewController
@synthesize star1;
@synthesize star2;
@synthesize star3;
@synthesize star4;
@synthesize star5;


int deg;
int star;
int orient;

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
	// Do any additional setup after loading the view.
    deg = 0;
    star = 0;
    orient = 1;
    if(aqp==nil)
        aqp = [[AQPlayer alloc] init];
    [aqp start];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(update) userInfo:nil repeats:YES];

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

-(void)rotateStar:(Float32)radian :(UIImageView *)star{
    [star setTransform: CGAffineTransformMakeRotation(radian)];
}


-(void)update{
    deg +=2;
    Float32 rad = orient*deg*3.14/180;
    [aqp getVoice:8].freq = bpmArray[offset]*pow(2,3-star) + deg*orient;
    [aqp getVoice:8].amp = 0.5;
    switch (star) {
        case 0:
            [self mute];
            break;
        case 1:
            [self rotateStar:rad :star1];
            break;
        case 2:
            [self rotateStar:rad :star2];
            break;
        case 3:
            [self rotateStar:rad :star3];
            break;
        case 4:
            [self rotateStar:rad :star4];
            break;
        case 5:
            [self rotateStar:rad :star5];
            break;
            
        default:
            break;
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if([self isTouched:touches :star1])star=1;
    else if([self isTouched:touches :star2]) star=2;
    else if([self isTouched:touches :star3]) star=3;
    else if([self isTouched:touches :star4]) star=4;
    else if([self isTouched:touches :star5]) star=5;    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

}

-(BOOL)isTouched:(NSSet *)touches:(UIImageView *)imv{
    return ([self isTouchedLeft:touches :imv]||[self isTouchedRight:touches :imv]);
}

-(BOOL)isTouchedLeft:(NSSet *)touches:(UIImageView *)imv{
    for (UITouch* t in touches)
    {
        CGPoint pt = [t locationInView:imv];
        Float64 x = pt.x/imv.bounds.size.width;
        Float64 y = pt.y/imv.bounds.size.height;
        
        if(x<0.5 && y>0 && y<1){
            orient = -1;
            return true;
        }
    }return false;
}

-(BOOL)isTouchedRight:(NSSet *)touches:(UIImageView *)imv{
    for (UITouch* t in touches)
    {
        CGPoint pt = [t locationInView:imv];
        Float64 x = pt.x/imv.bounds.size.width;
        Float64 y = pt.y/imv.bounds.size.height;
        
        if(x>0.5 && y>0 && y<1){
            orient = 1;
            return true;
        }
    }return false;
}

-(void)mute{
    [aqp getVoice:8].amp = 0;
    [aqp getVoice:8].freq = 0;
    [aqp getVoice:8].speed = 0;
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    star = 0;
    deg = 0;
}


- (IBAction)menuButton:(UIBarButtonItem *)sender
{
    [self mute];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
