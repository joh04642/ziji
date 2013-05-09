//
//  SessionTypeList.h
//  initialziji
//
//  Created by macbook on 5/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface SessionTypeList : NSObject {
    NSString *sessionString;
    NSInteger SessionTypeListID;
    
    BOOL isDirty;
    BOOL isDetailViewHydrated;
}

@property (nonatomic, readonly) NSInteger SessionTypeListID;
@property (nonatomic, copy) NSString *sessionString;

@property (nonatomic, readwrite) BOOL isDirty;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;

//static
+ (void) getInitialDataToDisplay: (NSString *)dbPath;
+ (void) finalizeStatements;

//instance

- (id) initWithPrimaryKey:(NSInteger)pk;
- (void) deleteSessionTypeList;
- (void) addSessionTypeList;
- (void) hydrateDetailViewData;
- (void) saveAllData;

@end
