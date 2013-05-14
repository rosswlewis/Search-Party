//
//  MyStoreObserver.h
//  Search Party
//
//  Created by Ross Lewis on 5/10/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface MyStoreObserver : NSObject{
    NSUserDefaults * settings;
    NSArray * products;
}
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
-(void)setProducts:(NSArray *) myProducts;

@end
