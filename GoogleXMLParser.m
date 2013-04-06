//
//  GoogleXMLParser.m
//  Real Search Party Testing
//
//  Created by Ross Lewis on 3/12/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "GoogleXMLParser.h"

@implementation GoogleXMLParser

-(GoogleXMLParser *) initXMLParser{
    manySuggestions = [[NSMutableArray alloc] init];
    
    return self;
}

-(void)parser:(NSXMLParser *) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:COMPLETE_SUGGESTION]){
        oneSuggestion = [[OneSuggestion alloc] init];
    }else if([elementName isEqualToString:SUGGEST_STRING]){
        [oneSuggestion SetSuggestion:[attributeDict objectForKey:SUGGEST_DATA]];
    }else if([elementName isEqualToString:QUERIES_STRING]){
        NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [oneSuggestion SetQueries:[numberFormatter numberFromString:[attributeDict objectForKey:QUERIES_INT]]];
    }
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
{
    if(!currentElementValue){
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }else{
        [currentElementValue appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:TOP_LEVEL]){
        return;
    }
    
    if([elementName isEqualToString:COMPLETE_SUGGESTION]){
        [manySuggestions addObject:oneSuggestion];
    }
}

-(NSMutableArray *) GetManySuggestions
{
    return manySuggestions;
}

@end
