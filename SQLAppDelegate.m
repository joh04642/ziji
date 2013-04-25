//
//  SQLAppDelegate.m
//  SQL
//
//  Created by iPhone SDK Articles on 10/26/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import "SQLAppDelegate.h"
#import "RootViewController.h"
#import "Session.h"
#import "SessionType.h"

@implementation SQLAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize SessionArray;
@synthesize SessionTypeArray;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	//Copy database to the user's phone if needed.
	[self copyDatabaseIfNeeded];
	
	//Initialize the session array.
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.SessionArray = tempArray;
	
	//Once the db is copied, get the initial data to display on the screen.
	[Session getInitialDataToDisplay:[self getDBPath]];
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
	
	[Session finalizeStatements];
}


- (void)dealloc {
}

- (void) copyDatabaseIfNeeded {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SQL.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success) 
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}	
}

- (void) addSessionType:(SessionType *)sessionTypeObj {
    //Add it to the database.
    [sessionTypeObj addSessionType];
    
    //Add it to the coffee array.
    [SessionTypeArray addObject:sessionTypeObj];
}

- (void) addSession:(Session *)sessionObj {
    //Add it to the database.
    [sessionObj addSession];
    
    //Add it to the coffee array.
    [SessionArray addObject:sessionObj];
}

- (NSString *) getDBPath {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"SQL.sqlite"];
}

@end
