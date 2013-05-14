//
//  PopPackPurchases.h
//  Search Party
//
//  Created by Ross Lewis on 5/13/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface PopPackPurchases : UIAlertView{
    NSArray * products;
}

-(void)ShowAlert: (NSArray*)myProducts;

@end
