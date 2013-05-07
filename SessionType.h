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
    
	__unsafe_unretained NSString *session_length_min;
    __unsafe_unretained NSString *num_of_reps;
    __unsafe_unretained NSString *degrees_L;
    __unsafe_unretained NSString *degrees_R;
    __unsafe_unretained NSString *date_created;
    __unsafe_unretained NSString *session_name;
	
	//Intrnal variables to keep track of the state of the object.
	BOOL isDirty;
	BOOL isDetailViewHydrated;
}

@property (assign, nonatomic, readwrite) NSString *session_length_min;
@property (assign, nonatomic, readwrite) NSString *num_of_reps;
@property (assign, nonatomic, readwrite) NSString *degrees_L;
@property (assign, nonatomic, readwrite) NSString *degrees_R;
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
