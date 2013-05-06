//
//  DataViewController.m
//  initialziji
//
//  Created by macbook on 3/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DataViewController.h"

NSString *datestring; //


@implementation CMMotionManagerViewController
@synthesize SessionNameField = _SessionNameField;
@synthesize timerSliderLabel = timerSliderLabel;
@synthesize repSliderLabel = repSliderLabel;
@synthesize degLeftSliderLabel = degLeftSliderLabel;
@synthesize degRightSliderLabel = degRightSliderLabel;
@synthesize vibrateSwitch = _vibrateSwitch;
@synthesize toneSwitch = _toneSwitch;
@synthesize voiceSwitch = _voiceSwitch;
@synthesize YawLabel = _YawLabel;

int timer = 0;
int sessionStart = 0;
int PlaySoundOption;
int UseVibrateOption;
int UseVoiceOption;
float degoffset;
int samplecount= 0;

@synthesize dataLabel = _dataLabel;
@synthesize dataObject = _dataObject;
@synthesize timerlabel = _timerlabel;
@synthesize timerlabel2 = _timerlabel2;
@synthesize estimatedtimelabel = _estimatedtimelabel;

#define degrees(x) (180.0 * x / M_PI)


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)PlayGoodSound
{
    int PlaySoundOption = _toneSwitch.on;  //this works, but is probably in the wrong place
    int UseVibrateOption = _vibrateSwitch.on;
    int UseVoiceOption = _voiceSwitch.on;
    
    if(PlaySoundOption == 1)
    {
        
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef GoodSoundFileURLRef;
        
        UInt32 soundFileGood;
        
        GoodSoundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR("Ping"), CFSTR("aiff"), NULL);  //placeholder sound// does work
        
        AudioServicesCreateSystemSoundID( GoodSoundFileURLRef,&soundFileGood);
        AudioServicesPlaySystemSound(soundFileGood);
    }
    
    if(UseVibrateOption == 1)
    {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);  //vibrate is not able to be simulated
    }
    
    if(UseVoiceOption == 1)
    {
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef ForwardSoundFileURLRef;
        
        UInt32 soundFileForward;
        
        ForwardSoundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR("forward"), CFSTR("aiff"), NULL);  //placeholder sound// does work
        
        AudioServicesCreateSystemSoundID( ForwardSoundFileURLRef,&soundFileForward);
        AudioServicesPlaySystemSound(soundFileForward);

    }

    
}

-(void)PlayLeftSound
{
    
    
    if(PlaySoundOption == 1)
    {
        
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef GoodSoundFileURLRef;
        
        UInt32 soundFileGood;
        
        GoodSoundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR("Pop"), CFSTR("aiff"), NULL);  //placeholder sound// does work
        
        AudioServicesCreateSystemSoundID( GoodSoundFileURLRef,&soundFileGood);
        AudioServicesPlaySystemSound(soundFileGood);
    }
    
    if(UseVibrateOption == 1)
    {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);  //vibrate is not able to be simulated,this has been tested on a device
    }
    
    if(UseVoiceOption == 1)
    {
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef LeftSoundFileURLRef;
        
        UInt32 soundFileLeft;
        
        LeftSoundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR("left"), CFSTR("aiff"), NULL);  //placeholder sound// does work
        
        AudioServicesCreateSystemSoundID( LeftSoundFileURLRef,&soundFileLeft);
        AudioServicesPlaySystemSound(soundFileLeft);
  
    }
}

-(void)PlayRightSound
{
    
    
    if(PlaySoundOption == 1)
    {
        
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef GoodSoundFileURLRef;
        
        UInt32 soundFileGood;
        
        GoodSoundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR("Pop"), CFSTR("aiff"), NULL);  //placeholder sound// does work
        
        AudioServicesCreateSystemSoundID( GoodSoundFileURLRef,&soundFileGood);
        AudioServicesPlaySystemSound(soundFileGood);
    }
    
    if(UseVibrateOption == 1)
    {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);  //vibrate is not able to be simulated,this has been tested on a device
    }
    
    if(UseVoiceOption == 1)
    {
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef RightSoundFileURLRef;
        
        UInt32 soundFileRight;
        
        RightSoundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR("right"), CFSTR("aiff"), NULL);  //placeholder sound// does work
        
        AudioServicesCreateSystemSoundID( RightSoundFileURLRef,&soundFileRight);
        AudioServicesPlaySystemSound(soundFileRight);
  
    }
}

-(void)PlayBadSound
{
    
    
    if(PlaySoundOption == 1)
    {
        
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef GoodSoundFileURLRef;
        
        UInt32 soundFileGood;
        
        GoodSoundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR("Purr"), CFSTR("aiff"), NULL);  //placeholder sound// does work
        
        AudioServicesCreateSystemSoundID( GoodSoundFileURLRef,&soundFileGood);
        AudioServicesPlaySystemSound(soundFileGood);
    }
    
    if(UseVibrateOption == 1)
    {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);  //vibrate is not able to be simulated,this has been tested on a device
    }
    
    if(UseVoiceOption == 1)
    {
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef ForwardSoundFileURLRef;
        
        UInt32 soundFileForward;
        
        ForwardSoundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR("forward"), CFSTR("aiff"), NULL);  //placeholder sound// does work
        
        AudioServicesCreateSystemSoundID( ForwardSoundFileURLRef,&soundFileForward);
        AudioServicesPlaySystemSound(soundFileForward);

    }
}

