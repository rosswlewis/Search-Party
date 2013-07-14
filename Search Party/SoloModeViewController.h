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
#import "SuggestRate.h"
#import <FacebookSDK/FacebookSDK.h>
#import <QuartzCore/QuartzCore.h>
#import "NSData+Base64.h"
#import "Unirest.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

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
    //int queryQueued;
    Reachability * testConnection;
    
    NSNumber * incorrectAns;
    NSNumber * correctAns;
    
    SuggestRate * suggestRate;
    
    ACAccountStore * accountStore;
    UIImageView * changingBackground;
}

@property (weak, nonatomic) IBOutlet UILabel *StaticPercentCorrect;
@property (weak, nonatomic) IBOutlet UILabel *StaticTopText;
@property (weak, nonatomic) IBOutlet UILabel *StaticCurrentStreak;
@property (weak, nonatomic) IBOutlet UILabel *StaticBestStreak;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UILabel *PercentCorrectLabel;
@property (weak, nonatomic) IBOutlet UIImageView *soloModePicture;
@property (weak, nonatomic) IBOutlet UILabel *soloModeText;
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

- (IBAction)TwitterClick:(id)sender;
- (IBAction)FacebookClick:(id)sender;
- (IBAction)buttonSuccessClick:(id)sender;
- (IBAction)buttonFailClick:(id)sender;
- (IBAction)buttonNextClick:(id)sender;

@end
