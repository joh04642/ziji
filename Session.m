//
//  Sessions.m
//  initialziji
//
//  Created by macbook on 4/22/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//
#import "SQLAppDelegate.h"
#import "Session.h"

static sqlite3 *database = nil;

@implementation Session

@synthesize session_ID, completed, max_degrees_left, max_degrees_right, reps_completed, isDirty, isDetailViewHydrated, session_name, date_attempted;

+ (void) getInitialDataToDisplay:(NSString *)dbPath {
	
	SQLAppDelegate *appDelegate = (SQLAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select session_ID, from Session";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				Session *SessionObj = [[Session alloc] initWithPrimaryKey:primaryKey];
				SessionObj.session_ID = (int)[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				
				SessionObj.isDirty = NO;
				
				[appDelegate.SessionArray addObject:SessionObj];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
}

- (id) initWithPrimaryKey:(NSInteger) pk {
	/*
    self.init;
	[super init];
	*/
    session_ID = pk;
	
	isDetailViewHydrated = NO;
	
	return self;
}

- (void) dealloc {
    //[*session_name release];
    //[session_ID release];
    //[*date_attempted release];
    //[completed release];
    //[max_degrees_left release];
    //[max_degrees_right release];
    //[reps_completed release];
	//[super dealloc];
}

@end
