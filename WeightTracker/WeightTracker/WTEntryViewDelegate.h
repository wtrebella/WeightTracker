//
//  WTEntryViewDelegate.h
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/16/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTCalorieData.h"

@protocol WTEntryViewDelegate <NSObject>

- (void) doneButtonPressed;
- (void) updateNameOfCell:(NSString *)name;
- (void) updateCalorieCount:(int)calories;
- (void) updateCalorieType:(CalorieType)type;

@end
