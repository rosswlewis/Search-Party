//
//  OpenSearchInGoogle.h
//  Search Party
//
//  Created by Ross Lewis on 8/6/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenSearchInGoogle : UIAlertView{
    NSString * theSearch;
}

-(void)ShowAlertWithQuery:(NSString *)query;

@end
