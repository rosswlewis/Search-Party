//
//  ViewController.m
//  Search Party
//
//  Created by Ross Lewis on 3/25/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "ViewController.h"
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //load
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage * backImg;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f) {
            /*Do iPhone 5 stuff here.*/
            backImg = [UIImage imageNamed:@"SearchParty_Background_Yellow_640x1136.png"];
        } else {
            /*Do iPhone Classic stuff here.*/
            backImg = [UIImage imageNamed:@"SearchParty_Background_Yellow_640x960.png"];
        }
    } else {
        /*Do iPad stuff here.*/
    }
    backgroundImage=[[UIImageView alloc]initWithImage:backImg];// take image size according to view
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    backgroundImage.frame = CGRectMake(0,0,screenWidth,screenHeight);
    backgroundImage.alpha = .3;
    [self.view insertSubview:backgroundImage atIndex:0];
    
    soundEffects = [[SoundEffects alloc] init];
    settings = [NSUserDefaults standardUserDefaults];
    howLongLoading = 0;
    
    //Get what's purchasable on the app store
    [self requestProductData];
    observer = [[MyStoreObserver alloc] init];
    //[observer setDelegate:self];
    [observer setProducts:myProducts CorrectViewController:self];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:observer];
    
    if(SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(@"5.0")){
        [self.CorrectStaticText setFont:[UIFont fontWithName:[[self.CorrectStaticText font] familyName] size:11]];
        [self.IncorrectStaticText setFont:[UIFont fontWithName:[[self.IncorrectStaticText font] familyName] size:11]];
        [self.MainMenuSearchPartyText setFont:[UIFont fontWithName:[[self.MainMenuSearchPartyText font] familyName] size:30]];
        [self.GamePickerSearchPartyText setFont:[UIFont fontWithName:[[self.GamePickerSearchPartyText font] familyName] size:30]];
    }
    
    //this is the how to play image, it will need some work
    UIImageView *settingsImageView;
    UIImage * settingsImage = [UIImage imageNamed:CREDIT_IMG];
    settingsImageView=[[UIImageView alloc]initWithImage:settingsImage];// take image size according to view
    settingsImageView.frame = CGRectMake(
                                 0,0, 280, 750);
    [self.SettingsScroller addSubview:settingsImageView];
    
    self.SettingsScroller.scrollEnabled = YES;
    self.SettingsScroller.contentSize = CGSizeMake(280,750);
    
    //set sound switch
    if([settings objectForKey:SOUND_S] == nil){
        sound = NO;
    }else{
        sound = [settings boolForKey:SOUND_S];
    }
    [self.SoundSwitch setOn:sound];
    
    //set sound effects switch
    if([settings objectForKey:SOUND_EFFECTS_S] == nil){
        soundEffectsOn = YES;
    }else{
        soundEffectsOn = [settings boolForKey:SOUND_EFFECTS_S];
    }
    [self.SoundEffectsSwitch setOn:soundEffectsOn];
    
    if(sound){
        [soundEffects PlayBackgroundMusic];
    }
    
    //set incorrect answers
    if([settings objectForKey:INCORRECT_ANS_S] == nil){
        incorrectAns = [NSNumber numberWithInt:0];
    }else{
        incorrectAns = [settings objectForKey:INCORRECT_ANS_S];
    }
    [self.IncorrectAnsLabel setText: [incorrectAns stringValue]];
    
    //set correct answers
    if([settings objectForKey:CORRECT_ANS_S] == nil){
        correctAns = [NSNumber numberWithInt:0];
    }else{
        correctAns = [settings objectForKey:CORRECT_ANS_S];
    }
    [self.CorrectAnsLabel setText: [correctAns stringValue]];
    
    //set default pack check
    if([settings objectForKey:DEFAULT_PACK_S] == nil){
        defaultPack = YES;
    }else{
        defaultPack = [settings boolForKey:DEFAULT_PACK_S];
    }
    
    //get and set pop pack
    if([settings objectForKey:POP_PACK_PURCHASED_S] == nil){
        popPackPurchased = NO;
    }else{
        popPackPurchased = [settings boolForKey:POP_PACK_PURCHASED_S];
    }
    
    //UNCOMMENT WHEN PURCHASES ARE ACTIVE
    if(popPackPurchased){
        //set pop pack check
        [settings setBool:true forKey:HAS_PURCH_S];
        if([settings objectForKey:POP_PACK_S] == nil){
            popPack = YES;
        }else{
            popPack = [settings boolForKey:POP_PACK_S];
        }
    }else{
        popPack = NO;
    }
    [self.view addSubview:[self.PopSearchPackCheck initWithFrameAndCheck:CGRectMake(self.PopSearchPackCheck.frame.origin.x, self.PopSearchPackCheck.frame.origin.y, 32, 32) checked:popPack]];
    
    //get and set celeb pack
    if([settings objectForKey:CELEB_PACK_PURCHASED_S] == nil){
        celebPackPurchased = NO;
    }else{
        celebPackPurchased = [settings boolForKey:CELEB_PACK_PURCHASED_S];
    }
    
    //UNCOMMENT WHEN PURCHASES ARE ACTIVE
    if(celebPackPurchased){
        //set pop pack check
        [settings setBool:true forKey:HAS_PURCH_S];
        if([settings objectForKey:CELEB_PACK_S] == nil){
            celebPack = YES;
        }else{
            celebPack = [settings boolForKey:CELEB_PACK_S];
        }
    }else{
        celebPack = NO;
    }
    [self.view addSubview:[self.CelebritySearchPackCheck initWithFrameAndCheck:CGRectMake(self.CelebritySearchPackCheck.frame.origin.x, self.CelebritySearchPackCheck.frame.origin.y, 32, 32) checked:celebPack]];
    
    if([self AllPacksOff]){
        defaultPack = YES;
        [settings setBool:defaultPack forKey:DEFAULT_PACK_S];
    }
    [self.view addSubview:[self.DefaultSearchPackCheck initWithFrameAndCheck:CGRectMake(self.DefaultSearchPackCheck.frame.origin.x, self.DefaultSearchPackCheck.frame.origin.y, 32, 32) checked:defaultPack]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SoundChanged:(id)sender {
    sound = [self.SoundSwitch isOn];
    settings = [NSUserDefaults standardUserDefaults];
    [settings setBool:sound forKey:SOUND_S];
    if(sound){
        [soundEffects PlayBackgroundMusic];
    }else{
        [soundEffects StopBackgroundMusic];
    }
}

- (IBAction)SoundEffectsChanged:(id)sender {
    soundEffectsOn = [self.SoundEffectsSwitch isOn];
    settings = [NSUserDefaults standardUserDefaults];
    [settings setBool:soundEffectsOn forKey:SOUND_EFFECTS_S];
}

- (IBAction)PopSearchPackChanged:(id)sender {
    settings = [NSUserDefaults standardUserDefaults];
    if([settings objectForKey:POP_PACK_PURCHASED_S] == nil){
        popPackPurchased = NO;
    }else{
        popPackPurchased = [settings boolForKey:POP_PACK_PURCHASED_S];
    }
    
    if(popPackPurchased){
    //if(YES){
        popPack = ![self.PopSearchPackCheck isChecked];
        if(![self AllPacksOff])
        {
            [self.PopSearchPackCheck checkBoxClicked];
            [settings setBool:popPack forKey:POP_PACK_S];
            
            [settings setBool:true forKey:HAS_PURCH_S];
        }else{
            popPack = YES;
            
            [self ShowAllPackOffAlert];
        }
    }else{//TODO!!!!should wait here if myproducts isn't initialized yet
        if ([SKPaymentQueue canMakePayments]) {
            if(myProducts.count == 0){
                if(howLongLoading == 0){
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Connecting to the App Store" width:200];
                }
                howLongLoading++;
                if(howLongLoading > 30){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Slow Connection"
                                                                    message:@"We couldn't connect to the App Store.  Please try again!"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                    [DejalBezelActivityView removeViewAnimated:YES];
                    howLongLoading = 0;
                    return;
                }
                [self performSelector: @selector(PopSearchPackChanged:) withObject:sender afterDelay:.4];
                return;
            }
            howLongLoading = 0;
            [DejalBezelActivityView removeViewAnimated:YES];            
            // Display a store to the user.
            //have a popup "buy this search pack? 99c
            popPackPurchase = [PopPackPurchases alloc];
            [popPackPurchase ShowAlert: myProducts];
        } else {
            [self ShowPaymentsTurnedOffAlert];
        }
    }
}

- (IBAction)CelebritySearchPackChanged:(id)sender {
    settings = [NSUserDefaults standardUserDefaults];
    if([settings objectForKey:CELEB_PACK_PURCHASED_S] == nil){
        celebPackPurchased = NO;
    }else{
        celebPackPurchased = [settings boolForKey:CELEB_PACK_PURCHASED_S];
    }
    
    if(celebPackPurchased){
        //if(YES){
        celebPack = ![self.CelebritySearchPackCheck isChecked];
        if(![self AllPacksOff])
        {
            [self.CelebritySearchPackCheck checkBoxClicked];
            [settings setBool:celebPack forKey:CELEB_PACK_S];
            
            [settings setBool:true forKey:HAS_PURCH_S];
        }else{
            celebPack = YES;
            
            [self ShowAllPackOffAlert];
        }
    }else{//TODO!!!!should wait here if myproducts isn't initialized yet
        if ([SKPaymentQueue canMakePayments]) {
            if(myProducts.count == 0){
                if(howLongLoading == 0){
                    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Connecting to the App Store" width:200];
                }
                howLongLoading++;
                if(howLongLoading > 30){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Slow Connection"
                                                                    message:@"We couldn't connect to the App Store.  Please try again!"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                    [DejalBezelActivityView removeViewAnimated:YES];
                    howLongLoading = 0;
                    return;
                }
                [self performSelector: @selector(CelebritySearchPackChanged:) withObject:sender afterDelay:.4];
                return;
            }
            howLongLoading = 0;
            [DejalBezelActivityView removeViewAnimated:YES];
            // Display a store to the user.
            //have a popup "buy this search pack? 99c
            celebPackPurchase = [CelebPackPurchases alloc];
            [celebPackPurchase ShowAlert: myProducts];
        } else {
            [self ShowPaymentsTurnedOffAlert];
        }
    }

}

- (IBAction)ResetButtonPush:(id)sender {
    resetAnswers = [[ResetAnswers alloc] init];
    [resetAnswers ShowAlert:self];
}

-(void)ResetTextValues{
    //set incorrect answers
    if([settings objectForKey:INCORRECT_ANS_S] == nil){
        incorrectAns = [NSNumber numberWithInt:0];
    }else{
        incorrectAns = [settings objectForKey:INCORRECT_ANS_S];
    }
    [self.IncorrectAnsLabel setText: [incorrectAns stringValue]];
    
    //set correct answers
    if([settings objectForKey:CORRECT_ANS_S] == nil){
        correctAns = [NSNumber numberWithInt:0];
    }else{
        correctAns = [settings objectForKey:CORRECT_ANS_S];
    }
    [self.CorrectAnsLabel setText: [correctAns stringValue]];
}

- (IBAction)DefaultSearchPackChanged:(id)sender {
    defaultPack = ![self.DefaultSearchPackCheck isChecked];
    if(![self AllPacksOff])
    {
        [self.DefaultSearchPackCheck checkBoxClicked];
        settings = [NSUserDefaults standardUserDefaults];
        [settings setBool:defaultPack forKey:DEFAULT_PACK_S];
    }else{
        defaultPack = YES;
        
        [self ShowAllPackOffAlert];
    }
}

-(BOOL)AllPacksOff{
    if(!defaultPack && !popPack && !celebPack){
        return YES;
    }
    return NO;
}

//update for another product
- (void) requestProductData
{
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:
                                 [NSSet setWithObjects: POP_PACK_IDENTIFIER, CELEB_PACK_IDENTIFIER, nil]];
    request.delegate = self;
    [request start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    myProducts = response.products;
}

//update for another product
-(void) ShowAllPackOffAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALL_PACKS_OFF_TITLE
                                                    message:ALL_PACKS_OFF_MESS
                                                   delegate:nil
                                          cancelButtonTitle:ALL_PACKS_OFF_OK
                                          otherButtonTitles:nil];
    [alert show];

}

-(void) ShowPaymentsTurnedOffAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:PAYMENTS_OFF_TITLE
                                                    message:PAYMENTS_OFF_MESG
                                                   delegate:nil
                                          cancelButtonTitle:CANCEL
                                          otherButtonTitles:nil];
    [alert show];
}



- (void)viewDidUnload {
    [self setIncorrectStaticText:nil];
    [self setCorrectStaticText:nil];
    [self setMainMenuSearchPartyText:nil];
    [self setGamePickerSearchPartyText:nil];
    [super viewDidUnload];
}
@end
