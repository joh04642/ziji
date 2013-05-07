//
//  ModelController.h
//  initialziji
//
//  Created by macbook on 3/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class DataViewController;
@class CMMotionManagerViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>
//- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
//- (NSUInteger)indexOfViewController:(DataViewController *)viewController;
- (CMMotionManagerViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(CMMotionManagerViewController *)viewController;
@end
