//
//  SoloModeViewController.m
//  Search Party
//
//  Created by Ross Lewis on 3/25/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "SoloModeViewController.h"
#import "QueryDatabase.h"
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface SoloModeViewController ()

@end

@implementation SoloModeViewController

//this was in the header but i made it static and that seemed to fix the problem.....
static int queryQueued;

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
    self.trackedViewName = @"SinglePlayer";
	// Do any additional setup after loading the view.
    
    if(SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(@"5.0")){
        [self.twitterButton removeFromSuperview];
        [self.StaticBestStreak setFont:[UIFont fontWithName:[[self.StaticBestStreak font] familyName] size:11]];
        [self.StaticCurrentStreak setFont:[UIFont fontWithName:[[self.StaticCurrentStreak font] familyName] size:11]];
        [self.StaticPercentCorrect setFont:[UIFont fontWithName:[[self.StaticPercentCorrect font] familyName] size:11]];
        [self.StaticTopText setFont:[UIFont fontWithName:[[self.StaticTopText font] familyName] size:16]];
    }else if(SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(@"5.1")){
        [self.twitterButton removeFromSuperview];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage * settingsImage = [UIImage imageNamed:@"SearchParty_Background_Red_640x1136"];
    
    changingBackground=[[UIImageView alloc]initWithImage:settingsImage];// take image size according to view
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    changingBackground.frame = CGRectMake(0,0,screenWidth,screenHeight);
    changingBackground.alpha = BACKGROUNDALPHA;
    [self.view insertSubview:changingBackground atIndex:0];
    
    accountStore = [[ACAccountStore alloc]init];

    //get the queries from the sqlite3 file
    queryArray = [[NSMutableArray alloc] init];
    queryArray = [QueryDatabase database].queries;
    
    //initialize the global variables and the controls
    [self.buttonNext setEnabled:YES];
    currentStreak = [[NSNumber alloc]init];
    bestStreak = [[NSNumber alloc]init];
    goNext = YES;
    queryQueued = 0;
    soundEffects = [[SoundEffects alloc] init];
    
    gameCenterHelper = [GameCenterHelper sharedInstance];
    
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
    
    //load incorrect answers
    if([streak objectForKey:INCORRECT_ANS_S] == nil){
        incorrectAns = [NSNumber numberWithInt:0];
    }else{
        incorrectAns = [streak objectForKey:INCORRECT_ANS_S];
    }
    
    //load correct answers
    if([streak objectForKey:CORRECT_ANS_S] == nil){
        correctAns = [NSNumber numberWithInt:0];
    }else{
        correctAns = [streak objectForKey:CORRECT_ANS_S];
    }
    
    [self.PercentCorrectLabel setText:[self GetPercentString]];
    
    [[self.buttonOne layer] setBorderWidth:1.0f];
    [[self.buttonOne layer] setBorderColor:[UIColor blueColor].CGColor];
    [[self.buttonTwo layer] setBorderWidth:1.0f];
    [[self.buttonTwo layer] setBorderColor:[UIColor blueColor].CGColor];
    [[self.buttonThree layer] setBorderWidth:1.0f];
    [[self.buttonThree layer] setBorderColor:[UIColor blueColor].CGColor];
    [[self.theSearchLabel layer] setBorderWidth:1.0f];
    [[self.theSearchLabel layer] setBorderColor:[UIColor blueColor].CGColor];
    [[self.topSearchView layer] setBorderWidth:1.0f];
    [[self.topSearchView layer] setBorderColor:[UIColor blackColor].CGColor];
    
    //get the correct / incorrect response strings
    successArray = [[NSMutableArray alloc]init];
    failureArray = [[NSMutableArray alloc]init];
    [successArray addObject:SOLO_CORRECT1];
    [successArray addObject:SOLO_CORRECT2];
    [successArray addObject:SOLO_CORRECT3];
    [successArray addObject:SOLO_CORRECT4];
    [successArray addObject:SOLO_CORRECT5];
    [successArray addObject:SOLO_CORRECT6];
    [successArray addObject:SOLO_CORRECT7];
    [successArray addObject:SOLO_CORRECT8];
    [successArray addObject:SOLO_CORRECT9];
    [successArray addObject:SOLO_CORRECT10];
    [successArray addObject:SOLO_CORRECT11];
    [successArray addObject:SOLO_CORRECT12];
    [successArray addObject:SOLO_CORRECT13];
    [successArray addObject:SOLO_CORRECT14];
    [successArray addObject:SOLO_CORRECT15];
    [successArray addObject:SOLO_CORRECT16];
    [successArray addObject:SOLO_CORRECT17];
    [successArray addObject:SOLO_CORRECT18];
    [successArray addObject:SOLO_CORRECT19];
    [successArray addObject:SOLO_CORRECT20];
    [successArray addObject:SOLO_CORRECT21];
    [successArray addObject:SOLO_CORRECT22];
    [successArray addObject:SOLO_CORRECT23];
    [successArray addObject:SOLO_CORRECT24];
    [successArray addObject:SOLO_CORRECT25];
    [successArray addObject:SOLO_CORRECT26];
    [successArray addObject:SOLO_CORRECT27];
    [successArray addObject:SOLO_CORRECT28];
    [successArray addObject:SOLO_CORRECT29];
    [successArray addObject:SOLO_CORRECT30];
    [successArray addObject:SOLO_CORRECT31];
    [failureArray addObject:SOLO_WRONG1];
    [failureArray addObject:SOLO_WRONG2];
    [failureArray addObject:SOLO_WRONG3];
    [failureArray addObject:SOLO_WRONG4];
    [failureArray addObject:SOLO_WRONG5];
    [failureArray addObject:SOLO_WRONG6];
    [failureArray addObject:SOLO_WRONG7];
    [failureArray addObject:SOLO_WRONG8];
    [failureArray addObject:SOLO_WRONG9];
    [failureArray addObject:SOLO_WRONG10];
    [failureArray addObject:SOLO_WRONG11];
    [failureArray addObject:SOLO_WRONG12];
    [failureArray addObject:SOLO_WRONG13];
    [failureArray addObject:SOLO_WRONG14];
    [failureArray addObject:SOLO_WRONG15];
    [failureArray addObject:SOLO_WRONG16];
    [failureArray addObject:SOLO_WRONG17];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f) {
            /*Do iPhone 5 stuff here.*/
        } else {
            /*Do iPhone Classic stuff here.*/
            [self.soloModePicture removeFromSuperview];
            [self.soloModeText removeFromSuperview];
        }
    } else {
        /*Do iPad stuff here.*/
    }
    
    [self StartANewSearch:YES];
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
        [self ClearButtonsEvents];
        [self.theResultLabel setText:@""];
        if(![queryArray count] < 1){
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading Suggestions" width:150];
            
            [self performSelector: @selector(SetupNewSearch) withObject:nil afterDelay:.1];
        }else{
            //if the array is empty initialize a new array
            queryArray = [[NSMutableArray alloc] init];
            queryArray = [QueryDatabase database].queries;
            
            [self StartANewSearch:YES];
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
        //if its a multiple of 15, show rate/ please buy popup
        NSNumber * totalAns = [[NSNumber alloc] init];
        if([streak objectForKey:TOTAL_ANS_S] == nil){
            totalAns = [NSNumber numberWithInt:0];
        }else{
            totalAns = [streak objectForKey:TOTAL_ANS_S];
        }
        
        int number = [totalAns intValue];
        //rotate colors
        UIImage * backImage;
        bool isIphone5 = YES;
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height > 480.0f) {
                /*Do iPhone 5 stuff here.*/
                isIphone5 = YES;
            } else {
                /*Do iPhone Classic stuff here.*/
                isIphone5 = NO;
            }
        } else {
            /*Do iPad stuff here.*/
        }
        if(number%4 == 0){
            if(isIphone5)
                backImage = [UIImage imageNamed:@"SearchParty_Background_Red_640x1136.png"];
            else
                backImage = [UIImage imageNamed:@"SearchParty_Background_Red_640x960.png"];
        }else if(number%3 == 0){
            if(isIphone5)
                backImage = [UIImage imageNamed:@"SearchParty_Background_Blue_640x1136.png"];
            else
                backImage = [UIImage imageNamed:@"SearchParty_Background_Blue_640x960.png"];
        }else if(number%2 == 0){
            if(isIphone5)
                backImage = [UIImage imageNamed:@"SearchParty_Background_Yellow_640x1136.png"];
            else
                backImage = [UIImage imageNamed:@"SearchParty_Background_Yellow_640x960.png"];
        }else{
            if(isIphone5)
                backImage = [UIImage imageNamed:@"SearchParty_Background_Green_640x1136.png"];
            else
                backImage = [UIImage imageNamed:@"SearchParty_Background_Green_640x960.png"];
        }
        [changingBackground setImage:backImage];
        
        //at 30's show "like it? rate it!  don't like something, email me!"
        //at 15's show "suppoert me!"
        if(number > 0){
            if(number%45 == 0){
                streak = [NSUserDefaults standardUserDefaults];
                bool userHasRated = [streak boolForKey:HAS_RATED_S];
                
                if(!userHasRated){
                    suggestRate = [[SuggestRate alloc]init];
                    [suggestRate ShowAlert];
                }
            }else if(number%30 == 0){
                streak = [NSUserDefaults standardUserDefaults];
                bool userHasShared = [streak boolForKey:HAS_SHARED_S];
                
                if(!userHasShared){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Goofy results?"
                                                                    message:@"Hit the button on the top right to share a screenshot with your friends!"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
            }else if(number % 15 == 0){
                streak = [NSUserDefaults standardUserDefaults];
                bool userHasPurch = [streak boolForKey:HAS_PURCH_S];
                
                if(!userHasPurch){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Want more?"
                                                                    message:@"Want more phrases?  Support me by unlocking them in the settings page!"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
            }
        }
        
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
        
        //start a countdown (10 seconds)
        //with this label [self.theResultLabel setText:@""];
        //if it gets to 0, show correct answer, but don't affect score
        countDown = 10;
        [self.theResultLabel setText:[NSString stringWithFormat:@"%d",countDown]];
        countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(advanceTimer:) userInfo:nil repeats:YES];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:countdownTimer forMode:NSDefaultRunLoopMode];
        
        [DejalBezelActivityView removeViewAnimated:YES];
    }
}

