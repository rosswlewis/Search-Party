//
//  SoloModeViewController.h
//  Search Party
//
//  Created by Ross Lewis on 3/25/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleSuggestions.h"

@interface SoloModeViewController : UIViewController
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
}

@property (weak, nonatomic) IBOutlet UIView *topSearchView;
@property (strong, nonatomic) IBOutlet UIView *topSearchBottomBorder;
@property (weak, nonatomic) IBOutlet UILabel *theSearchLabel;
@property (weak, nonatomic) IBOutlet UILabel *theResultLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonThree;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property (weak, nonatomic) IBOutlet UILabel *currentStreakLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestStreakLabel;

- (IBAction)buttonSuccessClick:(id)sender;
- (IBAction)buttonFailClick:(id)sender;
- (IBAction)buttonNextClick:(id)sender;

@end
