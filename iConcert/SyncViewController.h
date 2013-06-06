//
//  SyncViewController.h
//  iConcert
//
//  Created by App Jam on 5/14/13.
//
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "AQPlayer.h"

@interface SyncViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *keyKitty;
@property (strong, nonatomic) IBOutlet UIImageView *keyTomJerry;
@property (strong, nonatomic) IBOutlet UIImageView *keyDoraemon;
@property (strong, nonatomic) IBOutlet UIImageView *keyPacman;
@property (strong, nonatomic) IBOutlet UIImageView *keyScoobyDoo;
@property (strong, nonatomic) IBOutlet UIImageView *keyKirby;
@property (strong, nonatomic) IBOutlet UIImageView *keyPikachu;
@property (strong, nonatomic) IBOutlet UIImageView *keyPowerpuff;

- (IBAction)menuButton:(UIBarButtonItem *)sender;
-(BOOL)isTouched:(NSSet *)touches:(UIImageView *)imv;
-(void)mute;
@end