- (void)advanceTimer:(NSTimer *)timer
{
    countDown = countDown - 1;
    if (countDown == 0)
    {
        // code to stop the timer
        //and show correct answer
        [self timerExpired];
    }else{
        [self.theResultLabel setText:[NSString stringWithFormat:@"%d",countDown]];
    }
}

//timer to give users only 10 seconds to answer
-(void)timerExpired{
    [countdownTimer invalidate];
    countdownTimer = nil;
    
    [self.theResultLabel setText:[NSString stringWithFormat:@"Time is up!  This was the correct answer."]];
    
    [correctButton setBackgroundColor:[UIColor greenColor]];
    
    goNext = YES;
    [soundEffects PlaySoundGameButtonFailure];
    [self ClearButtonsEvents];
    [self CreateGoogleButtons];
    [self performSelector:@selector(StartANewSearch:) withObject:nil afterDelay:TIME_BETWEEN];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonSuccessClick:(id)sender {
    [countdownTimer invalidate];
    countdownTimer = nil;
    queryQueued++;
    [self ClearButtonsEvents];
    [self.theResultLabel setText:[successArray objectAtIndex:arc4random() % [successArray count]]];
    goNext = YES;
    
    [soundEffects PlaySoundGameButtonSuccess];
    [sender setBackgroundColor:[UIColor greenColor]];    
    currentStreak = [NSNumber numberWithInt:[currentStreak intValue] + 1];
    [self.currentStreakLabel setText:[currentStreak stringValue]];
    streak = [NSUserDefaults standardUserDefaults];
    if([currentStreak intValue] > [bestStreak intValue]){
        bestStreak = currentStreak;
        [streak setObject:bestStreak forKey:BEST_STREAK_S];
        [self.bestStreakLabel setText:[bestStreak stringValue]];
        justUpdatedStreak = YES;

        [gameCenterHelper reportScore: [currentStreak intValue] forCategory: HIGHEST_STREATK_ID];
    }
    
    //load incorrect answers
    if([streak objectForKey:INCORRECT_ANS_S] == nil){
        incorrectAns = [NSNumber numberWithInt:0];
    }else{
        incorrectAns = [streak objectForKey:INCORRECT_ANS_S];
    }
    
    //load correct answers
    if([streak objectForKey:CORRECT_ANS_S] == nil){
        correctAns = [NSNumber numberWithInt:0];
    }else{
        correctAns = [streak objectForKey:CORRECT_ANS_S];
    }
    
    correctAns = [NSNumber numberWithInt:[correctAns intValue] + 1];
    [streak setObject:correctAns forKey:CORRECT_ANS_S];
    
    //load total answered
    NSNumber * totalAns = [[NSNumber alloc]init];
    if([streak objectForKey:TOTAL_ANS_S] == nil){
        totalAns = [NSNumber numberWithInt:0];
    }else{
        totalAns = [streak objectForKey:TOTAL_ANS_S];
    }
    totalAns = [NSNumber numberWithInt:[totalAns intValue] + 1];
    //set total answered
    [streak setObject:totalAns forKey:TOTAL_ANS_S];
    
    //load if using pop and load pop answers
    //increment pop answers
    //submit pop answers
    if([streak objectForKey:POP_PACK_S] != nil && [streak boolForKey:POP_PACK_S])
    {
        NSNumber * totalAnsPop = [[NSNumber alloc]init];
        if([streak objectForKey:TOTAL_POP_ANS] == nil){
            totalAnsPop = [NSNumber numberWithInt:0];
        }else{
            totalAnsPop = [streak objectForKey:TOTAL_POP_ANS];
        }
        totalAnsPop = [NSNumber numberWithInt:[totalAnsPop intValue] + 1];
        //set total answered
        [streak setObject:totalAnsPop forKey:TOTAL_POP_ANS];
        [gameCenterHelper submitAchievement:POP_CULTURE_GURU percentComplete:(([totalAnsPop doubleValue] / 20) * 100)];
    }
    
    //load if using celeb and load celeb answers
    //increment celeb answers
    //submit celeb answers
    if([streak objectForKey:CELEB_PACK_S] != nil && [streak boolForKey:CELEB_PACK_S])
    {
        NSNumber * totalAnsCeleb = [[NSNumber alloc]init];
        if([streak objectForKey:TOTAL_CELEB_ANS] == nil){
            totalAnsCeleb = [NSNumber numberWithInt:0];
        }else{
            totalAnsCeleb = [streak objectForKey:TOTAL_CELEB_ANS];
        }
        totalAnsCeleb = [NSNumber numberWithInt:[totalAnsCeleb intValue] + 1];
        //set total answered
        [streak setObject:totalAnsCeleb forKey:TOTAL_CELEB_ANS];
        [gameCenterHelper submitAchievement:THE_CELEBRITY percentComplete:(([totalAnsCeleb doubleValue] / 20) * 100)];
    }
    
    //submit current streak to each
    [gameCenterHelper submitAchievement:APPRENTICE_GUESSER percentComplete:(([currentStreak doubleValue] / 3) * 100)];
    [gameCenterHelper submitAchievement:SKILLED_SEARCHER percentComplete:(([currentStreak doubleValue] / 5) * 100)];
    [gameCenterHelper submitAchievement:INTERNET_AFICIONADO percentComplete:(([currentStreak doubleValue] / 7) * 100)];
    [gameCenterHelper submitAchievement:THE_IMPOSSIBLE percentComplete:(([currentStreak doubleValue] / 15) * 100)];
    
    //if correct + incorrect > 20 and % > 50
    //submit acheivment
    if((([incorrectAns floatValue] + [correctAns floatValue]) > 19) && [[NSNumber numberWithFloat:(([correctAns floatValue]/([incorrectAns floatValue] + [correctAns floatValue]))*100)] floatValue] > 50)
    {
        [gameCenterHelper submitAchievement:MR_CONSISTENT percentComplete:100];
    }
    
    [self.PercentCorrectLabel setText:[self GetPercentString]];
    
    [self CreateGoogleButtons];
    [self.buttonNext setEnabled:YES];
    [self.buttonNext setBackgroundImage:[UIImage imageNamed:@"NextSearch.png"] forState:UIControlStateNormal];
    [self performSelector:@selector(StartANewSearch:) withObject:NO afterDelay:TIME_BETWEEN];
}

- (void)buttonFailClick:(id)sender{
    [countdownTimer invalidate];
    countdownTimer = nil;
    queryQueued++;
    [self ClearButtonsEvents];
    [self.theResultLabel setText:[failureArray objectAtIndex:arc4random() % [failureArray count]]];
    goNext = YES;
    
    //load incorrect answers
    if([streak objectForKey:INCORRECT_ANS_S] == nil){
        incorrectAns = [NSNumber numberWithInt:0];
    }else{
        incorrectAns = [streak objectForKey:INCORRECT_ANS_S];
    }
    
    //load correct answers
    if([streak objectForKey:CORRECT_ANS_S] == nil){
        correctAns = [NSNumber numberWithInt:0];
    }else{
        correctAns = [streak objectForKey:CORRECT_ANS_S];
    }
    
    incorrectAns = [NSNumber numberWithInt:[incorrectAns intValue] + 1];
    [streak setObject:incorrectAns forKey:INCORRECT_ANS_S];
    
    //load total answered
    NSNumber * totalAns = [[NSNumber alloc]init];
    if([streak objectForKey:TOTAL_ANS_S] == nil){
        totalAns = [NSNumber numberWithInt:0];
    }else{
        totalAns = [streak objectForKey:TOTAL_ANS_S];
    }
    totalAns = [NSNumber numberWithInt:[totalAns intValue] + 1];
    
    [streak setObject:totalAns forKey:TOTAL_ANS_S];
    
    [self.PercentCorrectLabel setText:[self GetPercentString]];
    
    [soundEffects PlaySoundGameButtonFailure];
    [sender setBackgroundColor:[UIColor redColor]];
    [correctButton setBackgroundColor:[UIColor greenColor]];
    currentStreak = [NSNumber numberWithInt:0];
    [self.currentStreakLabel setText:[currentStreak stringValue]];
    [self.buttonNext setEnabled:YES];
    [self.buttonNext setBackgroundImage:[UIImage imageNamed:@"NextSearch.png"] forState:UIControlStateNormal];
    if(justUpdatedStreak && gameCenterHelper->userAuthenticated){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Record :D"
                                                        message:@"Your score was updated in the leaderboard!  Go to the main menu to check out the standings!"
                                                       delegate:self
                                              cancelButtonTitle:ALL_PACKS_OFF_OK
                                              otherButtonTitles:nil];
        [alert show];
    }
    justUpdatedStreak = NO;
    [self CreateGoogleButtons];
    [self performSelector:@selector(StartANewSearch:) withObject:NO afterDelay:TIME_BETWEEN];
}

