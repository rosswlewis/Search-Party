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
