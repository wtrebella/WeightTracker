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

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWillBeShown:(NSNotification*)aNotification
{
    /*[UIView setAnimationsEnabled:YES];
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect finalFrame = evc.view.frame;
    finalFrame.origin = CGPointMake(0, evc.view.frame.origin.y - kbSize.height);// - [[UIApplication sharedApplication] statusBarFrame].size.height);
    
    CGRect mainFrame = self.view.frame;
    mainFrame.origin = CGPointMake(0, self.view.frame.origin.y - kbSize.height);
        
    [UIView beginAnimations:nil context:nil];
    evc.view.frame = finalFrame;
    self.view.frame = mainFrame;
    [UIView commitAnimations];*/
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    /*[UIView setAnimationsEnabled:YES];
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect finalFrame = evc.view.frame;
    finalFrame.origin = CGPointMake(0, evc.view.frame.origin.y + kbSize.height);// - [[UIApplication sharedApplication] statusBarFrame].size.height);
    
    CGRect mainFrame = self.view.frame;
    mainFrame.origin = CGPointMake(0, self.view.frame.origin.y + kbSize.height);
    
    [UIView beginAnimations:nil context:nil];
    evc.view.frame = finalFrame;
    self.view.frame = mainFrame;
    [UIView commitAnimations];*/
}

- (void) entryViewControllerDone:(WTEntryViewController *)vc {
    /*CGRect offScreenFrame = vc.view.bounds;
    offScreenFrame.origin = CGPointMake(0, evc.view.frame.origin.y + evc.view.bounds.size.height);
    
    CGRect mainFrame = self.view.frame;
    mainFrame.origin = CGPointMake(0, -[[UIApplication sharedApplication] statusBarFrame].size.height);
    
    [UIView beginAnimations:nil context:nil];
    vc.view.frame = offScreenFrame;
    self.view.frame = mainFrame;
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];*/
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    //[evc.view removeFromSuperview];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"WTEntryView" owner:nil options:nil];
    
    for (UIView *view in views) {
        if([view isKindOfClass:[UIView class]])
        {
            entryView = (WTEntryView*)view;
        }
    }
    entryView.delegate = self;

    [self.view addSubview:entryView];
    
    entryView.frame = CGRectMake(0, 200, entryView.frame.size.width, entryView.frame.size.height);
        
    /*CGRect offScreenFrame = entryView.bounds;
    offScreenFrame.origin = CGPointMake(0, CGRectGetMaxY(self.view.frame));
    entryView.frame = offScreenFrame;
    
    CGRect finalFrame = entryView.frame;
    finalFrame.origin = CGPointMake(0, entryView.frame.origin.y - entryView.bounds.size.height);// - [[UIApplication sharedApplication] statusBarFrame].size.height);
    
    CGRect mainFrame = self.view.frame;
    mainFrame.origin = CGPointMake(0, -entryView.bounds.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
    
    CGRect rectOfCellInTableView = [tableView rectForRowAtIndexPath:indexPath];

    [UIView beginAnimations:nil context:nil];
    
    tableView.contentOffset = CGPointMake(0, rectOfCellInTableView.origin.y - tableView.frame.size.height + rectOfCellInTableView.size.height);
    entryView.frame = finalFrame;
    self.view.frame = mainFrame;
    [UIView commitAnimations];*/
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return words.count;
}

@end