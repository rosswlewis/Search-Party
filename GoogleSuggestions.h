//
//  GoogleSuggestions.h
//  Real Search Party Testing
//
//  Created by Ross Lewis on 3/12/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneSuggestion.h"

@interface GoogleSuggestions : NSObject
{
    NSString *theSearch;
    NSMutableArray * arrayOfSuggestions;
}

- (void) InitializeWithTheSearch: (NSString*) searchText;
-(NSMutableArray *) GetTheArrayOfSuggestions;

@end
