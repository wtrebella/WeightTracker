//
//  WTEntryView.h
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/16/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WTViewController;

@interface WTEntryView : UIView <UITextFieldDelegate>

@property (strong, nonatomic) NSString *initialNameString;
@property (strong, nonatomic) NSString *initialCalorieString;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *calorieTextField;
@property WTViewController *delegate;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end
