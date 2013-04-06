//
//  PartyModeViewController.m
//  Real Search Party Testing
//
//  Created by Ross Lewis on 3/21/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "PartyModeViewController.h"
#import "QueryDatabase.h"

@interface PartyModeViewController ()

@end

@implementation PartyModeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // get all of the queries from the sqlite3 file and use one of them
    queryArray = [[NSMutableArray alloc] init];
    queryArray = [QueryDatabase database].queries;
    redTeam = YES;
    soundEffects = [[SoundEffects alloc] init];
    [self.redTeamProgress setProgress:0];
    [self.blueTeamProgress setProgress:0];
    blueTeamCorrectAnswers = 0;
    redTeamCorrectAnswers = 0;
    [self.theResultLabel setText:RED_TEAM];
    
    successArray = [[NSMutableArray alloc]init];
    failureArray = [[NSMutableArray alloc]init];
    [successArray addObject:SOLO_CORRECT1];
    [successArray addObject:SOLO_CORRECT2];
    [successArray addObject:SOLO_CORRECT3];
    [successArray addObject:SOLO_CORRECT4];
    [failureArray addObject:SOLO_WRONG1];
    [failureArray addObject:SOLO_WRONG2];
    
    [[self.buttonOne layer] setBorderWidth:1.0f];
    [[self.buttonOne layer] setBorderColor:[UIColor blackColor].CGColor];
    [[self.buttonTwo layer] setBorderWidth:1.0f];
    [[self.buttonTwo layer] setBorderColor:[UIColor blackColor].CGColor];
    [[self.buttonThree layer] setBorderWidth:1.0f];
    [[self.buttonThree layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [self StartANewSearch];
}

-(void)StartANewSearch
{
    if(redTeam){
        [self.theResultLabel setText:RED_TEAM];
    }else{
        [self.theResultLabel setText:BLUE_TEAM];
    }
    if(!([queryArray count] < 1)){
        // set the buttons and such
        int random = arc4random() % [queryArray count];
        NSString * theQuery = [queryArray objectAtIndex:random];
        [self SetButtonTextAndClick:theQuery];
        [queryArray removeObjectAtIndex:random];
    }else{
        queryArray = [[NSMutableArray alloc] init];
        queryArray = [QueryDatabase database].queries;
        
        [self StartANewSearch];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonSuccessClick:(id)sender {
    [soundEffects PlaySoundGameButtonSuccess];
    [sender setBackgroundColor:[UIColor greenColor]];
    
    
    if(redTeam){
        redTeamCorrectAnswers += .2;
        if(redTeamCorrectAnswers > .9){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:WINNER
                                                            message:RED_TEAM_WINS
                                                           delegate:nil
                                                  cancelButtonTitle:NEW_GAME
                                                  otherButtonTitles:nil];
            [alert show];
            [self viewDidLoad];
            return;
        }
        [self.theResultLabel setText:[NSString stringWithFormat:@"%@  %@",[successArray objectAtIndex:arc4random() % [successArray count]], RED_TEAM_UP]];
        [self.redTeamProgress setProgress:redTeamCorrectAnswers animated:YES];
    }else{
        blueTeamCorrectAnswers += .2;
        if(blueTeamCorrectAnswers > .9){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:WINNER
                                                            message:BLUE_TEAM_WINS
                                                           delegate:nil
                                                  cancelButtonTitle:NEW_GAME
                                                  otherButtonTitles:nil];
            [alert show];
            [self viewDidLoad];
            return;
        }
        [self.theResultLabel setText:[NSString stringWithFormat:@"%@  %@",[successArray objectAtIndex:arc4random() % [successArray count]], RED_TEAM_UP]];
        [self.blueTeamProgress setProgress:blueTeamCorrectAnswers animated:YES];
    }
    
    [self ClearButtonsEvents];
    redTeam = !redTeam;
    
    [self performSelector:@selector(StartANewSearch) withObject:nil afterDelay:TIME_BETWEEN];
}

- (void)buttonFailClick:(id)sender{
    [soundEffects PlaySoundGameButtonFailure];
    [sender setBackgroundColor:[UIColor redColor]];
    [correctButton setBackgroundColor:[UIColor greenColor]];
    
    if(redTeam){
        [self.theResultLabel setText:[NSString stringWithFormat:@"%@  %@",[failureArray objectAtIndex:arc4random() % [failureArray count]], BLUE_TEAM_UP]];
    }else{
        [self.theResultLabel setText:[NSString stringWithFormat:@"%@  %@",[failureArray objectAtIndex:arc4random() % [failureArray count]], RED_TEAM_UP]];
    }
    redTeam = !redTeam;
    [self ClearButtonsEvents];
    
    [self performSelector:@selector(StartANewSearch) withObject:nil afterDelay:TIME_BETWEEN];
}

-(void)SetButtonTextAndClick:(NSString *) theQuery{
    [self.theSearchLabel setText:theQuery];
    
    suggestions = [GoogleSuggestions alloc];
    [suggestions InitializeWithTheSearch:theQuery];
    
    if([[suggestions GetTheArrayOfSuggestions] count] < 3){
        [self StartANewSearch];
        return;
    }
    
    [self ClearButtonsColors];
    
    int random = arc4random() % 3;
    OneSuggestion * buttonText = [[OneSuggestion alloc] init];
    NSMutableArray * arrayOfSuggestions = [[NSMutableArray alloc] init];
    arrayOfSuggestions = [suggestions GetTheArrayOfSuggestions];
    
    //button one
    buttonText = [arrayOfSuggestions objectAtIndex:random];
    [self.buttonOne setTitle:[buttonText GetTheSuggestion] forState:UIControlStateNormal];
    if([buttonText GetTheBest]){
        correctButton = self.buttonOne;
        [self.buttonOne addTarget:self action:@selector(buttonSuccessClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self.buttonOne addTarget:self action:@selector(buttonFailClick:) forControlEvents:UIControlEventTouchUpInside ];
    }
    [arrayOfSuggestions removeObjectAtIndex:random];
    
    //button two
    random = arc4random() % 2;
    buttonText = [arrayOfSuggestions objectAtIndex:random];
    [self.buttonTwo setTitle:[buttonText GetTheSuggestion] forState:UIControlStateNormal];
    if([buttonText GetTheBest]){
        correctButton = self.buttonTwo;
        [self.buttonTwo addTarget:self action:@selector(buttonSuccessClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self.buttonTwo addTarget:self action:@selector(buttonFailClick:) forControlEvents:UIControlEventTouchUpInside ];
    }
    [arrayOfSuggestions removeObjectAtIndex:random];
    
    //button three
    buttonText = [arrayOfSuggestions objectAtIndex:0];
    [self.buttonThree setTitle:[buttonText GetTheSuggestion] forState:UIControlStateNormal];
    if([buttonText GetTheBest]){
        correctButton = self.buttonThree;
        [self.buttonThree addTarget:self action:@selector(buttonSuccessClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self.buttonThree addTarget:self action:@selector(buttonFailClick:) forControlEvents:UIControlEventTouchUpInside ];
    }
}

-(void)ClearButtonsColors
{
    [self.buttonOne setBackgroundColor:[UIColor whiteColor]];
    [self.buttonTwo setBackgroundColor:[UIColor whiteColor]];
    [self.buttonThree setBackgroundColor:[UIColor whiteColor]];
}

-(void)ClearButtonsEvents
{
    [self.buttonOne removeTarget:self action:@selector(buttonSuccessClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonOne removeTarget:self action:@selector(buttonFailClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonTwo removeTarget:self action:@selector(buttonSuccessClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonTwo removeTarget:self action:@selector(buttonFailClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonThree removeTarget:self action:@selector(buttonSuccessClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonThree removeTarget:self action:@selector(buttonFailClick:) forControlEvents:UIControlEventTouchUpInside];
}

@end