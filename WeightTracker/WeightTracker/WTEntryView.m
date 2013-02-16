//
//  WTEntryView.m
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/16/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import "WTEntryViewDelegate.h"
#import "WTEntryView.h"
#import "WTViewController.h"

@implementation WTEntryView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)doneButtonPressed:(id)sender {
    [self.delegate doneButtonPressed];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
