//
//  SoundEffects.m
//  Search Party
//
//  Created by Ross Lewis on 3/25/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "SoundEffects.h"

@implementation SoundEffects

-(void)PlayBackgroundMusic{
    if([self SoundOn] && !songIsPlaying){
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:BACKGROUND_SOUND ofType:MP3];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        backgroundAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        backgroundAudio.numberOfLoops = -1;//infinite
        backgroundAudio.volume = .25;
        
        [backgroundAudio play];
        songIsPlaying = YES;
    }
}

-(void)StopBackgroundMusic{
    [backgroundAudio stop];
    songIsPlaying = NO;
}

-(void)PlaySoundGameButtonSuccess{
    if([self SoundOn]){
        NSString *path = [[NSBundle mainBundle] pathForResource: SUCCESS_SOUND ofType:MP3];
        audio =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        audio.delegate = self;
        [audio play];
    }
}

-(void)PlaySoundGameButtonFailure{
    if([self SoundOn]){
        NSString *path = [[NSBundle mainBundle] pathForResource: FAILED_SOUND ofType:MP3];
        audio =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        audio.delegate = self;
        [audio play];
    }
}

-(BOOL)SoundOn{
    settings = [NSUserDefaults standardUserDefaults];
    if([settings objectForKey:SOUND_SAVE] == nil){
        return YES;
    }else{
        return [settings boolForKey:SOUND_SAVE];
    }
}

@end
