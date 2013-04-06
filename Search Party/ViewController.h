//
//  ViewController.h
//  Search Party
//
//  Created by Ross Lewis on 3/25/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSUserDefaults * settings;
    BOOL sound;
    BOOL defaultPack;
    SoundEffects * soundEffects;
}

@property (weak, nonatomic) IBOutlet UISwitch *SoundSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *DefaultSearchPackSwitch;

- (IBAction)DefaultSearchPackChanged:(id)sender;
- (IBAction)SoundChanged:(id)sender;


@end