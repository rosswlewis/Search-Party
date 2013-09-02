//
//  GameCenterHelper.m
//  Search Party
//
//  Created by Ross Lewis on 7/17/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "GameCenterHelper.h"

@implementation GameCenterHelper

@synthesize gameCenterAvailable;
@synthesize earnedAchievementCache;

#pragma mark Initialization

static GameCenterHelper *sharedHelper = nil;
+ (GameCenterHelper *) sharedInstance {
    if (!sharedHelper) {
        sharedHelper = [[GameCenterHelper alloc] init];
    }
    return sharedHelper;
}

- (BOOL)isGameCenterAvailable {
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

- (id)init {
    if ((self = [super init])) {
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc =
            [NSNotificationCenter defaultCenter];
            [nc addObserver:self
                   selector:@selector(authenticationChanged)
                       name:GKPlayerAuthenticationDidChangeNotificationName
                     object:nil];
        }
    }
    return self;
}

- (void)authenticationChanged {
    
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        userAuthenticated = TRUE;
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated");
        userAuthenticated = FALSE;
    }
}

#pragma mark User functions

- (void)authenticateLocalUser {
    
    if (!gameCenterAvailable) return;
    
    NSLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated == NO) {
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
    } else {
        NSLog(@"Already authenticated!");
    }
}

- (void) reportScore: (int) score forCategory: (NSString*) category
{
	GKScore *scoreReporter = [[GKScore alloc] initWithCategory:category];
	scoreReporter.value = score;
	[scoreReporter reportScoreWithCompletionHandler: ^(NSError *error)
	 {
		 [self callDelegateOnMainThread: @selector(scoreReported:) withArg: NULL error: error];
	 }];
}
- (void) callDelegateOnMainThread: (SEL) selector withArg: (id) arg error: (NSError*) err
{
	dispatch_async(dispatch_get_main_queue(), ^(void)
                   {
                       [self callDelegate: selector withArg: arg error: err];
                   });
}
- (void) callDelegate: (SEL) selector withArg: (id) arg error: (NSError*) err
{
	assert([NSThread isMainThread]);
	if([delegate respondsToSelector: selector])
	{
		if(arg != NULL)
		{
			[delegate performSelector: selector withObject: arg withObject: err];
		}
		else
		{
			[delegate performSelector: selector withObject: err];
		}
	}
	else
	{
		NSLog(@"Missed Method");
	}
}

- (void) submitAchievement: (NSString*) identifier percentComplete: (double) percentComplete
{
	//GameCenter check for duplicate achievements when the achievement is submitted, but if you only want to report
	// new achievements to the user, then you need to check if it's been earned
	// before you submit.  Otherwise you'll end up with a race condition between loadAchievementsWithCompletionHandler
	// and reportAchievementWithCompletionHandler.  To avoid this, we fetch the current achievement list once,
	// then cache it and keep it updated with any new achievements.
	if(self.earnedAchievementCache == NULL)
	{
		[GKAchievement loadAchievementsWithCompletionHandler: ^(NSArray *scores, NSError *error)
         {
             if(error == NULL)
             {
                 NSMutableDictionary* tempCache= [NSMutableDictionary dictionaryWithCapacity: [scores count]];
                 for (GKAchievement* score in scores)
                 {
                     [tempCache setObject: score forKey: score.identifier];
                 }
                 self.earnedAchievementCache= tempCache;
                 [self submitAchievement: identifier percentComplete: percentComplete];
             }
             else
             {
                 //Something broke loading the achievement list.  Error out, and we'll try again the next time achievements submit.
                 [self callDelegateOnMainThread: @selector(achievementSubmitted:error:) withArg: NULL error: error];
             }
             
         }];
	}
	else
	{
        //Search the list for the ID we're using...
		GKAchievement* achievement= [self.earnedAchievementCache objectForKey: identifier];
		if(achievement != NULL)
		{
			if((achievement.percentComplete >= 100.0) || (achievement.percentComplete >= percentComplete))
			{
				//Achievement has already been earned so we're done.
				achievement= NULL;
			}
			achievement.percentComplete= percentComplete;
		}
		else
		{
			achievement= [[GKAchievement alloc] initWithIdentifier: identifier];
			achievement.percentComplete= percentComplete;
			//Add achievement to achievement cache...
			[self.earnedAchievementCache setObject: achievement forKey: achievement.identifier];
		}
		if(achievement!= NULL)
		{
			//Submit the Achievement...
            if (achievement.percentComplete>=100) {
                //show banner
                achievement.showsCompletionBanner = YES; //only in IOS 5+
            }
            
			[achievement reportAchievementWithCompletionHandler: ^(NSError *error)
             {
				 [self callDelegateOnMainThread: @selector(achievementSubmitted:error:) withArg: achievement error: error];
             }];
		}
	}
}

- (void) resetAchievements
{
	self.earnedAchievementCache= NULL;
	[GKAchievement resetAchievementsWithCompletionHandler: ^(NSError *error) 
     {
		 [self callDelegateOnMainThread: @selector(achievementResetResult:) withArg: NULL error: error];
     }];
}

- (void) achievementSubmitted: (GKAchievement*) ach error:(NSError*) error;
{
    if((error == NULL) && (ach != NULL))
    {
//        if (ach.percentComplete == 100.0) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Achievement Earned!"
//                                                            message:(@"%@",ach.identifier)
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            [alert show];
//        }
    }
    else
    {
        // Achievement Submission Failed.
    }
}

@end