-(NSString*)GetPercentString{
    NSString * percentText = @"";
    if([[NSNumber numberWithFloat:([incorrectAns floatValue] + [correctAns floatValue])] isEqualToNumber:[NSNumber numberWithFloat:0]]){
        percentText = [percentText stringByAppendingFormat:@"%@%@",@"0",@"%"];
    }else{
        NSString * percentValue = [[NSString alloc]init];
        NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
        [fmt setPositiveFormat:@"##0.00"];
        percentValue = [fmt stringFromNumber:[NSNumber numberWithFloat:(([correctAns floatValue]/([incorrectAns floatValue] + [correctAns floatValue]))*100)]];
        percentText = [percentText stringByAppendingFormat:@"%@%@",percentValue,@"%"];
    }
    return percentText;
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
    [self.buttonOne.titleLabel setTextAlignment:UITextAlignmentCenter];
    
    
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
    [self.buttonTwo.titleLabel setTextAlignment:UITextAlignmentCenter];
    
    //button three
    buttonText = [arrayOfSuggestions objectAtIndex:0];
    [self.buttonThree setTitle:[buttonText GetTheSuggestion] forState:UIControlStateNormal];
    if([buttonText GetTheBest]){
        correctButton = self.buttonThree;
        [self.buttonThree addTarget:self action:@selector(buttonSuccessClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self.buttonThree addTarget:self action:@selector(buttonFailClick:) forControlEvents:UIControlEventTouchUpInside ];
    }
    [self.buttonThree.titleLabel setTextAlignment:UITextAlignmentCenter];
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

-(void)CreateGoogleButtons{
    [self.buttonOne addTarget:self action:@selector(buttonGoogleSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonTwo addTarget:self action:@selector(buttonGoogleSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonThree addTarget:self action:@selector(buttonGoogleSearch:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonGoogleSearch:(id)sender {
    UIButton * searchButton = (UIButton *)sender;
    
    searchGoogle = [[OpenSearchInGoogle alloc] init];
    [searchGoogle ShowAlertWithQuery:searchButton.currentTitle];
}

- (IBAction)TwitterClick:(id)sender {
    streak = [NSUserDefaults standardUserDefaults];
    
    [streak setBool:true forKey:HAS_SHARED_S];
    
    //take screenshot
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(self.view.window.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(self.view.window.bounds.size);
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Save the screenshot to the device's photo album
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Opening Twitter :D" width:150];
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(twitImage:didFinishSavingWithError:contextInfo:), nil);
}

// callback for UIImageWriteToSavedPhotosAlbum
- (void)twitImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    //tweet photo @searchpartypocket
        
    //  Create an instance of the Tweet Sheet
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:
                                           SLServiceTypeTwitter];
    
    // Sets the completion handler.  Note that we don't know which thread the
    // block will be called on, so we need to ensure that any UI updates occur
    // on the main queue
    tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
        switch(result) {
                //  This means the user cancelled without sending the Tweet
            case SLComposeViewControllerResultCancelled:
                break;
                //  This means the user hit 'Send'
            case SLComposeViewControllerResultDone:
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                                message:@"Your tweet has been sent!  Thanks for playing! ^_^"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                break;
            }
        }
        
        //  dismiss the Tweet Sheet
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:NO completion:^{
                NSLog(@"Tweet Sheet has been dismissed.");
            }];
        });
    };
    
    //  Set the initial body of the Tweet
    [tweetSheet setInitialText:@"@SearchPartyGame "];
    
    //  Adds an image to the Tweet.
    if (!error & ![tweetSheet addImage:image]) {
        NSLog(@"Unable to add the image!");
    }
    
    //  Add an URL to the Tweet.  You can add multiple URLs.
    if (![tweetSheet addURL:[NSURL URLWithString:@"http://itun.es/i6xd5zz"]]){
        NSLog(@"Unable to add the URL!");
    }
    
    //  Presents the Tweet Sheet to the user
    [self presentViewController:tweetSheet animated:NO completion:^{
        [DejalBezelActivityView removeViewAnimated:YES];
        NSLog(@"Tweet sheet has been presented.");
    }];
}

