//
//  ViewController.h
//  Search Party
//
//  Created by Ross Lewis on 3/25/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchCheckBox.h"
#import <StoreKit/StoreKit.h>
#import "MyStoreObserver.h"
#import "PopPackPurchases.h"
#import "CelebPackPurchases.h"
#import "ResetAnswers.h"
#import "DejalActivityView.h"

@interface ViewController : UIViewController
{
    NSUserDefaults * settings;
    BOOL sound;
    BOOL soundEffectsOn;
    BOOL defaultPack;
    NSNumber * incorrectAns;
    NSNumber * correctAns;
    int howLongLoading;
    
    BOOL popPack;
    BOOL popPackPurchased;
    PopPackPurchases * popPackPurchase;
    
    BOOL celebPack;
    BOOL celebPackPurchased;
    CelebPackPurchases * celebPackPurchase;
    
    SoundEffects * soundEffects;
    NSArray * myProducts;
    MyStoreObserver * observer;
    
    ResetAnswers * resetAnswers;
    
    UIImageView * backgroundImage;
}

@property (weak, nonatomic) IBOutlet UILabel *MainMenuSearchPartyText;
@property (weak, nonatomic) IBOutlet UILabel *GamePickerSearchPartyText;
@property (weak, nonatomic) IBOutlet UILabel *CorrectStaticText;
@property (weak, nonatomic) IBOutlet UILabel *IncorrectStaticText;
@property (weak, nonatomic) IBOutlet UILabel *IncorrectAnsLabel;
@property (weak, nonatomic) IBOutlet UILabel *CorrectAnsLabel;
@property (weak, nonatomic) IBOutlet SearchCheckBox *DefaultSearchPackCheck;
@property (weak, nonatomic) IBOutlet SearchCheckBox *PopSearchPackCheck;
@property (weak, nonatomic) IBOutlet SearchCheckBox *CelebritySearchPackCheck;
@property (weak, nonatomic) IBOutlet UISwitch *SoundSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *SoundEffectsSwitch;
@property (weak, nonatomic) IBOutlet UIScrollView *SettingsScroller;

//-(void)popPurchaseSuccess;
//-(void)celebPurchaseSuccess;
-(void)ResetTextValues;

- (IBAction)DefaultSearchPackChanged:(id)sender;
- (IBAction)PopSearchPackChanged:(id)sender;
- (IBAction)CelebritySearchPackChanged:(id)sender;
- (IBAction)ResetButtonPush:(id)sender;

- (IBAction)SoundChanged:(id)sender;
- (IBAction)SoundEffectsChanged:(id)sender;

@end