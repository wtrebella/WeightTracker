//
//  WTEntryViewDelegate.h
//  WeightTracker
//
//  Created by Whitaker Trebella on 2/13/13.
//  Copyright (c) 2013 Whitaker Trebella. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WTEntryViewController;

@protocol WTEntryViewDelegate <NSObject>

- (void) entryViewControllerDone:(WTEntryViewController *)vc;

@end
