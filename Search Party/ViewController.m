//
//  ViewController.m
//  Search Party
//
//  Created by Ross Lewis on 3/25/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //load
    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    soundEffects = [[SoundEffects alloc] init];
    settings = [NSUserDefaults standardUserDefaults];
    
    //Get what's purchasable on the app store
    [self requestProductData];
    observer = [[MyStoreObserver alloc] init];
    [observer setProducts:myProducts];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:observer];
    
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
        sound = YES;
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
    
    //set default pack check
    if([settings objectForKey:DEFAULT_PACK_S] == nil){
        defaultPack = YES;
    }else{
        defaultPack = [settings boolForKey:DEFAULT_PACK_S];
    }
    
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
        if([settings objectForKey:POP_PACK_S] == nil){
            popPack = YES;
        }else{
            popPack = [settings boolForKey:POP_PACK_S];
        }
    }else{
        popPack = NO;
    }
    [self.PopSearchPackCheck initWithFrameAndCheck:CGRectMake(0, 0, 32, 32) checked:popPack];
    
    //get and set celeb pack
    if([settings objectForKey:CELEB_PACK_PURCHASED_S] == nil){
        celebPackPurchased = NO;
    }else{
        celebPackPurchased = [settings boolForKey:CELEB_PACK_PURCHASED_S];
    }
    
    //UNCOMMENT WHEN PURCHASES ARE ACTIVE
    if(celebPackPurchased){
        //set pop pack check
        if([settings objectForKey:CELEB_PACK_S] == nil){
            celebPack = YES;
        }else{
            celebPack = [settings boolForKey:CELEB_PACK_S];
        }
    }else{
        celebPack = NO;
    }
    [self.CelebritySearchPackCheck initWithFrameAndCheck:CGRectMake(0, 0, 32, 32) checked:celebPack];
    
    if([self AllPacksOff]){
        defaultPack = YES;
        [settings setBool:defaultPack forKey:DEFAULT_PACK_S];
    }
    [self.DefaultSearchPackCheck initWithFrameAndCheck:CGRectMake(0, 0, 32, 32) checked:defaultPack];
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
            settings = [NSUserDefaults standardUserDefaults];
            [settings setBool:popPack forKey:POP_PACK_S];
        }else{
            popPack = YES;
            
            [self ShowAllPackOffAlert];
        }
    }else{
        if ([SKPaymentQueue canMakePayments]) {
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
            settings = [NSUserDefaults standardUserDefaults];
            [settings setBool:celebPack forKey:CELEB_PACK_S];
        }else{
            celebPack = YES;
            
            [self ShowAllPackOffAlert];
        }
    }else{
        if ([SKPaymentQueue canMakePayments]) {
            // Display a store to the user.
            //have a popup "buy this search pack? 99c
            celebPackPurchase = [CelebPackPurchases alloc];
            [celebPackPurchase ShowAlert: myProducts];
        } else {
            [self ShowPaymentsTurnedOffAlert];
        }
    }

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

@end
