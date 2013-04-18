//
//  DataViewController.h
//  initialziji
//
//  Created by macbook on 3/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

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
- (IBAction)SessionNameField:(id)sender;
- (IBAction)SaveButton:(id)sender;

@end
