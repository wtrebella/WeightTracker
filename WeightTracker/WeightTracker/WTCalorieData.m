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

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.type = [aDecoder decodeIntForKey:@"type"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.numCalories = [aDecoder decodeIntForKey:@"numCalories"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:self.type forKey:@"type"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.numCalories forKey:@"numCalories"];
}

@end
