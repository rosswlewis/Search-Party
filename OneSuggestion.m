//
//  OneSuggestion.m
//  Real Search Party Testing
//
//  Created by Ross Lewis on 3/12/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "OneSuggestion.h"

@implementation OneSuggestion

-(void) SetQueries:(NSNumber *)numberOfQueries
{
    theQueries = numberOfQueries;
}

-(void) SetSuggestion:(NSString *)suggestionText
{
    theSuggestion = suggestionText;
}

-(void) SetBest:(BOOL)best
{
    theBest = best;
}

-(NSString*)GetTheSuggestion
{
    return theSuggestion;
}

-(NSNumber*)GetTheQueries
{
    return theQueries;
}

-(BOOL)GetTheBest
{
    return theBest;
}

@end
