//
//  DrumsViewController.h
//  iConcert
//
//  Created by App Jam on 5/13/13.
//
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "AQPlayer.h"

@interface DrumsViewController : UIViewController
- (IBAction)returnMenu:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *drum1;
@property (strong, nonatomic) IBOutlet UIImageView *drum2;
@property (strong, nonatomic) IBOutlet UIImageView *drum3;
@property (strong, nonatomic) IBOutlet UIImageView *drum4;
@property (strong, nonatomic) IBOutlet UIImageView *drum5;

@end
