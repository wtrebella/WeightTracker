//
//  WTCalorieData.h
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/16/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kCalorieTypeFood,
    kCalorieTypeExercise,
    kCalorieTypeAuto
} CalorieType;

@interface WTCalorieData : NSObject <NSCoding>

@property (nonatomic) CalorieType type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) int numCalories;

- (id) initWithName:(NSString *)name numCalories:(int)numCalories type:(CalorieType)type;

@end