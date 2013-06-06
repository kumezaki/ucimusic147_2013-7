//
//  StarViewController.h
//  iConcert
//
//  Created by App Jam on 5/14/13.
//
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "AQPlayer.h"

@interface StarViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *star1;
@property (strong, nonatomic) IBOutlet UIImageView *star2;
@property (strong, nonatomic) IBOutlet UIImageView *star3;
@property (strong, nonatomic) IBOutlet UIImageView *star4;
@property (strong, nonatomic) IBOutlet UIImageView *star5;

- (IBAction)menuButton:(UIBarButtonItem *)sender;
-(void)rotateStar:(Float32)rad:(UIImageView *)star;
-(BOOL)isTouchedLeft:(NSSet *)touches:(UIImageView *)imv;
-(BOOL)isTouchedRight:(NSSet *)touches:(UIImageView *)imv;


@end
