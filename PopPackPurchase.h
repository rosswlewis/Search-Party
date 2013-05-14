//
//  PopPackPurchase.h
//  Search Party
//
//  Created by Ross Lewis on 5/13/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface PopPackPurchase : NSObject <UIAlertViewDelegate>{
    NSArray * products;
}

-(void)ShowAlert: (NSArray*)myProducts;

@end
