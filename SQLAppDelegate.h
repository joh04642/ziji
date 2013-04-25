//
//  SQLAppDelegate.h
//  SQL
//
//  Created by iPhone SDK Articles on 10/26/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import <UIKit/UIKit.h>

@class Session;
@class SessionType;
@interface SQLAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	
	//To hold a list of Session objects
	NSMutableArray *SessionArray;
    
    NSMutableArray *SessionTypeArray;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) NSMutableArray *SessionArray;
@property (nonatomic, retain) NSMutableArray *SessionTypeArray;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;
- (void) addSession:(Session *)sessionObj;
- (void) addSessionType: (SessionType *)sessionTypeObj;
@end