-(float)Calibrate  //needs work
{
    int CurrentDeg = [self readIt];
    int PastDeg = CurrentDeg;
    int i = 0;
    
    while (CurrentDeg > PastDeg + 10 || CurrentDeg < PastDeg - 10) {
        CurrentDeg = [self readIt];
        i++;
        if(i == 2)
        {
            PastDeg = CurrentDeg;
            i = 0;
        }
    }
    
    return PastDeg;
<<<<<<< HEAD
=======
}

-(float)readIt
{
    //  CMAttitude *referenceAttitude;
    CMAttitude *attitude;
    
    CMDeviceMotion *motion = motionmanager.deviceMotion;
    //if (!motion) {
    //    return;
    //}
    
    attitude = motion.attitude;
    
    NSLog(@"roll = %f... pitch = %f ... yaw = %f", degrees(attitude.roll), degrees(attitude.pitch), degrees(attitude.yaw));
    //write code to display yaw to YawValue
    //YawValue.text = @"Hello";
    //[Yawdetect setText:[NSString stringWithFormat:@"Yaw: %f",degrees(attitude.yaw)]];
    //YawValue.text = [NSString stringWithFormat:@"%.1f", degrees(attitude.yaw)];
    
    //NSInteger YawDegrees = degrees(attitude.yaw);
    
    return degrees(attitude.yaw);
    
>>>>>>> 552adb3e8db27a6da395067fa5da473c9a842580
}

-(float)readIt
{
    //  CMAttitude *referenceAttitude;
    CMAttitude *attitude;
    
    CMDeviceMotion *motion = motionmanager.deviceMotion;
    //if (!motion) {
    //    return;
    //}
    
    attitude = motion.attitude;
    
    NSLog(@"roll = %f... pitch = %f ... yaw = %f", degrees(attitude.roll), degrees(attitude.pitch), degrees(attitude.yaw));
    //write code to display yaw to YawValue
    //YawValue.text = @"Hello";
    //[Yawdetect setText:[NSString stringWithFormat:@"Yaw: %f",degrees(attitude.yaw)]];
    //YawValue.text = [NSString stringWithFormat:@"%.1f", degrees(attitude.yaw)];
    
    //NSInteger YawDegrees = degrees(attitude.yaw);
    
    return degrees(attitude.yaw);
    
}






- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib. 
   
    motionmanager = [[CMMotionManager alloc] init];
    motionmanager.deviceMotionUpdateInterval = 1.0/60.0; //60 Hz
    accelerometer.delegate = self; // motionmanager
    [motionmanager startDeviceMotionUpdates];
    /*
     NSTimer *timer;
     timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/60.0)
     target:self
     selector:@selector(readIt)
     userInfo:nil
     repeats:YES];
     */  
    NSLog(@"Did motion manager start?");
    
    
    NSDate *currentDate = [NSDate date];  //currentDate holds the current date/time
    NSDateComponents *comps;
    comps = [[NSDateComponents alloc] init]; 
    NSCalendar *calendar;
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init]; //format date
    [dateformat setDateFormat:@"yyyy-MM-dd--HH-mm-ss"];
    NSString *datestring;
    datestring = [dateformat stringFromDate:currentDate]; //Hopefully a string display date
    //[dateformat release];  //memory , ARC does this function
    
    
    
    
        
   
    if(sessionStart)
    {
    
    }
    
    if(!sessionStart)
    {
        
        timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerfired) userInfo:nil repeats:YES]; 
        
    }
      
    
    
       
    
}

-(void)samplingtimerfired
{
    samplecount++;
<<<<<<< HEAD
    
    
    
    float degrees = [self readIt] + degoffset; //this code works, but the type may be incorrect
    float degleft = 45;// = defleftfunction();
    float degright = -45;//= degrightfunction();
    
    
    _YawLabel.text = [NSString stringWithFormat:@"%f deg",degrees];
    
    NSLog(@"%f Degrees\n",degrees);
    
    if(sessionStart && samplecount ==810)
=======
    
    
    
    float degrees = [self readIt] + degoffset; //this code works, but the type may be incorrect
    float degleft = 90;// = defleftfunction();
    float degright = -90;//= degrightfunction();
    
    NSLog(@"%f Degrees\n",degrees);
    
    if(sessionStart && samplecount ==90)
>>>>>>> 552adb3e8db27a6da395067fa5da473c9a842580
    {
        samplecount = 0;
        
        if(((degrees == degleft) || degrees > degleft) && (degrees >= 0))
        {
            //record rep complete
            [self PlayGoodSound]; //play sound : completed
        }
        
        if((degrees < degleft) && (degrees >= 0))
        {
            [self PlayLeftSound]; //play sound : rotate left
        }
        
        if(((degrees == degright) || degrees < degright) && (degrees <= 0))
        {
            //record rep complete
            [self PlayGoodSound];  //play sound : completed
        }
        
        if((degrees > degright) && (degrees <= 0))
        {
            [self PlayRightSound];//play sound : rotate right
        }
    }  
}


