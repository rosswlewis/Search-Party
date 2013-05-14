//
//  SoloModeViewController.m
//  Search Party
//
//  Created by Ross Lewis on 3/25/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "SoloModeViewController.h"
#import "QueryDatabase.h"

@interface SoloModeViewController ()

@end

@implementation SoloModeViewController

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
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    
    //[DejalBezelActivityView activityViewForView:self.view withLabel:@"Connecting..." width:100];

    //get the queries from the sqlite3 file
    queryArray = [[NSMutableArray alloc] init];
    queryArray = [QueryDatabase database].queries;
    
    //initialize the global variables and the controls
    [self.buttonNext setEnabled:YES];
    currentStreak = [[NSNumber alloc]init];
    bestStreak = [[NSNumber alloc]init];
    goNext = YES;
    queryQueued = 1;
    soundEffects = [[SoundEffects alloc] init];
    
    //load the highest streak
    currentStreak = [NSNumber numberWithInt:0];
    [self.currentStreakLabel setText:[currentStreak stringValue]];
    streak = [NSUserDefaults standardUserDefaults];
    if([streak objectForKey:BEST_STREAK_S] == nil){
        bestStreak = [NSNumber numberWithInt:0];
    }else{
        bestStreak = [streak objectForKey:BEST_STREAK_S];
    }
    [self.bestStreakLabel setText:[bestStreak stringValue]];
    
    [[self.buttonOne layer] setBorderWidth:1.0f];
    [[self.buttonOne layer] setBorderColor:[UIColor blackColor].CGColor];
    [[self.buttonTwo layer] setBorderWidth:1.0f];
    [[self.buttonTwo layer] setBorderColor:[UIColor blackColor].CGColor];
    [[self.buttonThree layer] setBorderWidth:1.0f];
    [[self.buttonThree layer] setBorderColor:[UIColor blackColor].CGColor];
    [[self.theSearchLabel layer] setBorderWidth:1.0f];
    [[self.theSearchLabel layer] setBorderColor:[UIColor blueColor].CGColor];
    [[self.topSearchView layer] setBorderWidth:1.0f];
    [[self.topSearchView layer] setBorderColor:[UIColor blackColor].CGColor];
    
    //[[self.buttonBack layer] setBorderWidth:1.0f];
    //[[self.buttonBack layer] setBorderColor:[UIColor blackColor].CGColor];
    //[[self.buttonNext layer] setBorderWidth:1.0f];
    //[[self.buttonNext layer] setBorderColor:[UIColor blackColor].CGColor];
    
    //get the correct / incorrect response strings
    successArray = [[NSMutableArray alloc]init];
    failureArray = [[NSMutableArray alloc]init];
    [successArray addObject:SOLO_CORRECT1];
    [successArray addObject:SOLO_CORRECT2];
    [successArray addObject:SOLO_CORRECT3];
    [successArray addObject:SOLO_CORRECT4];
    [failureArray addObject:SOLO_WRONG1];
    [failureArray addObject:SOLO_WRONG2];
    
    //[DejalBezelActivityView removeViewAnimated:YES];
    
    [self StartANewSearch:NO];
}

-(void)StartANewSearch:(BOOL) fromNext
{
    //if we are waiting for a queued new search, don't start a new one
    //this happens if the user pushes the next button too fast
    if(queryQueued > 1 && !fromNext){
        queryQueued--;
        return;
    }
    
    //remove a query from the queue count
    if(!fromNext)
        queryQueued--;
    if(goNext){
        [self.theResultLabel setText:@""];
        if(![queryArray count] < 1){
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading Suggestions" width:150];
            
            [self performSelector: @selector(SetupNewSearch) withObject:nil afterDelay:.1];
        }else{
            //if the array is empty initialize a new array
            queryArray = [[NSMutableArray alloc] init];
            queryArray = [QueryDatabase database].queries;
            
            [self StartANewSearch:NO];
        }
    }
}

-(void) SetupNewSearch
{
    testConnection = [Reachability reachabilityForInternetConnection];
    [testConnection startNotifier];
    
    NetworkStatus remoteHostStatus = [testConnection currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:CONNECT
                                                        message:CONNECT_MESSAGE
                                                       delegate:self
                                              cancelButtonTitle:ALL_PACKS_OFF_OK
                                              otherButtonTitles:nil];
        [alert show];
        [DejalBezelActivityView removeViewAnimated:YES];
        return;
    }else{
        //get a new query from the array
        //and set the buttons and such
        
        int random = arc4random() % [queryArray count];
        NSString * theQuery = [queryArray objectAtIndex:random];
        suggestions = [GoogleSuggestions alloc];
        [suggestions InitializeWithTheSearch:theQuery];
        [queryArray removeObjectAtIndex:random];
        if([[suggestions GetTheArrayOfSuggestions] count] < 3){
            [self StartANewSearch: false];
            
            [DejalBezelActivityView removeViewAnimated:YES];
            
            return;
        }
        [self SetButtonTextAndClick:theQuery];
        
        goNext = NO;
        [self.buttonNext setEnabled:NO];
        [self.buttonNext setBackgroundImage:[UIImage imageNamed:@"NextSearch_Off.png"] forState:UIControlStateNormal];
        
        [DejalBezelActivityView removeViewAnimated:YES];
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
    
    [self ClearButtonsEvents];
    [self.theResultLabel setText:[successArray objectAtIndex:arc4random() % [successArray count]]];
    goNext = YES;
    queryQueued++;
    currentStreak = [NSNumber numberWithInt:[currentStreak intValue] + 1];
    [self.currentStreakLabel setText:[currentStreak stringValue]];
    if([currentStreak intValue] > [bestStreak intValue]){
        bestStreak = currentStreak;
        streak = [NSUserDefaults standardUserDefaults];
        [streak setObject:bestStreak forKey:BEST_STREAK_S];
        [self.bestStreakLabel setText:[bestStreak stringValue]];
    }
    [self.buttonNext setEnabled:YES];
    [self.buttonNext setBackgroundImage:[UIImage imageNamed:@"NextSearch.png"] forState:UIControlStateNormal];
    [self performSelector:@selector(StartANewSearch:) withObject:NO afterDelay:TIME_BETWEEN];
}

- (void)buttonFailClick:(id)sender{
    [soundEffects PlaySoundGameButtonFailure];
    [sender setBackgroundColor:[UIColor redColor]];
    [correctButton setBackgroundColor:[UIColor greenColor]];
    
    [self.theResultLabel setText:[failureArray objectAtIndex:arc4random() % [failureArray count]]];
    goNext = YES;
    queryQueued++;
    currentStreak = [NSNumber numberWithInt:0];
    [self.currentStreakLabel setText:[currentStreak stringValue]];
    [self.buttonNext setEnabled:YES];
    [self.buttonNext setBackgroundImage:[UIImage imageNamed:@"NextSearch.png"] forState:UIControlStateNormal];
    [self ClearButtonsEvents];
    [self performSelector:@selector(StartANewSearch:) withObject:NO afterDelay:TIME_BETWEEN];
}

- (IBAction)buttonNextClick:(id)sender {
    [self StartANewSearch:YES];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self performSelector:@selector(StartANewSearch:) withObject:NO afterDelay:TIME_BETWEEN];
}

-(void)SetButtonTextAndClick:(NSString *) theQuery{
    [self.theSearchLabel setText:theQuery];
    
    suggestions = [GoogleSuggestions alloc];
    [suggestions InitializeWithTheSearch:theQuery];
    
    if([[suggestions GetTheArrayOfSuggestions] count] < 3){
        [self StartANewSearch: false];
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
