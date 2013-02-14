//
//  WTViewController.h
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/11/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTEntryViewDelegate.h"

@class WTEntryViewController;
@class WTFoodListTableView;
@class WTWeightDisplayView;

@interface WTViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, WTEntryViewDelegate> {
    IBOutlet WTFoodListTableView *foodListTableView;
    IBOutlet WTWeightDisplayView *weightDisplayView;
    
    WTEntryViewController *evc;
    NSMutableArray *words;
}

@end
