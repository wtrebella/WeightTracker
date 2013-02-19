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
#import "WTCalendarView.h"

@interface WTViewController ()

@end

@implementation WTViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self registerForKeyboardNotifications];
    
    selectedDay = [self getToday];
    
    weekCalorieData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i++) [weekCalorieData addObject:[[NSMutableArray alloc] initWithObjects:[[WTCalorieData alloc] initWithName:@"Autoburn" numCalories:2457 type:kCalorieTypeAuto], nil]];
    
    addNewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addNewButton setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
    addNewButton.frame = CGRectMake(275, 4, 35, 35);
    [addNewButton setTitle:@"+" forState:UIControlStateNormal];
    addNewButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:25];
    [addNewButton addTarget:self action:@selector(addNewButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addNewButton];
    
    isUpForKeyboard = NO;
    
    [foodListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [self setDay:selectedDay withAnimation:NO];
    
    for (int i = 0; i < 7; i++) {
        UIButton *b = [calendarView.dayButtons objectAtIndex:i];
        [b addTarget:self action:@selector(dayButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self updateWeightDisplay];
}

- (int) getToday {
    return 8;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    return [comps weekday];
}

- (void) dayButtonPressed:(UIButton *)sender {
    if (sender.tag > [self getToday]) return;
    [self setDay:sender.tag withAnimation:YES];
}

- (void) setDay:(int)dayIndex withAnimation:(BOOL)withAnimation {
    selectedDay = dayIndex;
    calorieData = [weekCalorieData objectAtIndex:selectedDay - 2];
    [calendarView highlightButtonForDay:selectedDay withAnimation:withAnimation];
    [foodListTableView reloadData];
    [foodListTableView layoutIfNeeded];
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

- (void) registerForKeyboardNotifications
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

- (void) keyboardWillBeHidden:(NSNotification*)aNotification
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

- (int) netCaloriesForDay:(int)dayIndex {
    int totalCalories = 0;
    for (int i = 0; i < [calorieData count]; i++) {
        WTCalorieData *data = [calorieData objectAtIndex:i];
        int calories = data.numCalories;
        if (data.type == kCalorieTypeExercise || data.type == kCalorieTypeAuto) calories *= -1;
        totalCalories += calories;
    }
    
    return totalCalories;
}

- (NSString *) formattedStringForWeightChange:(float)weightChange {
    NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", weightChange];
    if (weightChange > 0) formattedNumber = [NSString stringWithFormat:@"+%@", formattedNumber];
    return [NSString stringWithFormat:@"%@ lbs", formattedNumber];
}

- (NSString *) formattedStringOfSelectedDaysWeightChange {
    int netCalories = [self netCaloriesForDay:selectedDay];
    float weightChange = netCalories / 3500.0;
    
    return [self formattedStringForWeightChange:weightChange];
}

- (void) updateWeightDisplay {
    int netCalories = [self netCaloriesForDay:selectedDay];
    float weightChange = netCalories / 3500.0;
    
    weightDisplayView.mainLabel.text = [self formattedStringForWeightChange:weightChange];
    if (weightChange > 0) weightDisplayView.mainLabel.textColor = [UIColor colorWithRed:226.0/255.0 green:22.0/255.0 blue:61.0/255.0 alpha:1.0];
    else if (weightChange < 0) weightDisplayView.mainLabel.textColor = [UIColor colorWithRed:18.0/255.0 green:191.0/255.0 blue:10.0/255.0 alpha:1.0];
    else weightDisplayView.mainLabel.textColor = [UIColor cyanColor];
    
    NSString *maintainString;
    
    if ([self getToday] == selectedDay) maintainString = [NSString stringWithFormat:@"Calories left to maintain weight: %i", netCalories * -1];
    else maintainString = @"";
    
    weightDisplayView.caloriesLeftLabel.text = maintainString;
    
    NSString *dayText;
    
    switch (selectedDay) {
        case 2:
            dayText = @"";
            break;
        case 3:
            dayText = @"";
            break;
        case 4:
            dayText = @"";
            break;
        case 5:
            dayText = @"";
            break;
        case 6:
            dayText = @"";
            break;
        case 7:
            dayText = @"";
            break;
        case 8:
            dayText = @"";
            break;
            
        default:
            break;
    }
    
    if (selectedDay == [self getToday]) dayText = [NSString stringWithFormat:@"%@ Today", dayText];
    weightDisplayView.dayLabel.text = dayText;
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
    [calendarView setUserInteractionEnabled:NO];
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
    [calendarView setUserInteractionEnabled:YES];
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