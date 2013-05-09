//
//  DataViewController.h
//  initialziji
//
//  Created by macbook on 3/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "Session.h"
#import "SessionType.h"
#import "SQLAppDelegate.h"
#import "ViewController.h"

@class SessionTypeList;

@interface CMMotionManagerViewController : UIViewController <UIAccelerometerDelegate>
{
    SQLAppDelegate *appDelegate;
	NSTimer *timer1;
    NSTimer *samplingtimer;
    
    //IBOutlet UILabel *YawValue;
    //CMMotionManagerViewController *motionManager;
    //IBOutlet UILabel *Yawdetect;
    //IBOutlet UIProgressView *Yawmovement;
    
    UIAccelerometer *accelerometer;
    CMMotionManager *motionmanager;
    UIPickerView *sessionTypeClicker;

    IBOutlet UILabel *YawLabel;
}

-(float)readIt;

@property (weak, nonatomic) IBOutlet UITableView *sessionTypeTable;

@property (weak, nonatomic) IBOutlet UILabel *YawLabel;

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
@property (weak, nonatomic) IBOutlet UITextField *timerlabel;
@property (weak, nonatomic) IBOutlet UILabel *timerlabel2;
@property (weak, nonatomic) IBOutlet UILabel *estimatedtimelabel;
//results' labels
@property (weak, nonatomic) IBOutlet UILabel *Result_time;
@property (weak, nonatomic) IBOutlet UILabel *Result_reps;
@property (weak, nonatomic) IBOutlet UILabel *Result_degL;
@property (weak, nonatomic) IBOutlet UILabel *Result_degR;
@property (weak, nonatomic) IBOutlet UILabel *Result_title;

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



- (IBAction)vibrateSwitch:(id)sender;
- (IBAction)toneSwitch:(id)sender;
- (IBAction)voiceSwitch:(id)sender;

- (IBAction)stopButton:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *vibrateSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *toneSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *voiceSwitch;

- (IBAction)startSessionButton:(id)sender;

@end
