//
//  DataViewController.m
//  initialziji
//
//  Created by macbook on 3/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DataViewController.h"

NSString *datestring; //


@implementation DataViewController
@synthesize SessionNameField = _SessionNameField;
@synthesize timerSliderLabel = timerSliderLabel;
@synthesize repSliderLabel = repSliderLabel;
@synthesize degLeftSliderLabel = degLeftSliderLabel;
@synthesize degRightSliderLabel = degRightSliderLabel;
@synthesize vibrateSwitch = _vibrateSwitch;
@synthesize toneSwitch = _toneSwitch;
@synthesize voiceSwitch = _voiceSwitch;


int timer = 0;
int sessionStart = 0;
int PlaySoundOption;
int UseVibrateOption;
int UseVoiceOption;

@synthesize dataLabel = _dataLabel;
@synthesize dataObject = _dataObject;
@synthesize timerlabel = _timerlabel;
@synthesize timerlabel2 = _timerlabel2;
@synthesize estimatedtimelabel = _estimatedtimelabel;


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
        
        GoodSoundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR("Pop"), CFSTR("aiff"), NULL);  //placeholder sound// does work
        
        AudioServicesCreateSystemSoundID( GoodSoundFileURLRef,&soundFileGood);
        AudioServicesPlaySystemSound(soundFileGood);
    }
    
    if(UseVibrateOption == 1)
    {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);  //vibrate is not able to be simulated
    }
    
    if(UseVoiceOption == 1)
    {

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
        
    }
}

-(void)PlayBadSound
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
        
    }
}

-(void)Calibrate  //needs work
{
    int CurrentDeg;// = degreesfunction();
    int PastDeg = CurrentDeg;
    int i = 0;
    
    while (CurrentDeg > PastDeg + 10 || CurrentDeg < PastDeg - 10) {
        //CurrentDeg = degreesfunction();
        i++;
        if(i == 2)
        {
            PastDeg = CurrentDeg;
            i = 0;
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib. 
   
    
    NSDate *currentDate = [NSDate date];  //currentDate holds the current date/time
    NSDateComponents *comps = [[NSDateComponents alloc] init]; 
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init]; //format date
    [dateformat setDateFormat:@"yyyy-MM-dd--HH-mm-ss"];
    NSString *datestring = [dateformat stringFromDate:currentDate]; //Hopefully a string display date
    //[dateformat release];  //memory , ARC does this function
    
    
    
    
    timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerfired) userInfo:nil repeats:YES]; //needs to be here for timer to work, why does it think it is not used?
    //self.timerlabel.text = datestring; //works
    
   
    if(sessionStart)
    {
    
    }
    
    if(!sessionStart)
    {
     
        
    }
      
    
    
       
    
}

-(void)samplingtimerfired
{
    
    int degrees = [CMMotionmanagerViewController readIt];
    int degleft = 90;// = defleftfunction();
    int degright;//= degrightfunction();
    
    //CMMotionmanagerViewController.YawDegrees;
    
    NSLog(@"%d Degrees\n",degrees);
    
    if(sessionStart)
    {
        
        if(((degrees == degleft) || degrees > degleft) && (degrees >= 0))
        {
            //record rep complete
            [self PlayGoodSound]; //play sound : completed
        }
        
        if((degrees < degleft) && (degrees >= 0))
        {
            [self PlayLeftSound]; //play sound : rotate left
        }
        
        if(((degrees == degright) || degrees > degright) && (degrees <= 0))
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
        timer = timer + 1; //this counts by 2s?
        [self.timerlabel2 setText:[NSString stringWithFormat:@"%d sec",timer/2]]; //if I div by 2 it works properly
        //[self PlayGoodSound]; //just a test
        
        //NSLog(@"%i\n",timer);
        
        
        int endtime = 45;// = endtimefunction();
        if((timer == endtime) || (timer > endtime))
        {
            [samplingtimer invalidate];
            [timer1 invalidate];
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

- (IBAction)startSessionButton:(id)sender {
    sessionStart = 1;
    
    [self Calibrate];
    
    samplingtimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(samplingtimerfired) userInfo:nil repeats:YES]; //time not known //why does this not start on the first load?
    
    
}
@end
