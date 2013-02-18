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
        
    }
    return self;
}

- (IBAction) doneButtonPressed:(id)sender {
    [self.delegate doneButtonPressed];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.calorieTextField) {
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                               nil];
        [numberToolbar sizeToFit];
        self.calorieTextField.inputAccessoryView = numberToolbar;
    }
    
    else if (textField == self.nameTextField) {
        UIToolbar* nameToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        nameToolBar.barStyle = UIBarStyleBlackTranslucent;
        nameToolBar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNameKeyboard)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNameKeyboard)],
                               nil];
        [nameToolBar sizeToFit];
        self.nameTextField.inputAccessoryView = nameToolBar;
    }
}

- (void) cancelNumberPad {
    self.calorieTextField.text = self.initialCalorieString;
    [self.calorieTextField resignFirstResponder];
}

- (void) doneWithNumberPad {
    self.initialCalorieString = self.calorieTextField.text;
    [self.calorieTextField resignFirstResponder];
}

- (void) cancelNameKeyboard {
    self.nameTextField.text = self.initialNameString;
    [self.nameTextField resignFirstResponder];
}

- (void) doneWithNameKeyboard {
    self.initialNameString = self.nameTextField.text;
    [self.nameTextField resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)nameTextDidChange:(UITextField *)sender {
    [self.delegate updateNameOfCell:sender.text];
}

- (IBAction)calorieTextEditingEnded:(UITextField *)sender {
    [self.delegate updateCalorieCount:[sender.text intValue]];
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
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
