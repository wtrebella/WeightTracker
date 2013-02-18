//
//  WTViewController.h
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/11/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTEntryViewDelegate.h"

@class WTFoodListTableView;
@class WTEntryView;
@class WTWeightDisplayView;
@class WTCalorieData;

@interface WTViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, WTEntryViewDelegate> {
    IBOutlet WTFoodListTableView *foodListTableView;
    IBOutlet WTWeightDisplayView *weightDisplayView;
    
    WTCalorieData *todaysAutoBurntCalories;
    WTEntryView *entryView;
    NSMutableArray *calorieData;
    
    NSIndexPath *indexOfCurrentEditingCell;
    
    UIButton *addNewButton;
    
    BOOL isUpForKeyboard;
}

@end
