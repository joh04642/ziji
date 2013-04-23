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
    
    
    NSTimer *timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerfired) userInfo:nil repeats:YES]; //needs to be here for timer to work, why does it think it is not used?
    //self.timerlabel.text = datestring; //works
    
   
    
    /*
    
    Calibrate();
    
    NSTimer *samplingtimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(samplingtimerfired) userInfo:nil repeats:YES]; //time not known
    
    int endtime = endtimefunction();
    
    if(timer == endtime || timer > endtime)
    {
        //store all data
    }
    
    
    */
    
    
       
    
}

-(void)samplingtimerfired
{
    /*
    int degrees = yawfunction();
    int degleft = defleftfunction();
    int degright = degrightfunction();
    
    
    
    if(degrees == (degleft || degrees > degleft) && degrees > 0)
    {
        //record rep complete
        //play sound : completed
    }
    
    if(degrees < degleft && degrees > 0)
    {
        //play sound : rotate left
    }
    
    if(degrees == (degright || degrees > degright) && degrees < 0)
    {
        //record rep complete
        //play sound : completed
    }
    
    if(degrees > degright && degrees < 0)
    {
        //play sound : rotate right
    }
    */
}


-(void)timerfired
{
    timer = timer + 1; //this counts by 2s?
    [self.timerlabel2 setText:[NSString stringWithFormat:@"%d sec",timer/2]]; //if I div by 2 it works properly
     [self PlayGoodSound]; //just a test
    
    
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

/*
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
*/


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
} //this should make the keyboard disappear, currently crashes
 
- (IBAction)timerSlider:(id)sender {
    UISlider *timerSlider = (UISlider *)sender;
    timerSliderLabel.text = [NSString stringWithFormat:@"%.f Min", timerSlider.value];
}

- (IBAction)repSlider:(id)sender {
    UISlider *repSlider = (UISlider *)sender;
    repSliderLabel.text = [NSString stringWithFormat:@"%.f Times", repSlider.value];
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
    NSString *sessionname = self.SessionNameField.text;
    
    //send values and name to database
}
@end
