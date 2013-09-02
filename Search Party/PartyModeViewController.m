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
    self.trackedViewName = @"PartyMode";
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage * settingsImage = [UIImage imageNamed:@"SearchParty_Background_Red_640x1136.png"];
    
    teamColorImageView=[[UIImageView alloc]initWithImage:settingsImage];// take image size according to view
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    teamColorImageView.frame = CGRectMake(0,0,screenWidth,screenHeight);
    teamColorImageView.alpha = BACKGROUNDALPHA;
    [self.view insertSubview:teamColorImageView atIndex:0];
    
    // get all of the queries from the sqlite3 file and use one of them
    queryArray = [[NSMutableArray alloc] init];
    queryArray = [QueryDatabase database].queries;
    soundEffects = [[SoundEffects alloc] init];
    
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
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f) {
            /*Do iPhone 5 stuff here.*/
        } else {
            /*Do iPhone Classic stuff here.*/
            [self.partyModeText removeFromSuperview];
            [self.partyModePicture removeFromSuperview];
        }
    } else {
        /*Do iPad stuff here.*/
    }
    
    [self FreshGame];
}

-(void)FreshGame{
    redTeam = YES;
    [self.redTeamProgress setProgress:0];
    [self.blueTeamProgress setProgress:0];
    blueTeamCorrectAnswers = 0;
    redTeamCorrectAnswers = 0;
    [self.theResultLabel setText:RED_TEAM];
    [self.BlueTeamScoreTExt setText:@"0/5"];
    [self.RedTeamScoreText setText:@"0/5"];
    
    [self StartANewSearch];
}

-(void)StartANewSearch
{
    [self ClearButtonsEvents];
    if(redTeam){
        [self.theResultLabel setText:RED_TEAM];
        UIImage * backImage;
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height > 480.0f) {
                /*Do iPhone 5 stuff here.*/
                backImage = [UIImage imageNamed:@"SearchParty_Background_Red_640x1136.png"];
            } else {
                /*Do iPhone Classic stuff here.*/
                backImage = [UIImage imageNamed:@"SearchParty_Background_Red_640x960.png"];
            }
        } else {
            /*Do iPad stuff here.*/
        }
        [teamColorImageView setImage:backImage];
    }else{
        [self.theResultLabel setText:BLUE_TEAM];
        UIImage * backImage;
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height > 480.0f) {
                /*Do iPhone 5 stuff here.*/
                backImage = [UIImage imageNamed:@"SearchParty_Background_Blue_640x1136.png"];
            } else {
                /*Do iPhone Classic stuff here.*/
                backImage = [UIImage imageNamed:@"SearchParty_Background_Blue_640x960.png"];
            }
        } else {
            /*Do iPad stuff here.*/
        }
        [teamColorImageView setImage:backImage];
    }
    if(!([queryArray count] < 1)){
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading Suggestions" width:150];
        
        [self performSelector: @selector(SetupNewSearch) withObject:nil afterDelay:.1];
    }else{
        queryArray = [[NSMutableArray alloc] init];
        queryArray = [QueryDatabase database].queries;
        
        [self StartANewSearch];
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
        // set the buttons and such
        int random = arc4random() % [queryArray count];
        NSString * theQuery = [queryArray objectAtIndex:random];
        [self SetButtonTextAndClick:theQuery];
        [queryArray removeObjectAtIndex:random];
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
    
    
    if(redTeam){
        redTeamCorrectAnswers += .2;
        if(redTeamCorrectAnswers > .9){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:WINNER
                                                            message:RED_TEAM_WINS
                                                           delegate:nil
                                                  cancelButtonTitle:NEW_GAME
                                                  otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(FreshGame) withObject:nil afterDelay:TIME_BETWEEN];
            return;
        }
        [self.theResultLabel setText:[NSString stringWithFormat:@"%@  %@",[successArray objectAtIndex:arc4random() % [successArray count]], BLUE_TEAM_UP]];
        [self.redTeamProgress setProgress:redTeamCorrectAnswers animated:YES];
        [self.RedTeamScoreText setText:[NSString stringWithFormat:@"%.f%@",(redTeamCorrectAnswers * 5),@"/5"]];
    }else{
        blueTeamCorrectAnswers += .2;
        if(blueTeamCorrectAnswers > .9){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:WINNER
                                                            message:BLUE_TEAM_WINS
                                                           delegate:nil
                                                  cancelButtonTitle:NEW_GAME
                                                  otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(FreshGame) withObject:nil afterDelay:TIME_BETWEEN];
            return;
        }
        [self.theResultLabel setText:[NSString stringWithFormat:@"%@  %@",[successArray objectAtIndex:arc4random() % [successArray count]], RED_TEAM_UP]];
        [self.blueTeamProgress setProgress:blueTeamCorrectAnswers animated:YES];
        [self.BlueTeamScoreTExt setText:[NSString stringWithFormat:@"%.f%@",(blueTeamCorrectAnswers * 5),@"/5"]];
    }
    
    [self ClearButtonsEvents];
    redTeam = !redTeam;
    
    [self CreateGoogleButtons];
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
    
    [self CreateGoogleButtons];
    [self performSelector:@selector(StartANewSearch) withObject:nil afterDelay:TIME_BETWEEN];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
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

- (void)viewDidUnload {
    [self setTopSearchView:nil];
    [self setBlueTeamScoreTExt:nil];
    [self setRedTeamScoreText:nil];
    [super viewDidUnload];
}
@end