- (IBAction)FacebookClick:(id)sender {
    streak = [NSUserDefaults standardUserDefaults];
    
    [streak setBool:true forKey:HAS_SHARED_S];
    
    //take screenshot
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(self.view.window.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(self.view.window.bounds.size);
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Save the screenshot to the device's photo album
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Opening Facebook :D" width:150];
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(fbImage:didFinishSavingWithError:contextInfo:), nil);

}

// callback for UIImageWriteToSavedPhotosAlbum
- (void)fbImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if(!error){
        //upload photo
        //if no image error do this
        //else if this doesn't work or image error do the fallback
        BOOL displayedNativeDialog = [FBNativeDialogs
                                      presentShareDialogModallyFrom:self
                                      initialText:@""
                                      image:image
                                      url:[NSURL URLWithString:@"http://itun.es/i6xd5zz"]
                                      handler:^(FBNativeDialogResult result, NSError *error) {
                                          
                                          NSString *alertText = @"";
                                          if ([[error userInfo][FBErrorDialogReasonKey] isEqualToString:FBErrorDialogNotSupported]) {
                                              //alertText = @"iOS Share Sheet not supported.";
                                              //do other uploader
                                              //[self BackupFacebookUploader];
                                          } else if (error) {
                                              //alertText = [NSString stringWithFormat:@"error: domain = %@, code = %d", error.domain, error.code];
                                              //do other uploader
                                              [self BackupFacebookUploader];
                                          } else if (result == FBNativeDialogResultSucceeded) {
                                              alertText = @"Thanks for posting!  Your upload was successfully!";
                                          }
                                          
                                          if (![alertText isEqualToString:@""]) {
                                              // Show the result in an alert
                                              [[[UIAlertView alloc] initWithTitle:@"Facebook Upload"
                                                                          message:alertText
                                                                         delegate:self
                                                                cancelButtonTitle:@"OK!"
                                                                otherButtonTitles:nil]
                                               show];
                                          }
                                      }];
        if (!displayedNativeDialog) {
            [self BackupFacebookUploader];
        }else{
            [DejalBezelActivityView removeViewAnimated:YES];
        }
    }else{
        [self BackupFacebookUploader];
    }
}

