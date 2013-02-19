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
    
    addNewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addNewButton setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
    addNewButton.frame = CGRectMake(275, 4, 35, 35);
    [addNewButton setTitle:@"+" forState:UIControlStateNormal];
    addNewButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:25];
    [addNewButton addTarget:self action:@selector(addNewButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addNewButton];
    
    isUpForKeyboard = NO;
    
    todaysAutoBurntCalories = [[WTCalorieData alloc] initWithName:@"Autoburn" numCalories:2457 type:kCalorieTypeAuto];
    
    calorieData = [[NSMutableArray alloc] initWithObjects:
            todaysAutoBurntCalories,
            /*[[WTCalorieData alloc] initWithName:@"Hot Dog" numCalories:250 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Ice Cream" numCalories:150 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Food" numCalories:532 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Chips" numCalories:123 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Chocolate" numCalories:75 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Turkey" numCalories:124 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Sandwich" numCalories:632 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Pecans" numCalories:54 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Cheetos" numCalories:173 type:kCalorieTypeFood],
            [[WTCalorieData alloc] initWithName:@"Jog" numCalories:320 type:kCalorieTypeExercise],
            [[WTCalorieData alloc] initWithName:@"Bike" numCalories:600 type:kCalorieTypeExercise],
            [[WTCalorieData alloc] initWithName:@"Swing" numCalories:360 type:kCalorieTypeExercise],
            [[WTCalorieData alloc] initWithName:@"Swim" numCalories:230 type:kCalorieTypeExercise],*/
            nil];
    
    [foodListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [self updateWeightDisplay];
}

- (void) addNewButtonPressed {
    WTCalorieData *data = [[WTCalorieData alloc] initWithName:@"Food" numCalories:0 type:kCalorieTypeFood];
    [calorieData addObject:data];
    [foodListTableView layoutIfNeeded];
    [foodListTableView reloadData];
    indexOfCurrentEditingCell = [NSIndexPath indexPathForRow:[calorieData count] - 1 inSection:0];
    [self displayEntryView];
}

- (void) didReceiveMemoryWarning
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
    if (isUpForKeyboard) return;
    
    isUpForKeyboard = YES;
    
    //NSDictionary* info = [aNotification userInfo];
    //CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect mainFrame = self.view.frame;
    mainFrame.origin = CGPointMake(0, -80);
        
    [UIView beginAnimations:nil context:nil];
    self.view.frame = mainFrame;
    [UIView commitAnimations];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    isUpForKeyboard = NO;
    
    //NSDictionary* info = [aNotification userInfo];
    //CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect mainFrame = self.view.frame;
    mainFrame.origin = CGPointMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height);
    
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
        [self updateWeightDisplay];
	}
}

- (void) doneButtonPressed {
    [self dismissEntryView];
}

- (void) animationStopped
{
    [entryView removeFromSuperview];
    for (int i = 0; i < 10; i++) [calorieData removeLastObject];
    [foodListTableView layoutIfNeeded];
    [foodListTableView reloadData];
    [foodListTableView scrollToRowAtIndexPath:indexOfCurrentEditingCell atScrollPosition:UITableViewScrollPositionBottom animated:YES];
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
    int calories = data.numCalories;
    if (data.type == kCalorieTypeExercise || data.type == kCalorieTypeAuto) calories *= -1;
    float weightChange = calories / 3500.0;
    NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", weightChange];
    if (weightChange > 0) formattedNumber = [NSString stringWithFormat:@"+%@", formattedNumber];
    formattedNumber = [NSString stringWithFormat:@"%@ lbs", formattedNumber];
    cell.weightChangeLabel.text = formattedNumber;
    if (weightChange > 0) cell.weightChangeLabel.textColor = [UIColor colorWithRed:226.0/255.0 green:22.0/255.0 blue:61.0/255.0 alpha:1.0];
    else if (weightChange < 0) cell.weightChangeLabel.textColor = [UIColor colorWithRed:18.0/255.0 green:191.0/255.0 blue:10.0/255.0 alpha:1.0];
    else cell.weightChangeLabel.text = @"";
    
    return cell;
}

