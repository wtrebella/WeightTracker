//
//  WTCalorieData.m
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/16/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import "WTCalorieData.h"

@implementation WTCalorieData

- (id) initWithName:(NSString *)name numCalories:(int)numCalories type:(CalorieType)type {
    self = [super init];
    if (self) {
        self.type = type;
        self.name = name;
        self.numCalories = numCalories;
    }
    return self;
}

@end
