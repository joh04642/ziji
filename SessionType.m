//
//  SessionType.m
//  SQL
//
//  Created by iPhone SDK Articles on 10/26/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import "SessionType.h"
#import "SQLAppDelegate.h"

static sqlite3 *database = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;

@implementation SessionType

@synthesize session_length_min, num_of_reps, degrees_L, degrees_R, isDirty, isDetailViewHydrated, date_created, session_name;

+ (void) getInitialDataToDisplay:(NSString *)dbPath {
	
	SQLAppDelegate *appDelegate = (SQLAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select session_name, from SessionType";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				SessionType *SessionTypeObj = [[SessionType alloc] initWithPrimaryKey:primaryKey];
				SessionTypeObj.session_name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				
				SessionTypeObj.isDirty = NO;
				
				[appDelegate.SessionTypeArray addObject:SessionTypeObj];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

+ (void) finalizeStatements {
	if(database) sqlite3_close(database);
    if(deleteStmt) sqlite3_finalize(deleteStmt);
    if(addStmt) sqlite3_finalize(addStmt);
}

- (void) addSessionType {
    if(addStmt == nil) {
        const char *sql = "insert into SessionType(session_name, date_created, session_length_min, num_of_reps, degrees_L, degrees_R) Values(?, ?, ?, ?, ?, ?)";
        if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    }
    
    sqlite3_bind_text(addStmt, 1, [session_name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt, 2, [date_created UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(addStmt, 3, session_length_min);
    
    sqlite3_bind_int(addStmt, 4, num_of_reps);

    sqlite3_bind_int(addStmt, 5, degrees_L);
    
    sqlite3_bind_int(addStmt, 6, degrees_R);
    
    if(SQLITE_DONE != sqlite3_step(addStmt))
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        //SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
        //session_name = sqlite3_last_insert_rowid(database);
    
    //Reset the add statement.
    sqlite3_reset(addStmt);
}
- (id) initWithPrimaryKey:(NSInteger) pk {
	
    session_name = [NSString stringWithFormat:@"%d",pk];
    
	isDetailViewHydrated = NO;
	
	return self;
}

- (void) dealloc {
}

@end
