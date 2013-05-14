//
//  PopPackPurchase.m
//  Search Party
//
//  Created by Ross Lewis on 5/13/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "PopPackPurchase.h"

@implementation PopPackPurchase

-(void)ShowAlert: (NSArray*)myProducts
{
    products = myProducts;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase a pack?" message:@"Would you like to purchase the Pop Culture search pack?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        return;
    }
    else if (buttonIndex == 1) {
        //CHANGE THIS!!
        //use products
        SKProduct *selectedProduct;// = [myProducts getObjects:@"test"];//myProducts (the correct one)
        SKPayment *payment = [SKPayment paymentWithProduct:selectedProduct];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

@end
