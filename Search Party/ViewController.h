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

@interface ViewController : UIViewController
{
    NSUserDefaults * settings;
    BOOL sound;
    BOOL soundEffectsOn;
    BOOL defaultPack;
    
    BOOL popPack;
    BOOL popPackPurchased;
    PopPackPurchases * popPackPurchase;
    
    BOOL celebPack;
    BOOL celebPackPurchased;
    CelebPackPurchases * celebPackPurchase;
    
    SoundEffects * soundEffects;
    NSArray *myProducts;
    MyStoreObserver * observer;
    
}

@property (weak, nonatomic) IBOutlet SearchCheckBox *DefaultSearchPackCheck;
@property (weak, nonatomic) IBOutlet SearchCheckBox *PopSearchPackCheck;
@property (weak, nonatomic) IBOutlet SearchCheckBox *CelebritySearchPackCheck;
@property (weak, nonatomic) IBOutlet UISwitch *SoundSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *SoundEffectsSwitch;
@property (weak, nonatomic) IBOutlet UIScrollView *SettingsScroller;

- (IBAction)DefaultSearchPackChanged:(id)sender;
- (IBAction)PopSearchPackChanged:(id)sender;
- (IBAction)CelebritySearchPackChanged:(id)sender;

- (IBAction)SoundChanged:(id)sender;
- (IBAction)SoundEffectsChanged:(id)sender;

@end