-(void)BackupFacebookUploader{
    // This function will invoke the Feed Dialog to post to a user's Timeline and News Feed
    // It will attemnt to use the Facebook Native Share dialog
    // If that's not supported we'll fall back to the web based dialog.
    
    NSString *linkURL = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/search-party-pocket/id648136813?mt=8"];
    NSString *pictureURL = @"http://nebula.wsimg.com/7ab3451b62ab1586ae8de7f2807d6a4d?AccessKeyId=E3F677DE8B7E129279D4&disposition=0";
    
    // Prepare the native share dialog parameters
    FBShareDialogParams *shareParams = [[FBShareDialogParams alloc] init];
    shareParams.link = [NSURL URLWithString:linkURL];
    shareParams.name = @"Try Search Party!";
    shareParams.caption= @"Can you get something better?";
    shareParams.picture= [NSURL URLWithString:pictureURL];
    shareParams.description =
    [NSString stringWithFormat:@"Which is search the most on the internet from the phrase \"%@\"?  (1) \"%@\".  (2) \"%@\".  (3) \"%@\".", self.theSearchLabel.text,self.buttonOne.titleLabel.text,self.buttonTwo
     .titleLabel.text,self.buttonThree.titleLabel.text];
    
    if ([FBDialogs canPresentShareDialogWithParams:shareParams]){
        
        [FBDialogs presentShareDialogWithParams:shareParams
                                    clientState:nil
                                        handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                            if(error) {
                                                NSLog(@"Error publishing story.");
                                                [[[UIAlertView alloc] initWithTitle:@"Facebook Post"
                                                                            message:@"There was an error with your post :( Please try again soon"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"ok"
                                                                  otherButtonTitles:nil] show];
                                            } else if (results[@"completionGesture"] && [results[@"completionGesture"] isEqualToString:@"cancel"]) {
                                                NSLog(@"User canceled story publishing.");
                                            } else {
                                                NSLog(@"Story published.");
                                                [[[UIAlertView alloc] initWithTitle:@"Facebook Post"
                                                                            message:@"Your post was successful!"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"OK!"
                                                                  otherButtonTitles:nil] show];
                                            }
                                        }];
        
    }else {
        
        // Prepare the web dialog parameters
        NSDictionary *params = @{
                                 @"name" : shareParams.name,
                                 @"caption" : shareParams.caption,
                                 @"description" : shareParams.description,
                                 @"picture" : pictureURL,
                                 @"link" : linkURL
                                 };
        
        // Invoke the dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:
         ^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
             if (error) {
                 NSLog(@"Error publishing story.");
                 [[[UIAlertView alloc] initWithTitle:@"Facebook Post"
                                             message:@"There was an error with your post :( Please try again soon"
                                            delegate:self
                                   cancelButtonTitle:@"ok"
                                   otherButtonTitles:nil] show];
             } else {
                 if (result == FBWebDialogResultDialogNotCompleted) {
                     NSLog(@"User canceled story publishing.");
                 } else {
                     NSLog(@"Story published.");
                     [[[UIAlertView alloc] initWithTitle:@"Facebook Post"
                                                 message:@"Your post was successful!"
                                                delegate:self
                                       cancelButtonTitle:@"OK!"
                                       otherButtonTitles:nil] show];
                 }
             }}];
    }
    [DejalBezelActivityView removeViewAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if ([[segue identifier] isEqualToString:SEGUE_FOR_OPTIONS])
    //{
    [countdownTimer invalidate];
    countdownTimer = nil;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //}
}

- (void)viewDidUnload {
    [countdownTimer invalidate];
    countdownTimer = nil;
    [self setTwitterButton:nil];
    [self setStaticTopText:nil];
    [self setStaticPercentCorrect:nil];
    [self setStaticCurrentStreak:nil];
    [self setStaticBestStreak:nil];
    [super viewDidUnload];
}

@end
