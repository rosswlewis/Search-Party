//
//  SoloModeViewController.h
//  Search Party
//
//  Created by Ross Lewis on 3/25/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleSuggestions.h"
#import "Reachability.h"
#import "DejalActivityView.h"

@interface SoloModeViewController : UIViewController <UIAlertViewDelegate> 
{
    NSUserDefaults * streak;
    UIButton * correctButton;
    SoundEffects * soundEffects;
    NSMutableArray * queryArray;
    NSMutableArray * successArray;
    NSMutableArray * failureArray;
    GoogleSuggestions *suggestions;
    NSNumber * currentStreak;
    NSNumber * bestStreak;
    BOOL goNext;
    int queryQueued;
    Reachability * testConnection;
}

@property (weak, nonatomic) IBOutlet UIView *topSearchView;
@property (weak, nonatomic) IBOutlet UILabel *theSearchLabel;
@property (weak, nonatomic) IBOutlet UILabel *theResultLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonThree;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property (weak, nonatomic) IBOutlet UILabel *currentStreakLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestStreakLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonBack;

- (IBAction)buttonSuccessClick:(id)sender;
- (IBAction)buttonFailClick:(id)sender;
- (IBAction)buttonNextClick:(id)sender;

@end
