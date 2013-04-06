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
    soundEffects = [[SoundEffects alloc] init];
    settings = [NSUserDefaults standardUserDefaults];
    
    //set sound switch
    if([settings objectForKey:SOUND_SAVE] == nil){
        sound = YES;
    }else{
        sound = [settings boolForKey:SOUND_SAVE];
    }
    [self.SoundSwitch setOn:sound];
    
    if(sound){
        [soundEffects PlayBackgroundMusic];
    }
    
    //set default pack switch
    if([settings objectForKey:DEFAULT_PACK] == nil){
        defaultPack = YES;
    }else{
        defaultPack = [settings boolForKey:DEFAULT_PACK];
    }
    [self.DefaultSearchPackSwitch setOn:defaultPack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SoundChanged:(id)sender {
    sound = [self.SoundSwitch isOn];
    settings = [NSUserDefaults standardUserDefaults];
    [settings setBool:sound forKey:SOUND_SAVE];
    if(sound){
        [soundEffects PlayBackgroundMusic];
    }else{
        [soundEffects StopBackgroundMusic];
    }
        
}

- (IBAction)DefaultSearchPackChanged:(id)sender {
    defaultPack = [self.DefaultSearchPackSwitch isOn];
    if(![self AllPacksOff])
    {
        settings = [NSUserDefaults standardUserDefaults];
        [settings setBool:defaultPack forKey:DEFAULT_PACK];
    }else{
        defaultPack = YES;
        [self.DefaultSearchPackSwitch setOn:defaultPack];
        [self ShowAllPackOffAlert];
    }
}

-(BOOL)AllPacksOff{
    if(!defaultPack){
        return YES;
    }
    return NO;
}

-(void) ShowAllPackOffAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALL_PACKS_OFF_TITLE
                                                    message:ALL_PACKS_OFF_MESS
                                                   delegate:nil
                                          cancelButtonTitle:ALL_PACKS_OFF_OK
                                          otherButtonTitles:nil];
    [alert show];

}

@end
