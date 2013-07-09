//
//  CelebPackPurchases.m
//  Search Party
//
//  Created by Ross Lewis on 5/16/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "CelebPackPurchases.h"

@implementation CelebPackPurchases

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
 */

-(void)ShowAlert: (NSArray*)myProducts
{
    products = myProducts;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase a pack?" message:@"Would you like to purchase the Celebrity search pack?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        return;
    }
    else if (buttonIndex == 1) {
        //CHANGE THIS!!
        //use products
        SKProduct *selectedProduct = nil;
        for(SKProduct * prod in products)
        {
            if([[prod productIdentifier] isEqual: CELEB_PACK_IDENTIFIER])
            {
                selectedProduct = prod;
            }
        }
        if(selectedProduct != nil){
            SKPayment *payment = [SKPayment paymentWithProduct:selectedProduct];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                            message:@"Darn it!  There was an error with the purchase.  Please try again!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

@end