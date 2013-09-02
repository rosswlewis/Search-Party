//
//  CelebPackPurchases.h
//  Search Party
//
//  Created by Ross Lewis on 5/16/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface CelebPackPurchases : UIAlertView{
    NSArray * products;
    NSUserDefaults * settings;
    BOOL hasRestored;
}

-(void)ShowAlert: (NSArray*)myProducts;

@end
