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
        self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        mainLabel.font = [UIFont fontWithName:@"Futura" size:62];
        mainLabel.text = @"+0.08lbs";
        mainLabel.textAlignment = NSTextAlignmentCenter;
        mainLabel.shadowOffset = CGSizeMake(0, 1);
        mainLabel.backgroundColor = [UIColor clearColor];
        mainLabel.textColor = [UIColor whiteColor];//[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0f];
        [self addSubview:mainLabel];
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