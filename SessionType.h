//
//  SessionType.h
//  SQL
//
//  Created by iPhone SDK Articles on 10/26/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface SessionType : NSObject {
    
	NSInteger session_length_min;
    NSInteger num_of_reps;
    NSInteger degrees_L;
    NSInteger degrees_R;
    __unsafe_unretained NSString *date_created;
    __unsafe_unretained NSString *session_name;
	
	//Intrnal variables to keep track of the state of the object.
	BOOL isDirty;
	BOOL isDetailViewHydrated;
}

@property (nonatomic, readwrite) NSInteger session_length_min;
@property (nonatomic, readwrite) NSInteger num_of_reps;
@property (nonatomic, readwrite) NSInteger degrees_L;
@property (nonatomic, readwrite) NSInteger degrees_R;
@property (assign, nonatomic, readwrite) NSString *date_created; //assign solves some warnings, but strong or weak is better
@property (assign, nonatomic, readwrite) NSString *session_name;

@property (nonatomic, readwrite) BOOL isDirty;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;

//Static methods.
+ (void) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

- (void) addSessionType;
//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;

@end
