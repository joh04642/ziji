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

    
}

-(void)timerfired
{
    timer = timer + 1; //this counts by 2s?
    [self.timerlabel2 setText:[NSString stringWithFormat:@"%d sec",timer/2]]; //if I div by 2 it works properly
}



- (void)viewDidUnload
{
    [self setTimerlabel:nil];
    [self setTimerlabel2:nil];
    [self setEstimatedtimelabel:nil];
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

@end
