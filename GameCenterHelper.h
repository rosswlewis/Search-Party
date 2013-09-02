//
//  GameCenterHelper.h
//  Search Party
//
//  Created by Ross Lewis on 7/17/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@protocol GameCenterHelperDelegate <NSObject>
@optional
- (void) achievementSubmitted: (GKAchievement*) ach error:(NSError*) error;
@end

@interface GameCenterHelper : NSObject {
    BOOL gameCenterAvailable;
    @public BOOL userAuthenticated;
	NSMutableDictionary* earnedAchievementCache;
    
    id <GameCenterHelperDelegate, NSObject> delegate;
}

@property (retain) NSMutableDictionary* earnedAchievementCache;
@property (assign, readonly) BOOL gameCenterAvailable;
@property (nonatomic, assign)  id <GameCenterHelperDelegate> delegate;

+ (GameCenterHelper *)sharedInstance;
- (void)authenticateLocalUser;
- (void) reportScore: (int) score forCategory: (NSString*) category;

- (void) submitAchievement: (NSString*) identifier percentComplete: (double) percentComplete;
- (void) resetAchievements;

@end
