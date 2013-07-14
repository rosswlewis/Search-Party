//
//  SuggestRate.m
//  Search Party
//
//  Created by Ross Lewis on 7/10/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "SuggestRate.h"

@implementation SuggestRate

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)ShowAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Like Search Party?" message:@"Rate it!  If there's something you don't like, go ahead and contact me and I'll work on improvements ^_^  (www.rosswlewis.com)" delegate:self cancelButtonTitle:@"Keep Playing" otherButtonTitles:@"Rate it now!", @"Stop asking >_<",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //just continue!
        return;
    }else if (buttonIndex == 1) {
        setting = [NSUserDefaults standardUserDefaults];
        
        [setting setBool:true forKey:HAS_RATED_S];
        
        //link the user to the app store
        NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa";
        str = [NSString stringWithFormat:@"%@/wa/viewContentsUserReviews?", str];
        str = [NSString stringWithFormat:@"%@type=Purple+Software&id=", str];
        
        // Here is the app id from itunesconnect
        str = [NSString stringWithFormat:@"%@648136813", str];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else if(buttonIndex == 2){
        setting = [NSUserDefaults standardUserDefaults];
        
        [setting setBool:true forKey:HAS_RATED_S];
    }
}

@end
