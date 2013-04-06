//
//  GoogleXMLParser.h
//  Real Search Party Testing
//
//  Created by Ross Lewis on 3/12/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneSuggestion.h"

@interface GoogleXMLParser : NSObject
{
    NSMutableString * currentElementValue;
    OneSuggestion * oneSuggestion;
    NSMutableArray * manySuggestions;
}

-(GoogleXMLParser *) initXMLParser;
-(NSMutableArray *) GetManySuggestions;

@end
