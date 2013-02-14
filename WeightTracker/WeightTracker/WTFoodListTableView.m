//
//  WTFoodListTableView.m
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/11/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import "WTFoodListTableViewCell.h"
#import "WTFoodListTableView.h"

@implementation WTFoodListTableView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
