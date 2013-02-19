//
//  WTCalendarView.m
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/11/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import "WTCalendarView.h"

@implementation WTCalendarView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.32 green:0.32 blue:0.32 alpha:1.0];
        
        self.dayButtons = [[NSMutableArray alloc] init];
        
        selectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 61)];
        selectionView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        [self addSubview:selectionView];
        
        for (int i = 0; i < 7; i++) {
            UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(6 + 44 * i, 0, 44, 61)];
            [self.dayButtons addObject:b];
            b.titleLabel.font = [UIFont fontWithName:@"Futura" size:18];
            NSString *day;
            
            switch (i) {
                case 0:
                    day = @"M";
                    break;
                case 1:
                    day = @"T";
                    break;
                case 2:
                    day = @"W";
                    break;
                case 3:
                    day = @"Th";
                    break;
                case 4:
                    day = @"F";
                    break;
                case 5:
                    day = @"Sa";
                    break;
                case 6:
                    day = @"Su";
                    break;
                    
                default:
                    break;
            }
            
            [b setTitle:day forState:UIControlStateNormal];
            b.tag = i + 2;
            [self addSubview:b];
        }
        
        [self highlightButtonForDay:2 withAnimation:NO];
    }
    return self;
}

- (void) highlightButtonForDay:(int)dayIndex withAnimation:(BOOL)withAnimation {
    CGPoint origin = CGPointMake(6 + (dayIndex - 2) * 44, 0);
    CGRect frame = CGRectMake(origin.x, origin.y, selectionView.frame.size.width, selectionView.frame.size.height);
    
    if (withAnimation) {
        //int amtMoved = (int)fabs(origin.x - selectionView.frame.origin.x) / 44;
        [UIView animateWithDuration:0.15 animations:^(void) {
            selectionView.frame = frame;
        }];
    }
    
    else {
        selectionView.frame = frame;
    }
    
    /*for (UIButton *b in self.dayButtons) b.backgroundColor = [UIColor clearColor];
    
    UIButton *b = [self.dayButtons objectAtIndex:dayIndex - 2];
    b.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];*/
    
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
