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
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;

@implementation Session  //there is no method addsession in this file//

@synthesize session_ID, completed, max_degrees_left, max_degrees_right, reps_completed, isDirty, isDetailViewHydrated, date_attempted,session_name;

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


- (void) addSession
{
    if(addStmt == nil) {
        const char *sql = "insert into SessionType(session_ID, session_name, date_attempted, completed, max_degrees_left, max_degrees_right, reps_completed) Values(?, ?, ?, ?, ?, ?, ?)";
        if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    }
    
    sqlite3_bind_int(addStmt, 1, session_ID);
    sqlite3_bind_text(addStmt, 2, [session_name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt, 3, [date_attempted UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(addStmt, 4, completed);
    sqlite3_bind_int(addStmt, 5, max_degrees_left);
    sqlite3_bind_int(addStmt, 6, max_degrees_right);
    sqlite3_bind_int(addStmt, 7, reps_completed);
    
    if(SQLITE_DONE != sqlite3_step(addStmt))
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        //SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
        //session_name = sqlite3_last_insert_rowid(database);
        
        //Reset the add statement.
        sqlite3_reset(addStmt);
}


+ (void) finalizeStatements {
    if(database) sqlite3_close(database);
    if(deleteStmt) sqlite3_finalize(deleteStmt);
    if(addStmt) sqlite3_finalize(addStmt);
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
