//
//  MyStoreObserver.m
//  Search Party
//
//  Created by Ross Lewis on 5/10/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "MyStoreObserver.h"

@implementation MyStoreObserver

-(void)setProducts:(NSArray *)myProducts{
    products = myProducts;
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    if([transaction.originalTransaction.payment.productIdentifier isEqual: POP_PACK_IDENTIFIER]){
        [self updateUserDefaultsAfterPurchase:POP_PACK_PURCHASED_S];
        //CALL BUTTON CLICK IN VIEW CONTROLLER
        [self showPopupForPurchaseSuccess];
    }else if([transaction.originalTransaction.payment.productIdentifier isEqual: CELEB_PACK_IDENTIFIER]){
        [self updateUserDefaultsAfterPurchase:CELEB_PACK_PURCHASED_S];
        //CALL BUTTON CLICK IN VIEW CONTROLLER
        [self showPopupForPurchaseSuccess];
    }
    
    // Remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled) {
        // Optionally, display an error here.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"An error has occured"
                                                        message:@"Sorry!  Your purchase could not be made at this time."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    //use the transaction to call the right function (transaction should have the product identifier)
    if([transaction.originalTransaction.payment.productIdentifier isEqual: POP_PACK_IDENTIFIER]){
        [self updateUserDefaultsAfterPurchase:POP_PACK_PURCHASED_S];
        //CALL BUTTON CLICK IN VIEW CONTROLLER
        [self showPopupForPurchaseSuccess];
    }else if([transaction.originalTransaction.payment.productIdentifier isEqual: CELEB_PACK_IDENTIFIER]){
        [self updateUserDefaultsAfterPurchase:CELEB_PACK_PURCHASED_S];
        //CALL BUTTON CLICK IN VIEW CONTROLLER
        [self showPopupForPurchaseSuccess];
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) showPopupForPurchaseSuccess{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                    message:@"You got it!  Your purchase is complete!  Go ahead and select your search pack to use it."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) updateUserDefaultsAfterPurchase: (NSString*) plistKey
{
    settings = [NSUserDefaults standardUserDefaults];
    [settings setBool:YES forKey:plistKey];
}

@end