-(void)timerfired
{
    if(sessionStart)
    {
        int endtime = 50;// = endtimefunction();
        
        timer = timer + 1; //this counts by 2s?
        [self.timerlabel2 setText:[NSString stringWithFormat:@"%d sec",(endtime/2) - (timer/2)]]; //if I div by 2 it works properly
        //[self PlayGoodSound]; //just a test
        
        NSLog(@"%i\n",timer);
        
        
        
        if((timer == endtime) || (timer > endtime))
        {
            [samplingtimer invalidate];
            [timer1 invalidate];
            timer1 = nil;
            samplingtimer = nil;
            timer = 0;
            sessionStart = 0;
            //store all data
            
            
            [self.timerlabel2 setText:[NSString stringWithFormat:@"Good Job!!"]];
            
        }
        
        
    }
    
}




- (void)viewDidUnload
{
    [self setTimerlabel:nil];
    [self setTimerlabel2:nil];
    [self setEstimatedtimelabel:nil];
    [self setTimerSliderLabel:nil];
    [self setRepSliderLabel:nil];
    [self setDegLeftSliderLabel:nil];
    [self setDegRightSliderLabel:nil];
    [self setSessionNameField:nil];
    [self setVibrateSwitch:nil];
    [self setToneSwitch:nil];
    [self setVoiceSwitch:nil];
    [self setYawLabel:nil];
    _YawLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
} //this should make the keyboard disappear
 
- (IBAction)timerSlider:(id)sender {
    UISlider *timerSlider = (UISlider *)sender;
    timerSliderLabel.text = [NSString stringWithFormat:@"%.f Min", timerSlider.value];
}

- (IBAction)repSlider:(id)sender {
    UISlider *repSlider = (UISlider *)sender;
    repSliderLabel.text = [NSString stringWithFormat:@"%.f Reps", repSlider.value];
}

- (IBAction)degLeftSlider:(id)sender {
    UISlider *degLeftSlider = (UISlider *)sender;
    degLeftSliderLabel.text = [NSString stringWithFormat:@"%.f Deg", degLeftSlider.value];
}

- (IBAction)degRightSlider:(id)sender {
    UISlider *degRightSlider = (UISlider *)sender;
    degRightSliderLabel.text = [NSString stringWithFormat:@"%.f Deg", degRightSlider.value];
}


- (IBAction)saveButton:(id)sender {
    SQLAppDelegate *appDelegate = (SQLAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        //Create a Coffee Object.
    SessionType *SessionTypeObj = [[SessionType alloc] initWithPrimaryKey:0];
    SessionTypeObj.session_name = self.SessionNameField.text;
    
    SessionTypeObj.session_length_min = (int)self.timerSliderLabel.text;
    
    SessionTypeObj.degrees_L = (int)self.degLeftSliderLabel.text;
    
    SessionTypeObj.degrees_R = (int)self.degRightSliderLabel.text;
    
    SessionTypeObj.num_of_reps = (int)self.repSliderLabel.text;
    
    SessionTypeObj.date_created = [NSDate date];
    
    SessionTypeObj.isDirty = NO;
    
    SessionTypeObj.isDetailViewHydrated = YES;
        
    //Add the object
    [appDelegate addSessionType:SessionTypeObj];
        
    //Dismiss the controller.
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (IBAction)vibrateSwitch:(id)sender {
    UseVibrateOption = _vibrateSwitch.on;
}

- (IBAction)toneSwitch:(id)sender {
    PlaySoundOption = _toneSwitch.on;
}

- (IBAction)voiceSwitch:(id)sender {
    UseVoiceOption = _voiceSwitch.on;
}

- (IBAction)stopButton:(id)sender { //this works, but is a little buggy, should stop timers,maybe
    UseVibrateOption = 0;
    PlaySoundOption = 0;
    UseVoiceOption = 0;
    [_vibrateSwitch setOn:NO];  //this doesnt seem to change the options properly.
    [_toneSwitch setOn:NO];
    [_voiceSwitch setOn:NO];
    [samplingtimer invalidate];
    [timer1 invalidate];
    timer1 = nil;
    samplingtimer = nil;
    sessionStart = 0; 
    timer = 0;
}

- (IBAction)startSessionButton:(id)sender {
    sessionStart = 1;
        
    degoffset = 0 - [self Calibrate];
    
    samplingtimer = [NSTimer scheduledTimerWithTimeInterval:(1/30) target:self selector:@selector(samplingtimerfired) userInfo:nil repeats:YES]; //time not known //why does this not start on the first load?
    
    
}
@end
