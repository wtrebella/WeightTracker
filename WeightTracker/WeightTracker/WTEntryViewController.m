//
//  WTEntryViewController.m
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/13/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import "WTEntryViewController.h"
#import "WTEntryViewDelegate.h"
#import "WTViewController.h"

@interface WTEntryViewController ()

@end

@implementation WTEntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)pressedDone:(id)sender {
    [self.delegate entryViewControllerDone:self];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
