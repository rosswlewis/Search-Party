//
//  PartyModeViewController.h
//  Real Search Party Testing
//
//  Created by Ross Lewis on 3/21/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleSuggestions.h"
#import "Reachability.h"
#import "DejalActivityView.h"

@interface PartyModeViewController : UIViewController <UIAlertViewDelegate> 
{
    UIButton * correctButton;
    SoundEffects * soundEffects;
    NSMutableArray * queryArray;
    NSMutableArray * successArray;
    NSMutableArray * failureArray;
    BOOL redTeam;
    GoogleSuggestions *suggestions;
    float blueTeamCorrectAnswers;
    float redTeamCorrectAnswers;
    Reachability * testConnection;
    UIImageView * teamColorImageView;
}

@property (weak, nonatomic) IBOutlet UILabel *partyModeText;
@property (weak, nonatomic) IBOutlet UIImageView *partyModePicture;
@property (weak, nonatomic) IBOutlet UILabel *theSearchLabel;
@property (weak, nonatomic) IBOutlet UILabel *theResultLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonThree;
@property (weak, nonatomic) IBOutlet UIProgressView *redTeamProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *blueTeamProgress;


- (IBAction)buttonSuccessClick:(id)sender;
- (IBAction)buttonFailClick:(id)sender;

@end
