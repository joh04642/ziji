//
//  DataViewController.h
//  initialziji
//
//  Created by macbook on 3/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController
{

}

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
@property (weak, nonatomic) IBOutlet UITextField *timerlabel;
@property (weak, nonatomic) IBOutlet UILabel *timerlabel2;
@property (weak, nonatomic) IBOutlet UILabel *estimatedtimelabel;
@end
