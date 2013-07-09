//
//  SearchCheckBox.m
//  Search Party
//
//  Created by Ross Lewis on 4/29/13.
//  Copyright (c) 2013 Ross Lewis. All rights reserved.
//

#import "SearchCheckBox.h"

@implementation SearchCheckBox
@synthesize isChecked;

- (id)initWithFrameAndCheck:(CGRect)frame checked:(BOOL) check {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        
        //self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        if(check){
            //@"Very-Basic-Checked-checkbox-icon.png"
            [self setImage:[UIImage imageNamed:
                            @"On_check.png"]
                  forState:UIControlStateNormal];
        }else{
            //@"Very-Basic-Unchecked-checkbox-icon.png"
            [self setImage:[UIImage imageNamed:
                            @"off_check.png"]
                  forState:UIControlStateNormal];
        }
        self.isChecked = check;
        //[self addTarget:self action:@selector(checkBoxClicked)forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(IBAction) checkBoxClicked{
    if(self.isChecked ==NO){
        self.isChecked =YES;
        [self setImage:[UIImage imageNamed:
                        @"On_check.png"]
              forState:UIControlStateNormal];
        
    }else{
        self.isChecked =NO;
        [self setImage:[UIImage imageNamed:
                        @"off_check.png"]
              forState:UIControlStateNormal];
        
    }
}

@end
