//
//  SearchCheckBox.h
//  Search Party
//
//  Created by Ross Lewis on 4/29/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCheckBox : UIButton {
    BOOL isChecked;
}
@property (nonatomic,assign) BOOL isChecked;
-(IBAction) checkBoxClicked;

-(id) initWithFrameAndCheck: (CGRect)frame checked:(BOOL) check;

@end
