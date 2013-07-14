//
//  MyStoreObserver.h
//  Search Party
//
//  Created by Ross Lewis on 5/10/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@class ViewController;

@interface MyStoreObserver : NSObject{
    NSUserDefaults * settings;
    NSArray * products;
    
    //ViewController * viewController;
}

//@property (nonatomic, assign) id <storeObserverDelegate> delegate;

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
-(void)setProducts:(NSArray *) myProducts CorrectViewController:(ViewController *) correctViewController;

@end