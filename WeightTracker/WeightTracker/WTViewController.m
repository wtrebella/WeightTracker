//
//  WTViewController.m
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/11/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import "WTViewController.h"
#import "WTFoodListTableViewCell.h"
#import "WTFoodListTableView.h"
#import "WTWeightDisplayView.h"
#import "WTEntryView.h"

@interface WTViewController ()

@end

@implementation WTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerForKeyboardNotifications];

    words = [[NSMutableArray alloc] initWithObjects:
             @"Hot dog",
             @"Pizza",
             @"Ice cream",
             @"Food",
             @"Chips",
             @"Chocolate",
             @"Turkey",
             @"Sandwich",
             @"Pecans",
             @"Cheetos",
             @"Soda",
             @"Jog",
             nil];
    
    [foodListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWillBeShown:(NSNotification*)aNotification
{    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect mainFrame = self.view.frame;
    mainFrame.origin = CGPointMake(0, self.view.frame.origin.y - kbSize.height + 130);
        
    [UIView beginAnimations:nil context:nil];
    self.view.frame = mainFrame;
    [UIView commitAnimations];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect mainFrame = self.view.frame;
    mainFrame.origin = CGPointMake(0, self.view.frame.origin.y + kbSize.height - 130);
    
    [UIView beginAnimations:nil context:nil];
    self.view.frame = mainFrame;
    [UIView commitAnimations];
}

- (void) doneButtonPressed {
    [self dismissEntryView];
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [entryView removeFromSuperview];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self displayEntryViewWithIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cellsss";
    
    WTFoodListTableViewCell *cell = [foodListTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {

        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"WTFoodListTableViewCell" owner:nil options:nil];
        
        for (UIView *view in views) {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell = (WTFoodListTableViewCell*)view;
            }
        }
    }

    cell.textLabel.font = [UIFont fontWithName:@"Futura" size:18];
        
    UILabel *cellLabel = (UILabel *) cell.textLabel;
    cellLabel.backgroundColor = [UIColor clearColor];
    cellLabel.textColor = [UIColor whiteColor];
    cellLabel.text = [words objectAtIndex:indexPath.row];
            
    return cell;
}

- (void) displayEntryViewWithIndexPath:(NSIndexPath *)indexPath {
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"WTEntryView" owner:nil options:nil];
    
    for (UIView *view in views) {
        if([view isKindOfClass:[UIView class]])
        {
            entryView = (WTEntryView*)view;
        }
    }
    entryView.delegate = self;
    
    [self.view addSubview:entryView];
    
    CGRect offScreenFrame = entryView.bounds;
    offScreenFrame.origin = CGPointMake(0, CGRectGetMaxY(self.view.frame));
    entryView.frame = offScreenFrame;
    
    CGRect finalFrame = entryView.frame;
    finalFrame.origin = CGPointMake(0, entryView.frame.origin.y - entryView.bounds.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height);
    
    [foodListTableView setUserInteractionEnabled:NO];
    [entryView setUserInteractionEnabled:YES];
    
    [UIView beginAnimations:nil context:nil];
    
    foodListTableView.contentOffset = CGPointMake(0, [foodListTableView rectForRowAtIndexPath:indexPath].origin.y);
    entryView.frame = finalFrame;
    [UIView commitAnimations];
}

- (void) dismissEntryView {
    [foodListTableView setUserInteractionEnabled:YES];
    CGRect offScreenFrame = entryView.bounds;
    offScreenFrame.origin = CGPointMake(0, CGRectGetMaxY(self.view.frame));
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // foodListTableView.contentOffset = CGPointMake(0, [foodListTableView rectForRowAtIndexPath:indexPath].origin.y);
    // fix this so the table view scrolls down if it's below a threshhold
    
    entryView.frame = offScreenFrame;
    [UIView commitAnimations];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return words.count;
}

@end