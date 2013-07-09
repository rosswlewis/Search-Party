//
//  QueryDatabase.m
//  Real Search Party Testing
//
//  Created by Ross Lewis on 3/19/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "QueryDatabase.h"

@implementation QueryDatabase

static QueryDatabase *_database;

+ (QueryDatabase*)database {
    if (_database == nil) {
        _database = [[QueryDatabase alloc] init];
    }
    return _database;
}

- (void)dealloc {
    sqlite3_close(_database);
    //[super dealloc];
}

- (id)init {
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"firstQueries" ofType:@"sqlite3"];
        
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

- (NSMutableArray *)queries {
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    //NSString *query = @"SELECT * FROM sqlite_master";
    
    NSString *query = @"SELECT query FROM queries where pack in (";
    settings = [NSUserDefaults standardUserDefaults];
    int packCount = 0;
    
    if([settings objectForKey:DEFAULT_PACK_S] == nil){
        query = [query stringByAppendingFormat:@"'%@',",DEFAULT_PACK_DBNAME];
    }else{
        if([settings boolForKey:DEFAULT_PACK_S])
        {
            query = [query stringByAppendingFormat:@"'%@',",DEFAULT_PACK_DBNAME];
            packCount++;
        }
    }
    
    if([settings objectForKey:POP_PACK_S] != nil){
        if([settings boolForKey:POP_PACK_S])
        {
            query = [query stringByAppendingFormat:@"'%@',",POP_PACK_DBNAME];
            packCount++;
        }
    }
    
    if([settings objectForKey:CELEB_PACK_S] != nil){
        if([settings boolForKey:CELEB_PACK_S])
        {
            query = [query stringByAppendingFormat:@"'%@',",CELEB_PACK_DBNAME];
            packCount++;
        }
    }
    
    if(packCount == 0)
        query = [query stringByAppendingFormat:@"'%@',",DEFAULT_PACK_DBNAME];
    
    query = [query stringByAppendingString:@"'')"];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)
        == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *queryChars = (char *) sqlite3_column_text(statement, 0);
            NSString *singleQuery = [[NSString alloc] initWithUTF8String:queryChars];
            [retval addObject:singleQuery];
        }
        sqlite3_finalize(statement);
    }else{
        //sqlite_errmsg(_database);
        NSAssert1(0, @"Error: prepare failed with message '%s'.", sqlite3_errmsg(_database));
    }
    return retval;
}

@end
