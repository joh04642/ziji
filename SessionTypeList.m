//
//  SessionTypeList.m
//  initialziji
//
//  Created by macbook on 5/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SessionTypeList.h"
#import "SQLAppDelegate.h"

static sqlite3 *database = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;
static sqlite3_stmt *detailStmt = nil;
static sqlite3_stmt *updateStmt = nil;

@implementation SessionTypeList

@synthesize sessionString, SessionTypeListID, isDirty, isDetailViewHydrated;

+ (void) getInitialDataToDisplay:(NSString *)dbPath {
	
	SQLAppDelegate *appDelegate = (SQLAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select sessionString, SessionTypeListID from SessionTypeList";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				SessionTypeList *sessionTypeListObj = [[SessionTypeList alloc] initWithPrimaryKey:primaryKey];
				sessionTypeListObj.sessionString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				
				sessionTypeListObj.isDirty = NO;
				
				//[appDelegate.SessionTypeListArray addObject:sessionTypeListObj];
				//[sessionTypeListObj release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

+ (void) finalizeStatements {
	
	if (database) sqlite3_close(database);
	if (deleteStmt) sqlite3_finalize(deleteStmt);
	if (addStmt) sqlite3_finalize(addStmt);
	if (detailStmt) sqlite3_finalize(detailStmt);
	if (updateStmt) sqlite3_finalize(updateStmt);
}

- (id) initWithPrimaryKey:(NSInteger) pk {
	
	//[super init];
	SessionTypeListID = pk;
	
	isDetailViewHydrated = NO;
	
	return self;
}

- (void) deleteSessionTypeList {
	
	if(deleteStmt == nil) {
		const char *sql = "delete from SessionTypeList where SessionTypeListID = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	}
	
	//When binding parameters, index starts from 1 and not zero.
	sqlite3_bind_int(deleteStmt, 1, SessionTypeListID);
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt)) 
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	
	sqlite3_reset(deleteStmt);
}

- (void) addSessionTypeList {
	
	if(addStmt == nil) {
		const char *sql = "insert into SessionTypeList(SessionString) Values(?)";
		if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	
	sqlite3_bind_text(addStmt, 1, [sessionString UTF8String], -1, SQLITE_TRANSIENT);
	
	if(SQLITE_DONE != sqlite3_step(addStmt))
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	else
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		SessionTypeListID = sqlite3_last_insert_rowid(database);
	
	//Reset the add statement.
	sqlite3_reset(addStmt);
}

- (void) hydrateDetailViewData {
	
	//If the detail view is hydrated then do not get it from the database.
	if(isDetailViewHydrated) return;
	
	//Reset the detail statement.
	sqlite3_reset(detailStmt);
	
	//Set isDetailViewHydrated as YES, so we do not get it again from the database.
	isDetailViewHydrated = YES;
}

- (void) saveAllData {
	
	if(isDirty) {
		
		if(updateStmt == nil) {
			const char *sql = "update SessionTypeList Set sessionString = ? Where SessionTypeListID = ?";
			if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK) 
				NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_bind_text(updateStmt, 1, [sessionString UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_int(updateStmt, 2, SessionTypeListID);
		
		if(SQLITE_DONE != sqlite3_step(updateStmt))
			NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
		
		sqlite3_reset(updateStmt);
		
		isDirty = NO;
	}
	
	//Reclaim all memory here.
	//[sessionString release];
	sessionString = nil;
	
	isDetailViewHydrated = NO;
}

- (void) setSessionString:(NSString *)newValue {
	
	self.isDirty = YES;
	//[sessionString release];
	sessionString = [newValue copy];
}

- (void) dealloc {
	//[sessionString release];
	//[super dealloc];
}

@end
