//
//  WTWeightDisplayView.h
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/11/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WTViewController;

@interface WTWeightDisplayView : UIScrollView <UIGestureRecognizerDelegate> {
    UITapGestureRecognizer *tapGesture;
}

@property (weak, nonatomic) WTViewController *viewControllerDelegate;
@property (strong, nonatomic) UILabel *mainLabel;
@property (strong, nonatomic) UILabel *caloriesLeftLabel;
@property (strong, nonatomic) UILabel *dayLabel;

@end
