//
//  AppDelegate.h
//  Search Party
//
//  Created by Ross Lewis on 3/25/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundEffects.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    SoundEffects * soundEffects;
}

@property (strong, nonatomic) UIWindow *window;

@end
