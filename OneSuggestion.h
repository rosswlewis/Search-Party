//
//  OneSuggestion.h
//  Real Search Party Testing
//
//  Created by Ross Lewis on 3/12/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneSuggestion : NSObject
{
    NSString *theSuggestion;
    NSNumber *theQueries;
    BOOL theBest;
}

-(void) SetSuggestion: (NSString*) suggestionText;
-(void) SetQueries: (NSNumber*) numberOfQueries;
-(void) SetBest: (BOOL) best;

- (NSString*) GetTheSuggestion;
- (NSNumber*) GetTheQueries;
- (BOOL) GetTheBest;

@end
