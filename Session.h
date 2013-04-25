//
//  Session.h
//  SQL
//
//  Created by iPhone SDK Articles on 10/26/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Session : NSObject {
    
    __unsafe_unretained NSString *session_name;
	__unsafe_unretained NSString *date_attempted;
    BOOL completed;
    NSInteger max_degrees_left;
    NSInteger max_degrees_right;
    NSInteger reps_completed;
    NSInteger session_ID;
	//Intrnal variables to keep track of the state of the object.
	BOOL isDirty;
	BOOL isDetailViewHydrated;
    
}

@property (nonatomic, readwrite) NSInteger reps_completed;
@property (nonatomic, readwrite) NSInteger max_degrees_right;
@property (nonatomic, readwrite) NSInteger max_degrees_left;
@property (nonatomic, readwrite) NSInteger session_ID;

@property (nonatomic, readwrite) BOOL completed;
@property (nonatomic, readwrite) NSString *date_attempted;
@property (nonatomic, readwrite) NSString *session_name;

@property (nonatomic, readwrite) BOOL isDirty;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;

//Static methods.
+ (void) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

- (void) addSession;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;

@end
