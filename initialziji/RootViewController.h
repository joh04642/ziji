//
//  RootViewController.h
//  initialziji
//
//  Created by macbook on 3/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLAppDelegate.h"

@interface RootViewController : UIViewController <UIPageViewControllerDelegate> {
    SQLAppDelegate *appDelegate;
}

@property (weak, nonatomic) IBOutlet UITextField *timerlabel;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end


@class Session;

@class SessionType;
