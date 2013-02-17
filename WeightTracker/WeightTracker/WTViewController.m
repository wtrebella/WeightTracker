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
#import "WTCalorieData.h"

@interface WTViewController ()

@end

@implementation WTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerForKeyboardNotifications];
    
    todaysAutoBurntCalories = [[WTCalorieData alloc] initWithName:@"Autoburn" numCalories:-2457 type:kCalorieTypeAuto];
    
    calorieData = [[NSMutableArray alloc] initWithObjects:
            todaysAutoBurntCalories,
            [[WTCalorieData alloc] initWithName:@"Hot Dog" numCalories:250 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Ice Cream" numCalories:150 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Food" numCalories:532 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Chips" numCalories:123 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Chocolate" numCalories:75 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Turkey" numCalories:124 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Sandwich" numCalories:632 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Pecans" numCalories:54 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Cheetos" numCalories:173 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Jog" numCalories:-320 type:kCalorieTypeExercise],
            [[WTCalorieData alloc] initWithName:@"Bike" numCalories:-600 type:kCalorieTypeExercise],
            [[WTCalorieData alloc] initWithName:@"Swing" numCalories:-360 type:kCalorieTypeExercise],
            [[WTCalorieData alloc] initWithName:@"Swim" numCalories:-230 type:kCalorieTypeExercise],
            nil];
    
    [foodListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (!indexPath) return UITableViewCellEditingStyleNone;
    if (indexPath.row == 0) return UITableViewCellEditingStyleNone;
    if ([calorieData count] == 0) return UITableViewCellEditingStyleNone;
    return UITableViewCellEditingStyleDelete;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		[calorieData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView reloadData];
	}
}

- (void) doneButtonPressed {
    [self dismissEntryView];
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [entryView removeFromSuperview];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) return;
    indexOfCurrentEditingCell = indexPath;
    [self displayEntryView];
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

    WTCalorieData *data = [calorieData objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont fontWithName:@"Futura" size:18];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = data.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    float weightChange = data.numCalories / 3500.0;
    NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", weightChange];
    if (weightChange > 0) formattedNumber = [NSString stringWithFormat:@"+%@", formattedNumber];
    formattedNumber = [NSString stringWithFormat:@"%@ lbs", formattedNumber];
    cell.weightChangeLabel.text = formattedNumber;
    if (weightChange > 0) cell.weightChangeLabel.textColor = [UIColor redColor];
    else if (weightChange < 0) cell.weightChangeLabel.textColor = [UIColor greenColor];
    else cell.weightChangeLabel.textColor = [UIColor blueColor];
    
    return cell;
}

- (void) updateNameOfCell:(NSString *)name {
    WTCalorieData *data = [calorieData objectAtIndex:indexOfCurrentEditingCell.row];
    data.name = name;
    [foodListTableView reloadData];
}

- (void) displayEntryView {
    WTFoodListTableViewCell *cell = (WTFoodListTableViewCell *)[foodListTableView cellForRowAtIndexPath:indexOfCurrentEditingCell];
    
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"WTEntryView" owner:nil options:nil];
    
    for (UIView *view in views) {
        if([view isKindOfClass:[UIView class]])
        {
            entryView = (WTEntryView*)view;
        }
    }
    entryView.delegate = self;
    entryView.nameTextField.text = cell.textLabel.text;
    
    [self.view addSubview:entryView];
    
    CGRect offScreenFrame = entryView.bounds;
    offScreenFrame.origin = CGPointMake(0, CGRectGetMaxY(self.view.frame));
    entryView.frame = offScreenFrame;
    
    CGRect finalFrame = entryView.frame;
    finalFrame.origin = CGPointMake(0, entryView.frame.origin.y - entryView.bounds.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height);
    
    [foodListTableView setUserInteractionEnabled:NO];
    [entryView setUserInteractionEnabled:YES];
    
    [UIView beginAnimations:nil context:nil];
    
    foodListTableView.contentOffset = CGPointMake(0, [foodListTableView rectForRowAtIndexPath:indexOfCurrentEditingCell].origin.y);
    entryView.frame = finalFrame;
    [UIView commitAnimations];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat) foodListViewHeight
{
    [foodListTableView layoutIfNeeded];
    return [foodListTableView contentSize].height;
}

- (void) dismissEntryView {
    [foodListTableView setUserInteractionEnabled:YES];
    CGRect offScreenFrame = entryView.bounds;
    offScreenFrame.origin = CGPointMake(0, CGRectGetMaxY(self.view.frame));
    
    float cellPointY = [foodListTableView rectForRowAtIndexPath:indexOfCurrentEditingCell].origin.y;
    CGPoint newOffset = CGPointMake(0, cellPointY - foodListTableView.frame.size.height);
        
    if (cellPointY > [self foodListViewHeight]) newOffset.y = [self foodListViewHeight];
    
    [foodListTableView scrollToRowAtIndexPath:indexOfCurrentEditingCell atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    entryView.frame = offScreenFrame;
    [UIView commitAnimations];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [calorieData count];
}

@end