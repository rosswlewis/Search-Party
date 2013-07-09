//
//  GoogleSuggestions.m
//  Real Search Party Testing
//
//  Created by Ross Lewis on 3/12/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "GoogleSuggestions.h"
#import "GoogleXMLParser.h"

@implementation GoogleSuggestions

/*
 * FOR THE XML RETREIVED AT
 * "http://google.com/complete/search?output=toolbar&q=" + QUERY
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * 1. Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following disclaimer
 * in the documentation and/or other materials provided with the
 * distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY GOOGLE INC. AND ITS CONTRIBUTORS
 * â€œAS ISâ€ AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL GOOGLE INC.
 * OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

-(void) InitializeWithTheSearch:(NSString *)searchText
{
    theSearch = [searchText stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //1
    //get the text/xml from the url
    //http://google.com/complete/search?output=toolbar&q=xxxxx
    NSXMLParser * googleSuggestionsAsXML = self.GetTheXMLFromGoogle;
    
    //2
    //get an array of all suggestions
    arrayOfSuggestions = [[self ParseTheXMLIntoAnArrayOfSuggestions:googleSuggestionsAsXML] mutableCopy];
    
    //3
    //sort (will have top 3)
    //remove if its the same as the query
    NSSortDescriptor * queriesDescriptor = [[NSSortDescriptor alloc] initWithKey:@"theQueries" ascending:NO];
    NSArray * sortDescriptor = @[queriesDescriptor];
    arrayOfSuggestions = [[arrayOfSuggestions sortedArrayUsingDescriptors:sortDescriptor] mutableCopy];
    NSMutableArray * discardedItems = [[NSMutableArray alloc] init];
    for(OneSuggestion * oneSug in arrayOfSuggestions){
        if([[[oneSug GetTheSuggestion] lowercaseString] isEqual:[searchText lowercaseString]])
            [discardedItems addObject:oneSug];
    }
    [arrayOfSuggestions removeObjectsInArray:discardedItems];
    
    if([arrayOfSuggestions count] < 3){
        [arrayOfSuggestions removeAllObjects];
    }else{
        [[arrayOfSuggestions objectAtIndex:0] SetBest:YES];
    }
}

//1
//Get the text/xml from the Google API
//http://google.com/complete/search?output=toolbar&q=xxxxx
-(NSXMLParser *)GetTheXMLFromGoogle
{
    NSXMLParser * urlContent = [NSXMLParser alloc];
    NSURL * googleURL = [NSURL alloc];
    NSString *urlString = [NSString stringWithFormat:GOOGLE_URL];
    
    urlString = [urlString stringByReplacingOccurrencesOfString:REPLACE_STRING withString:theSearch];
    googleURL = [googleURL initWithString:urlString];
    
    urlContent = [urlContent initWithContentsOfURL:googleURL];
    return urlContent;
}

//2
//return an array of all suggestions
-(NSMutableArray *)ParseTheXMLIntoAnArrayOfSuggestions: (NSXMLParser *) googleXML
{
    NSMutableArray * suggestionsArray = [[NSMutableArray alloc] init];
    GoogleXMLParser *parser = [[GoogleXMLParser alloc] initXMLParser];
    [googleXML setDelegate:parser];
    
    [googleXML setShouldProcessNamespaces:NO];
    [googleXML setShouldReportNamespacePrefixes:NO];
    [googleXML setShouldResolveExternalEntities:NO];
    BOOL success = [googleXML parse];
    
    if(success){
        return [parser GetManySuggestions];
    }else{
        //error
    }
    
    return suggestionsArray;
}

-(NSMutableArray *) GetTheArrayOfSuggestions
{
    return arrayOfSuggestions;
}

@end
