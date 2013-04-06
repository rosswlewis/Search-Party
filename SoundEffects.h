//
//  SoundEffects.h
//  Search Party
//
//  Created by Ross Lewis on 3/25/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>

static BOOL songIsPlaying = NO;
static AVAudioPlayer * backgroundAudio;

@interface SoundEffects : NSObject <AVAudioPlayerDelegate>
{
    AVAudioPlayer * audio;
    NSUserDefaults * settings;
}

-(void)PlaySoundGameButtonSuccess;
-(void)PlaySoundGameButtonFailure;
-(void)PlayBackgroundMusic;
-(void)StopBackgroundMusic;

@end
