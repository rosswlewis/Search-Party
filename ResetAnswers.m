//
//  ResetAnswers.m
//  Search Party
//
//  Created by Ross Lewis on 7/10/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "ResetAnswers.h"
#import "ViewController.h"

@implementation ResetAnswers

static ViewController * curViewController;

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


-(void)ShowAlert:(ViewController *) currentViewController
{
    curViewController = currentViewController;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset Answers?" message:@"Are you sure you want to reset your answers?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        return;
    }
    else if (buttonIndex == 1) {
        //load total answered        
        NSUserDefaults * settings = [[NSUserDefaults alloc]init];
        [settings setObject: [NSNumber numberWithInt:0] forKey:INCORRECT_ANS_S];
        [settings setObject: [NSNumber numberWithInt:0] forKey:CORRECT_ANS_S];
        
        [curViewController ResetTextValues];
    }
}

@end
