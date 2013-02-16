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

@interface WTViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, WTEntryViewDelegate> {
    IBOutlet WTFoodListTableView *foodListTableView;
    IBOutlet WTWeightDisplayView *weightDisplayView;
    
    WTEntryView *entryView;
    NSMutableArray *words;
}

@end
