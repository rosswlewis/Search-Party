//
//  OpenSearchInGoogle.m
//  Search Party
//
//  Created by Ross Lewis on 8/6/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "OpenSearchInGoogle.h"

@implementation OpenSearchInGoogle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)ShowAlertWithQuery:(NSString *)query
{
    theSearch = query;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Google this?" message:@"Do you want to search this suggestion online?" delegate:self cancelButtonTitle:@"Keep Playing" otherButtonTitles:@"Search!",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //just continue!
        return;
    }else if (buttonIndex == 1) {
        //link the user to google
        NSString *str = @"http://www.google.com/search?q=";
        str = [NSString stringWithFormat:@"%@%@", str, theSearch];
        
        str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
