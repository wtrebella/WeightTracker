//
//  WTWeightDisplayView.m
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/11/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import "WTWeightDisplayView.h"

@implementation WTWeightDisplayView

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.mainLabel.font = [UIFont fontWithName:@"Futura" size:62];
        self.mainLabel.textAlignment = NSTextAlignmentCenter;
        self.mainLabel.shadowOffset = CGSizeMake(0, 1);
        self.mainLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.mainLabel];
        
        self.caloriesLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 45, self.frame.size.width, 45)];
        self.caloriesLeftLabel.font = [UIFont fontWithName:@"Futura" size:14];
        self.caloriesLeftLabel.text = @"Calories left to maintain weight:";
        self.caloriesLeftLabel.textAlignment = NSTextAlignmentCenter;
        self.caloriesLeftLabel.shadowOffset = CGSizeMake(0, 1);
        self.caloriesLeftLabel.backgroundColor = [UIColor clearColor];
        self.caloriesLeftLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.caloriesLeftLabel];
        
        self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45)];
        self.dayLabel.font = [UIFont fontWithName:@"Futura" size:14];
        self.dayLabel.text = @"Day";
        self.dayLabel.textAlignment = NSTextAlignmentCenter;
        self.dayLabel.shadowOffset = CGSizeMake(0, 1);
        self.dayLabel.backgroundColor = [UIColor clearColor];
        self.dayLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.dayLabel];

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
