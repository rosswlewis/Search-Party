//
//  QueryDatabase.h
//  Real Search Party Testing
//
//  Created by Ross Lewis on 3/19/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface QueryDatabase : NSObject{
    sqlite3 *_database;
    NSUserDefaults * settings;}

+ (QueryDatabase*)database;
- (NSMutableArray *)queries;

@end
