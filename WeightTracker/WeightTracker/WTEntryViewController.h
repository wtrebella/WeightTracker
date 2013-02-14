//
//  WTEntryViewController.h
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/13/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WTViewController;

@interface WTEntryViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property WTViewController *delegate;

@end
