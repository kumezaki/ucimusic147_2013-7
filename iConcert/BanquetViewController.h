//
//  BanquetViewController.h
//  iConcert
//
//  Created by App Jam on 5/14/13.
//
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "AQPlayer.h"

@interface BanquetViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *table;

- (IBAction)menuButton:(UIBarButtonItem *)sender;
- (IBAction)play:(int)slideID:(Float64)pos;
-(void)end;
- (void)mute;
-(void)muteAllButOne:(int)pos;

@end
