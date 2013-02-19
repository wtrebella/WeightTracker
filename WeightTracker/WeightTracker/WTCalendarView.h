//
//  WTCalendarView.h
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/11/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTCalendarView : UIView {
    UIView *selectionView;
}

@property (strong, nonatomic) NSMutableArray *dayButtons;

- (void) highlightButtonForDay:(int)dayIndex withAnimation:(BOOL)withAnimation;

@end
