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
    
    todaysAutoBurntCalories = [[WTCalorieData alloc] initWithName:@"Auto Burnt Calories" numCalories:-2457 type:kCalorieTypeAuto];
    
    foodData = [[NSMutableArray alloc] initWithObjects:
             [[WTCalorieData alloc] initWithName:@"Hot Dog" numCalories:250 type:kCalorieTypeFood],
             [[WTCalorieData alloc] initWithName:@"Ice Cream" numCalories:150 type:kCalorieTypeFood],
             [[WTCalorieData alloc] initWithName:@"Food" numCalories:532 type:kCalorieTypeFood],
             [[WTCalorieData alloc] initWithName:@"Chips" numCalories:123 type:kCalorieTypeFood],
             [[WTCalorieData alloc] initWithName:@"Chocolate" numCalories:75 type:kCalorieTypeFood],
             [[WTCalorieData alloc] initWithName:@"Turkey" numCalories:124 type:kCalorieTypeFood],
             [[WTCalorieData alloc] initWithName:@"Sandwich" numCalories:632 type:kCalorieTypeFood],
             [[WTCalorieData alloc] initWithName:@"Pecans" numCalories:54 type:kCalorieTypeFood],
             [[WTCalorieData alloc] initWithName:@"Cheetos" numCalories:173 type:kCalorieTypeFood],
             nil];
    
    exerciseData = [[NSMutableArray alloc] initWithObjects:
                    [[WTCalorieData alloc] initWithName:@"Jog" numCalories:-320 type:kCalorieTypeExercise],
                    [[WTCalorieData alloc] initWithName:@"Bike" numCalories:-600 type:kCalorieTypeExercise],
                    [[WTCalorieData alloc] initWithName:@"Swing" numCalories:-360 type:kCalorieTypeExercise],
                    [[WTCalorieData alloc] initWithName:@"Swim" numCalories:-230 type:kCalorieTypeExercise],
                    nil];
    
    [foodListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[foodListTableView setsec]
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

- (void) doneButtonPressed {
    [self dismissEntryView];
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [entryView removeFromSuperview];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 25)];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sectionHeaderBackground.png"]];
    backgroundImage.frame = headerView.frame;
    [headerView addSubview: backgroundImage];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width, 25)];
    label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Futura" size:12];
    
    [headerView addSubview:label];
    return headerView;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    indexOfCurrentEditingCell = indexPath;
    [self displayEntryView];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"Auto Burnt Calories";
    else if (section == 1) return @"Food";
    else if (section == 2) return @"Exercise";
    else return nil;
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
    
    WTCalorieData *data;
    
    if (indexPath.section == 0) {
        data = todaysAutoBurntCalories;
    }
    
    else if (indexPath.section == 1) {
        data = [foodData objectAtIndex:indexPath.row];
        
    }
    else if (indexPath.section == 2) {
        data = [exerciseData objectAtIndex:indexPath.row];
    }
    
    cellLabel.text = data.name;
    
    return cell;
}

- (void) updateNameOfCell:(NSString *)name {
    WTCalorieData *data;
    
    if (indexOfCurrentEditingCell.section == 0) {
        data = [foodData objectAtIndex:indexOfCurrentEditingCell.row];
    }
    else if (indexOfCurrentEditingCell.section == 1) {
        data = [exerciseData objectAtIndex:indexOfCurrentEditingCell.row];
    }

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
    int numSections = 1;
    if ([foodData count] > 0) numSections++;
    if ([exerciseData count] > 0) numSections++;
    return numSections;
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
    if (section == 0) return 1;
    else if (section == 1) return [foodData count];
    else if (section == 2) return [exerciseData count];
    else return 0;
}

@end