- (void) updateWeightDisplay {
    int totalCalories = 0;
    for (int i = 0; i < [calorieData count]; i++) {
        WTCalorieData *data = [calorieData objectAtIndex:i];
        int calories = data.numCalories;
        if (data.type == kCalorieTypeExercise || data.type == kCalorieTypeAuto) calories *= -1;
        totalCalories += calories;
    }
    
    float weightChange = totalCalories / 3500.0;
    NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", weightChange];
    if (weightChange > 0) formattedNumber = [NSString stringWithFormat:@"+%@", formattedNumber];
    formattedNumber = [NSString stringWithFormat:@"%@ lbs", formattedNumber];
    weightDisplayView.mainLabel.text = formattedNumber;
    if (weightChange > 0) weightDisplayView.mainLabel.textColor = [UIColor colorWithRed:226.0/255.0 green:22.0/255.0 blue:61.0/255.0 alpha:1.0];
    else if (weightChange < 0) weightDisplayView.mainLabel.textColor = [UIColor colorWithRed:18.0/255.0 green:191.0/255.0 blue:10.0/255.0 alpha:1.0];
    else weightDisplayView.mainLabel.textColor = [UIColor cyanColor];
    
    weightDisplayView.caloriesLeftLabel.text = [NSString stringWithFormat:@"Calories left to maintain weight: %i", totalCalories * -1];
}

- (void) updateNameOfCell:(NSString *)name {
    WTCalorieData *data = [calorieData objectAtIndex:indexOfCurrentEditingCell.row];
    data.name = name;
    [foodListTableView reloadData];
    [self updateWeightDisplay];
}

- (void) updateCalorieCount:(int)calories {
    WTCalorieData *data = [calorieData objectAtIndex:indexOfCurrentEditingCell.row];
    data.numCalories = calories;
    [foodListTableView reloadData];
    [self updateWeightDisplay];
}

- (void) updateCalorieType:(CalorieType)type {
    WTCalorieData *data = [calorieData objectAtIndex:indexOfCurrentEditingCell.row];
    data.type = type;
    [foodListTableView reloadData];
}

- (void) displayEntryView {
    WTCalorieData *data = [calorieData objectAtIndex:indexOfCurrentEditingCell.row];
    
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"WTEntryView" owner:nil options:nil];
    
    for (UIView *view in views) {
        if([view isKindOfClass:[UIView class]])
        {
            entryView = (WTEntryView*)view;
        }
    }
    entryView.delegate = self;
    entryView.nameTextField.text = data.name;
    entryView.calorieTextField.text = [NSString stringWithFormat:@"%i", data.numCalories];
    entryView.initialNameString = data.name;
    entryView.initialCalorieString = [NSString stringWithFormat:@"%i", data.numCalories];
    
    [self.view addSubview:entryView];
    
    CGRect offScreenFrame = entryView.bounds;
    offScreenFrame.origin = CGPointMake(0, CGRectGetMaxY(self.view.frame) - [[UIApplication sharedApplication] statusBarFrame].size.height);
    entryView.frame = offScreenFrame;
    
    CGRect finalFrame = entryView.frame;
    finalFrame.origin = CGPointMake(0, entryView.frame.origin.y - entryView.bounds.size.height);
    
    [foodListTableView setUserInteractionEnabled:NO];
    [addNewButton setUserInteractionEnabled:NO];
    [entryView setUserInteractionEnabled:YES];
    
    for (int i = 0; i < 10; i++) [calorieData addObject:[[WTCalorieData alloc] initWithName:nil numCalories:0 type:kCalorieTypeFood]];
    
    [foodListTableView reloadData];
    [foodListTableView layoutIfNeeded];
    
    [foodListTableView scrollToRowAtIndexPath:indexOfCurrentEditingCell atScrollPosition:UITableViewScrollPositionTop animated:YES];

    [UIView beginAnimations:nil context:nil];
    entryView.frame = finalFrame;
    [UIView commitAnimations];
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat) foodListViewHeight
{
    [foodListTableView reloadData];
    [foodListTableView layoutIfNeeded];
    return [foodListTableView contentSize].height;
}

- (void) dismissEntryView {
    [foodListTableView setUserInteractionEnabled:YES];
    [addNewButton setUserInteractionEnabled:YES];
    
    CGRect offScreenFrame = entryView.bounds;
    offScreenFrame.origin = CGPointMake(0, CGRectGetMaxY(self.view.frame));
    
    [foodListTableView layoutIfNeeded];
    [foodListTableView reloadData];

    [foodListTableView scrollToRowAtIndexPath:indexOfCurrentEditingCell atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    [UIView animateWithDuration:0.4 animations:^(void) {
        entryView.frame = offScreenFrame;
    }completion:^(BOOL finished) {
        [entryView removeFromSuperview];
        for (int i = 0; i < 10; i++) [calorieData removeLastObject];
        [foodListTableView layoutIfNeeded];
        [foodListTableView reloadData];
        [foodListTableView scrollToRowAtIndexPath:indexOfCurrentEditingCell atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [calorieData count];
}

@end