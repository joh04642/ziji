//
//  DataViewController.h
//  initialziji
//
//  Created by macbook on 3/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "Session.h"
#import "SessionType.h"
#import "SQLAppDelegate.h"

@interface DataViewController : UIViewController
{

}



@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
@property (weak, nonatomic) IBOutlet UITextField *timerlabel;
@property (weak, nonatomic) IBOutlet UILabel *timerlabel2;
@property (weak, nonatomic) IBOutlet UILabel *estimatedtimelabel;
- (IBAction)timerSlider:(id)sender;
- (IBAction)repSlider:(id)sender;
- (IBAction)degLeftSlider:(id)sender;
- (IBAction)degRightSlider:(id)sender;
- (IBAction)saveButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *SessionNameField;
@property (weak, nonatomic) IBOutlet UILabel *timerSliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *repSliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *degLeftSliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *degRightSliderLabel;

@property (weak, nonatomic) IBOutlet UISwitch *vibrateSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *toneSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *voiceSwitch;


@end
